unit Model.Pedido;

interface

uses
  System.Generics.Collections,  DAOPedidos, Model.PedidoItem, Data.DB,
  System.SysUtils;


type
  TResultadoArray = array of variant;

type
  TPedidos = Class
  private
    FDaoPedidos : TDaoPedidos;
    FValorTotal: Double;
    FDataEmissao: TDateTime;
    FNumeroPedido: Integer;
    FCodigocliente_id: Integer;
    procedure SetCodigocliente_id(const Value: Integer);
    procedure SetDataEmissao(const Value: TDateTime);
    procedure SetNumeroPedido(const Value: Integer);
    procedure SetValorTotal(const Value: Double);
   public
    aResArray : TResultadoArray ;
   constructor Create;
   destructor Destroy; override;

   function salvarPedido(nPedido:Integer; nCliente: Integer;FItensPedido:TObjectList<TModelPedidoItem> ):Integer;
   function localizarProduto(nProduto: Integer):TResultadoArray;
   function localizarCliente(aCliente: Integer):String;
   function LocalizarPedido(nPedido:Integer):TDataSet;
   function CancelarPedido(nPedido:Integer):Boolean;

   property NumeroPedido    : Integer   read FNumeroPedido     write SetNumeroPedido;
   property DataEmissao     : TDateTime read FDataEmissao      write SetDataEmissao;
   property Codigocliente_id: Integer   read FCodigocliente_id write SetCodigocliente_id;
   property ValorTotal      : Double    read FValorTotal       write SetValorTotal;
End;

implementation

{ TPedidos }


function TPedidos.CancelarPedido(nPedido: Integer): Boolean;
begin
   result :=   FDaoPedidos.CancelarPedido(nPedido);
end;

constructor TPedidos.Create;
begin
 FDaoPedidos := TDaoPedidos.Create;
  inherited create;
 end;

destructor TPedidos.Destroy;
begin
 freeAndnil(FDaoPedidos);
 inherited;
end;

function TPedidos.localizarCliente(aCliente: Integer): String;
begin

    result := FDaoPedidos.localizarCliente(aCliente);

end;

function TPedidos.LocalizarPedido(nPedido: Integer): TDataSet;
begin
    result :=  FDaoPedidos.LocalizarPedido(nPedido);
end;

function TPedidos.localizarProduto(nProduto: Integer): TResultadoArray;
var
TempResult:  TResultArray;
ResultArray: TResultadoArray;
begin
  SetLength(TempResult, 2);
  TempResult:= FDaoPedidos.localizarProduto(nProduto);
 // if (FDaoPedidos.localizarProduto(nProduto) <> nil) then
  if Length(TempResult) > 0 then
  begin
    SetLength(ResultArray, 2);
    ResultArray[0] := TempResult[0] ;
    ResultArray[1] := TempResult[1] ;
    result := ResultArray;
  end
  else
    result := nil;
end;

function TPedidos.salvarPedido(nPedido, nCliente: Integer;
  FItensPedido: TObjectList<TModelPedidoItem>): Integer;
begin

   result := FDaoPedidos.salvarPedido(nPedido,nCliente, FItensPedido);

end;

procedure TPedidos.SetCodigocliente_id(const Value: Integer);
begin
  FCodigocliente_id := Value;
end;

procedure TPedidos.SetDataEmissao(const Value: TDateTime);
begin
  FDataEmissao := Value;
end;


procedure TPedidos.SetNumeroPedido(const Value: Integer);
begin
  FNumeroPedido := Value;
end;

procedure TPedidos.SetValorTotal(const Value: Double);
begin
  FValorTotal := Value;
end;

end.