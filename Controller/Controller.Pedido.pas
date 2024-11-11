unit Controller.Pedido;

interface

uses
  Model.Cliente, Model.Pedido, Model.Produto, Model.PedidoItem,
  system.Generics.Collections,
  system.SysUtils, system.Variants, Data.DB;

  type
  TControllerPedido = class
  private
     FModelPedido  : TPedidos;
    public
      aResArray: TResultadoArray;
      constructor Create;
      destructor Destroy; override;
      function localizarProduto(nProduto: Integer): TResultadoArray;
      function LocalizarPedido(nPedido:Integer):TDataSet;
      function localizarCliente(aCliente:Integer):String;
      function CancelarPedido(nPedido:Integer):Boolean;
      function salvarPedido(nPedido:Integer; nCliente: Integer;FItensPedido:TObjectList<TModelPedidoItem> ):Integer;
      property ModelPedido :TPedidos read FModelPedido  write FModelPedido;

  end;



implementation

{ TPedidoGeraisController }


function TControllerPedido.CancelarPedido(nPedido: Integer): Boolean;
begin
  result := FModelPedido.CancelarPedido(nPedido);
end;

constructor TControllerPedido.Create;
begin
  FModelPedido  := TPedidos.Create;

inherited Create;
end;

destructor TControllerPedido.Destroy;
begin
   FModelPedido.Free;
inherited;
end;



function TControllerPedido.localizarCliente(aCliente: Integer): String;
begin

  result := FModelPedido.localizarCliente(aCliente);

end;

function TControllerPedido.LocalizarPedido(nPedido: Integer): TDataSet;
var
ResultDataSet : TDataSet;
begin
  ResultDataSet := FModelPedido.LocalizarPedido(nPedido);
  if (ResultDataSet <> nil) then
  begin
    result :=  ResultDataSet
  end
  else
    result := nil



end;

function TControllerPedido.localizarProduto(nProduto: Integer): TResultadoArray;
var
TempResult :   TResultadoArray;
ResultArray:   TResultadoArray;
begin

  SetLength(TempResult, 2);
  TempResult  := FModelPedido.localizarProduto(nProduto);
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


function TControllerPedido.salvarPedido(nPedido, nCliente: Integer;
  FItensPedido: TObjectList<TModelPedidoItem>): Integer;
begin

   result := FModelPedido.salvarPedido(nPedido,nCliente,FItensPedido);

end;

end.