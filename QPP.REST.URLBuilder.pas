unit QPP.REST.URLBuilder;

interface

type
  TURLBuilder = class
  strict private
    FHostAddress: string;
    FHostPort: Word;
    FLogin, FPassword: string;
//    FRESTService: string;
//    function GetBaseURL: string;
//    function GetCredentials: string;
  public
    property HostAddress: string read FHostAddress write FHostAddress;
    property HostPort: Word read FHostPort write FHostPort;
    property Login: string read FLogin write FLogin;
    property Password: string read FPassword write FPassword;
//    FRESTService: string;
    function GetBaseURL: string;
    function GetCredentials: string;
  end;


implementation

uses
  System.SysUtils;

function TURLBuilder.GetBaseURL: string;
begin
  Result := Format('http://%s/rest/service/', [FHostAddress, FHostPort]);
end;

function TURLBuilder.GetCredentials: string;
begin
  Result := Format('loginname=%s&loginpassword=%s', [FLogin, FPassword]);
end;

end.
