unit DAOConexao;

interface

uses
  system.IniFiles, System.SysUtils,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef;

type
  TDAOConector = class
  private
   Conexao      : TFDConnection;
   FDTransaction: TFDTransaction;
   FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink;
   Query   :  TFDQuery;
   DriverID : String;
   Usuario  : String;
   Senha    : String;
   Server   : String;
   Database : String;
   Porta    : String;
  public
  constructor Create;
  destructor  Destroy;override;

  function Conectar : TFDConnection;
  function getQuery : TFDQuery;

 end;

implementation

{ TDAOConector }

function TDAOConector.Conectar: TFDConnection;
var
 lPathVendor     :String;
begin
 Conexao               := TFDConnection.Create(nil);
 FDTransaction         := TFDTransaction.Create(nil);
 FDPhysMySQLDriverLink := TFDPhysMySQLDriverLink.Create(nil);

 try
  with Conexao do
  begin
    Params.Clear;
    Params.Values['DriverID'] := DriverID;
    Params.Values['Server']   := Server;
    Params.Values['Database'] := Database;
    Params.Values['User_name']:= Usuario;
    Params.Values['Password'] := Senha;
    Params.Values['Port']     := Porta;
    LoginPrompt := false;
    lPathVendor := ExtractFilePath(ParamStr(0));
    FDPhysMySQLDriverLink.VendorLib :=  lPathVendor+'\libmySQL.dll';
    Transaction := FDTransaction;
    Connected   := true;
  end;
  finally
    result := Conexao;
   end;

end;

constructor TDAOConector.create;
Var
FileINI: Tinifile;
begin

 FileINI := Tinifile.Create(ExtractFilePath(ParamStr(0)) + 'config.ini');
 try
  DriverID := FileINI.ReadString('Conexao', 'DriverID',  EmptyStr);
  Usuario  := FileINI.ReadString('Conexao', 'User_name', EmptyStr);
  Senha    := FileINI.ReadString('Conexao', 'Password',  EmptyStr);
  Server   := FileINI.ReadString('Conexao', 'Server',    EmptyStr);
  Database := FileINI.ReadString('Conexao', 'Database',  EmptyStr);
  Porta    := FileINI.ReadString('Conexao', 'Port',      EmptyStr);
  Conectar;

 finally
 begin
 FreeAndNil(FileINI);
 end;

end;
end;

destructor TDAOConector.destroy;
begin

 if Assigned(Conexao) then
 begin
  Conexao.Connected := False;
  freeandnil(Conexao);
  freeandnil(FDTransaction);
  freeandnil(FDPhysMySQLDriverLink);
  freeandnil(Query);
 end;

 inherited destroy;

end;

function TDAOConector.getQuery: TFDQuery;
begin

   Query             :=  TFDQuery.Create(nil);
   Query.Connection  := Conexao;
   Query.Transaction := FDTransaction;
   result            := Query;


end;

end.
