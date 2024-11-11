unit DAOPedidos;

interface

uses
  System.Generics.Collections,  Model.PedidoItem,
  DAOConexao,  Controller.Conexao, system.SysUtils,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client;

type
  TResultArray = array of variant;
  TDAOPedidos = Class
  private
//    FItensPedido: TObjectList<TModelPedidoItem>;
    FConexao: TDAOConector;
    function ListarPedido: TFDQuery;
   public
    constructor Create;
    destructor Destroy; Override;


    function salvarPedido(aPedido:Integer; aCliente: Integer; FItensPedido:TObjectList<TModelPedidoItem> ):Integer;
    function LocalizarPedido(nPedido:Integer):TFDQuery;
    function CancelarPedido(nPedido:Integer):Boolean;
    function localizarProduto(CodProduto: Integer):TResultArray;
    function localizarCliente(aCliente: Integer):String;

    property daoConexao : TDAOConector read FConexao write FConexao;


End;

implementation

{ TDAOPedidos }



function TDAOPedidos.ListarPedido:TFDQuery;
Var
qyPedidoGeral: TFDQuery;
begin
  try
   qyPedidoGeral := TControllerConexao.getInstancia().daoConexao.getQuery;
    result := qyPedidoGeral;
   finally
    qyPedidoGeral.free;
   end;


end;

function TDAOPedidos.localizarCliente(aCliente: Integer): String;
var
  qyCliente  : TFDQuery;
begin

   qyCliente:= TControllerConexao.getInstancia.daoConexao.getQuery;

  try
    qyCliente.Transaction.StartTransaction;
    try
    qyCliente.Close;
    qyCliente.SQL.Clear;
    qyCliente.SQL.Text := 'select nome from clientes c '+
     ' where c.codigo =:pCliente';
    qyCliente.ParamByName('pCliente').AsInteger := aCliente;
    qyCliente.Prepare;
    qyCliente.Open;
    qyCliente.Transaction.Commit;
    if not  qyCliente.IsEmpty then
       result := qyCliente.FieldByName('nome').AsString
     else
      result := '';
  except
    on E: Exception do
    begin
      qyCliente.Transaction.Rollback;
      qyCliente.free;
      result := '';
      raise;
    end;
  end
  finally
   qyCliente.Free;
   TControllerConexao.Finalize;
   end;

end;

function TDAOPedidos.LocalizarPedido(nPedido: Integer): TFDQuery;
var
  qyPedido   : TFDQuery;
begin

  qyPedido:= TControllerConexao.getInstancia().daoConexao.getQuery;

  try
     qyPedido.Transaction.StartTransaction;
     qyPedido.Close;
     qyPedido.SQL.Clear;
     qyPedido.SQL.Text := 'select p.numeropedido, p.dataemissao, p.valortotal, '+
     ' i.id as uuid ,i.id, i.codigoproduto, i.descricao, i.quantidade, i.vlrunitario, i.vlrtotal, ' +
     ' c.codigo, c.nome  from pedidosgerais p '+
     ' inner join pedidoprodutos i on i.numeropedido_id = p.numeropedido '+
     ' inner join clientes c on c.codigo = p.codigocliente_id '+
     ' where p.numeropedido =:npedido';
     qyPedido.ParamByName('npedido').AsInteger := nPedido;
     qyPedido.Prepare;
     qyPedido.Open;
     qyPedido.Transaction.Commit;

     if not  qyPedido.IsEmpty then
       result := qyPedido
     else
       result := nil;
  except
    on E: Exception do
    begin
      qyPedido.Transaction.Rollback;
      result := nil;
      raise;
    end;
  end

end;

function TDAOPedidos.localizarProduto(CodProduto: Integer): TResultArray;
var
  qyItem: TFDQuery;
  ResultArray : TResultArray;
begin

  qyItem := TControllerConexao.getInstancia().daoConexao.getQuery;
  qyItem.Transaction.StartTransaction;
  try
    qyItem.SQL.Text := 'select descricao, precovenda from produtos where codigo = :ncodigo';
    qyItem.ParamByName('ncodigo').AsInteger := CodProduto;
    qyItem.Prepare;
    qyItem.Open;
    qyItem.Transaction.Commit;
    if not qyItem.IsEmpty then
    begin
      SetLength(ResultArray, 2);
      ResultArray[0] := qyItem.FieldByName('descricao').AsString;
      ResultArray[1] := qyItem.FieldByName('precovenda').AsFloat;
      Result := ResultArray;
    end
    else
      Result := nil;

  except
    on E: Exception do
    begin
     qyItem.Transaction.Rollback;
     result := nil;
    end;
  end;
  qyItem.Free;
end;


function TDAOPedidos.salvarPedido(aPedido: Integer; aCliente: Integer;
  FItensPedido: TObjectList<TModelPedidoItem>): Integer;
var
  qyPedido   : TFDQuery;
  DataEmissao: TDateTime;
  ValorTotal : Double;
  PedidoID   : Integer;
  i, y       : Integer;
begin

  ValorTotal  := 0;
  DataEmissao := Now;

  for i := 0 to FItensPedido.Count - 1 do
  begin
    ValorTotal := ValorTotal + FItensPedido[i].VlrTotal;
  end;

  qyPedido:= TControllerConexao.getInstancia().daoConexao.getQuery;
  qyPedido.Transaction.StartTransaction;


  try

     // Exlcuir registros deletados
     if aPedido> 0 then
      begin
       qyPedido.Close;
       qyPedido.SQL.Clear;
       qyPedido.SQL.Text := 'delete from pedidoprodutos WHERE numeropedido_id = :pnumeropedido_id AND id NOT IN ( ';
       for y := 0 to FItensPedido.Count - 1 do
        begin
        if y > 0 then
          qyPedido.SQL.Text := qyPedido.SQL.Text + ', ';
         qyPedido.SQL.Text := qyPedido.SQL.Text + IntToStr(FItensPedido[y].id);
        end;

      qyPedido.SQL.Text := qyPedido.SQL.Text + ')';
      qyPedido.ParamByName('pnumeropedido_id').AsInteger := aPedido;
       qyPedido.Prepare;
      qyPedido.ExecSQL;
     end;


   // Insert se um novo pedido
   if aPedido = -1 then
    begin
     qyPedido.Close;
     qyPedido.SQL.Clear;
     qyPedido.SQL.Text := 'insert into pedidosgerais (dataemissao, codigocliente_id, valortotal) ' +
           '  values(:pdataemissao, :pcodigocliente_id, :pvalortotal) ';

     qyPedido.ParamByName('pdataemissao').AsDateTime      := DataEmissao;
     qyPedido.ParamByName('pcodigocliente_id').AsInteger  := aCliente;
     qyPedido.ParamByName('pvalortotal').AsFloat          := ValorTotal ;
     qyPedido.Prepare;
     qyPedido.execSQL;
     qyPedido.SQL.Clear;
     qyPedido.SQL.Text := 'SELECT LAST_INSERT_ID()';
     qyPedido.Open;
     PedidoID:= qyPedido.Fields[0].AsInteger;
    end
    else
     PedidoID := aPedido;

    // Inserir ou Atualizar os itens na tabela PEDIDOSPRODUTOS
    for i := 0 to FItensPedido.Count - 1 do
    begin
     qyPedido.Close;
     qyPedido.SQL.Clear;
     qyPedido.SQL.Text := 'insert into pedidoprodutos (id, numeropedido_id, codigoproduto, descricao, quantidade, vlrunitario, vlrtotal) ' +
                    'values (:pid, :pnumeropedido_id, :pcodigoproduto, :pdescricao, :pquantidade, :pvlrunitario, :pvlrtotal) ' +
                    'ON DUPLICATE KEY UPDATE ' +
                    'numeropedido_id = VALUES(numeropedido_id), ' +
                    'codigoproduto = VALUES(codigoproduto), ' +
                    'descricao = VALUES(descricao), ' +
                    'quantidade = VALUES(quantidade), ' +
                    'vlrunitario = VALUES(vlrunitario), ' +
                    'vlrtotal = VALUES(vlrtotal)';

         qyPedido.ParamByName('pnumeropedido_id').AsInteger := PedidoID;
         qyPedido.ParamByName('pid').AsInteger              := FItensPedido[i].id;
         qyPedido.ParamByName('pcodigoproduto').AsInteger   := FItensPedido[i].codigoproduto;
         qyPedido.ParamByName('pdescricao').AsString        := FItensPedido[i].descricao;
         qyPedido.ParamByName('pquantidade').AsFloat        := FItensPedido[i].qtde;
         qyPedido.ParamByName('pvlrunitario').AsFloat       := FItensPedido[i].vlrunitario;
         qyPedido.ParamByName('pvlrtotal').AsFloat          := FItensPedido[i].vlrtotal;
         qyPedido.Prepare;
         qyPedido.ExecSQL;
      end;


         // Atualizar Totais
         qyPedido.SQL.Clear;
         qyPedido.Close;
         qyPedido.SQL.Text := 'update pedidosgerais  set valortotal = :pvalortotal' +
                               ' where numeropedido = :pnumeropedido ';
         qyPedido.ParamByName('pvalortotal').AsFloat       := ValorTotal ;
         qyPedido.ParamByName('pnumeropedido').AsInteger   := PedidoID;
         qyPedido.Prepare;
         qyPedido.ExecSQL;

    qyPedido.Transaction.Commit;
    Result := PedidoID;

  except
    on E: Exception do
    begin
      qyPedido.Transaction.Rollback;
      Result := -1;
    end;
  end;

end;


function TDAOPedidos.CancelarPedido(nPedido: Integer): Boolean;
var
  qyPedido: TFDQuery;
begin

  qyPedido := TControllerConexao.getInstancia().daoConexao.getQuery;
  try
    qyPedido.Transaction.StartTransaction;
    qyPedido.SQL.Text := 'delete from pedidoprodutos where numeropedido_id = :ncodigo';
    qyPedido.ParamByName('ncodigo').AsInteger := nPedido;
    qyPedido.Prepare;
    qyPedido.execSql;

    qyPedido.SQL.Clear;
    qyPedido.SQL.Text := 'delete from pedidosgerais where numeropedido = :ncodigo';
    qyPedido.ParamByName('ncodigo').AsInteger := nPedido;
    qyPedido.Prepare;
    qyPedido.execSql;
    qyPedido.Transaction.Commit;
    result := true;
    qyPedido.Free;
  except
     on E: Exception do
    begin
       qyPedido.Free;
       result := false;
       qyPedido.Transaction.Rollback;
      raise;
    end;


  end;

end;

constructor TDAOPedidos.Create;
begin
 FConexao := TDaoConector.Create;
inherited Create;
end;

destructor TDAOPedidos.Destroy;
begin
 freeandNil(FConexao);
inherited;
end;

end.