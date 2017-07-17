program FormsTool;

uses
  Vcl.Forms,
  Main in 'Main.pas' {Form1},
  QPP.REST.URLBuilder in 'QPP.REST.URLBuilder.pas',
  FormCleaner in 'FormCleaner.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
