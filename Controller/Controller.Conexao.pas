unit Controller.Conexao;

interface

 uses
   DAOConexao;

Type
  TControllerConexao = class
    private
     FConexao: TDaoConector;
    public
      constructor create;
      destructor destroy;override;
      property daoConexao :TDaoConector read FConexao write FConexao;
      class function getInstancia : TControllerConexao;
      class procedure Finalize;
  end;

implementation

var
  Instancia: TControllerConexao;

{ TControllerConexao }

constructor TControllerConexao.create;
begin

 FConexao := TDaoConector.Create;
 inherited create;
end;

destructor TControllerConexao.destroy;
begin

inherited destroy;

end;

class function TControllerConexao.getInstancia: TControllerConexao;
begin

   if not Assigned(Instancia) then
    Instancia := TControllerConexao.Create;

   result := Instancia;

end;



class procedure TControllerConexao.Finalize;
begin
  if Assigned(Instancia) then
  begin
    Instancia.Free;
    Instancia := nil;

  end;
end;

end.


