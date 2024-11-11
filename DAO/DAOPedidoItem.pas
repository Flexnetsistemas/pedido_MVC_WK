unit DAOPedidoItem;

interface

uses
  Controller.Conexao,
  Model.PedidoItem,
  system.SysUtils,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client;

type
  TDaoPedidoItem  = Class
  private
  public
   constructor Create;
   destructor Destroy; Override;

   function   calcularSubTotal :Double;
   function   editarItem       :TFDQuery;
   function  incluirItem(Item:TModelPedidoItem):Boolean;


  End;

implementation

{ TDAOPedidoItem }



function TDAOPedidoItem.calcularSubTotal: Double;
begin

end;

constructor TDAOPedidoItem.Create;
begin

end;

destructor TDAOPedidoItem.Destroy;
begin

  inherited;
end;

function TDAOPedidoItem.editarItem: TFDQuery;
begin

end;

function TDAOPedidoItem.incluirItem(Item: TModelPedidoItem): Boolean;
var
  qyItem: TFDQuery;
 begin
  qyItem := TControllerConexao.getInstancia().daoConexao.getQuery;
  try
    qyItem.SQL.Text := 'insert into pedidoprodutos (numeropedido_id, codigoproduto, quantidade, vlrunitario, vlrtotal, descricao) values(:npedido,:npro,:nqtde,:nvlrun, :nvlrtotal,:vdescricao)';
    qyItem.ParamByName('npedido').AsInteger := Item.Numeropedido_id;
    qyItem.ParamByName('npro').AsInteger := Item.CodigoProduto;
    qyItem.ParamByName('nqtde').AsFloat := Item.Qtde;
    qyItem.ParamByName('nvlrun').AsFloat := Item.VlrUnitario;
    qyItem.ParamByName('nvlrtotal').AsFloat := Item.VlrTotal;
    qyItem.ParamByName('vdescricao').AsString := Item.Descricao;
    qyItem.Prepare;
    qyItem.ExecSQL;
    result := true;
  except
    on E: Exception do
    begin
     result := false;
    end;
  end;
  qyItem.Free;
end;


end.
