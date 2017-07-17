unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  QPP.REST.URLBuilder,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent,
  Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    NetHTTPClient: TNetHTTPClient;
    NetHTTPRequest: TNetHTTPRequest;
    GroupBox2: TGroupBox;
    Button5: TButton;
    Button4: TButton;
    Memo1: TMemo;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    Button1: TButton;
    Button3: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure NetHTTPRequestRequestCompleted(const Sender: TObject;
      const AResponse: IHTTPResponse);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure NetHTTPRequestRequestError(const Sender: TObject;
      const AError: string);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }

    FURLBuilder: TURLBuilder;

    procedure LoadSettings;
    procedure SaveSettings;

    procedure SetupBuilder;

    procedure Log(const AInfo: string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  System.IniFiles,
  System.Net.Mime,
  FormCleaner;

const
  HTTPResponseOK = 200;
  SettingsFileName = '.\Config.ini';

procedure TForm1.Log(const AInfo: string);
begin
  Memo1.Lines.Add(Format('%s   %s', [DateTimeToStr(Now), AInfo]));
end;


procedure TForm1.SetupBuilder;
begin
  FURLBuilder.HostAddress := LabeledEdit1.Text;
  FURLBuilder.Login := LabeledEdit2.Text;
  FURLBuilder.Password := LabeledEdit3.Text;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  FRESTService: string;
begin
  SetupBuilder;

  FRESTService := 'admin/forms';
  with FURLBuilder do
    NetHTTPRequest.URL := GetBaseURL + FRESTService +
      '?getAllForms' +
      '&' + GetCredentials +
      '&' + 'workflow=' + LabeledEdit4.Text ;
//      '&' + 'contentType=' + LabeledEdit5.Text;
  NetHTTPRequest.Get(NetHTTPRequest.URL);
end;

procedure TForm1.LoadSettings;
var
  ConfigFile: TIniFile;
begin
  ConfigFile := TIniFile.Create(SettingsFileName);
  try
    with ConfigFile do
    begin
      LabeledEdit1.Text := ReadString('QPP server', 'Address', '');
      LabeledEdit2.Text := ReadString('QPP server', 'Login', '');
      LabeledEdit3.Text := ReadString('QPP server', 'Password', '');

      LabeledEdit4.Text := ReadString('QPP server', 'Workflow', '');
      LabeledEdit5.Text := ReadString('QPP server', 'Content type', '');
    end;
  finally
    ConfigFile.Free;
  end;
end;

procedure TForm1.SaveSettings;
var
  ConfigFile: TIniFile;
begin
  ConfigFile := TIniFile.Create(SettingsFileName);
  try
    with ConfigFile do
    begin
      WriteString('QPP server', 'Address', LabeledEdit1.Text);
      WriteString('QPP server', 'Login', LabeledEdit2.Text);
      WriteString('QPP server', 'Password', LabeledEdit3.Text);

      WriteString('QPP server', 'Workflow', LabeledEdit4.Text);
      WriteString('QPP server', 'Content type', LabeledEdit5.Text);
    end;
  finally
    ConfigFile.Free;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  FRESTService: string;

  Data: TMultipartFormData;
  StringList: TStringList;
begin
  if OpenDialog.Execute then
  begin
    StringList := TStringList.Create;
    try
      StringList.LoadFromFile(OpenDialog.FileName);

      SetupBuilder;

      Data := TMultipartFormData.Create;
      Data.AddField('op', 'update');
      Data.AddField('forminfolist', StringList.Text);
      Data.AddField('loginname', FURLBuilder.Login);
      Data.AddField('loginpassword', FURLBuilder.Password);

      try
        FRESTService := 'admin/forms';
        with FURLBuilder do
          NetHTTPRequest.URL := GetBaseURL +
            FRESTService +
            '?updateForms' ;

        if NetHTTPRequest.Post(NetHTTPRequest.URL, Data, nil, nil).StatusCode = HTTPResponseOK then
          Log('Uploaded')
        else
          Log('Uploading error');
      finally
        Data.Free;
      end;

    finally
      StringList.Free;
    end;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  Stream1, Stream2: TFileStream;
begin
  if OpenDialog.Execute and SaveDialog.Execute then
  begin
    Stream1 := TFileStream.Create(OpenDialog.FileName, fmOpenRead);
    Stream2 := TFileStream.Create(SaveDialog.FileName, fmCreate);

    Stream1.Seek(0, soFromBeginning);
    Stream2.Seek(0, soFromBeginning);
    Stream2.CopyFrom(Stream1, Stream1.Size);

    FormCleaner.Clean(Stream2);

    Stream1.Free;
    Stream2.Free
  end;

  Log('Sanitized & saved');
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  LoadSettings;
  Log('Settings loaded');
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  SaveSettings;
  Log('Settings saved');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FURLBuilder := TURLBuilder.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FURLBuilder.Free;
end;

procedure TForm1.NetHTTPRequestRequestCompleted(const Sender: TObject; const AResponse: IHTTPResponse);
var
  Stream: TFileStream;
begin
  Log(Format('HTTP request completed / status code: %d', [AResponse.StatusCode]));
  if AResponse.StatusCode = HTTPResponseOK then
  begin
    if SaveDialog.Execute then
    begin
      Stream := TFileStream.Create(SaveDialog.FileName, fmCreate);
      try
        Stream.Seek(0, soFromBeginning);
        AResponse.ContentStream.Seek(0, soFromBeginning);
        Stream.CopyFrom(AResponse.ContentStream, AResponse.ContentStream.Size);
      finally
        Stream.Free;
      end;
    end;
  end;
end;

procedure TForm1.NetHTTPRequestRequestError(const Sender: TObject;
  const AError: string);
begin
  Log('HTTP request error' + sLineBreak + AError);
end;

end.
