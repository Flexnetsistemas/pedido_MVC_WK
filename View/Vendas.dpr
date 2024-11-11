program Vendas;

uses
  Vcl.Forms,
  Vendas.View in 'Vendas.View.pas' {FormVendas},
  Model.Cliente in '..\Model\Model.Cliente.pas',
  Model.PedidoItem in '..\Model\Model.PedidoItem.pas',
  Model.Pedido in '..\Model\Model.Pedido.pas',
  Controller.Pedido in '..\Controller\Controller.Pedido.pas',
  Model.Produto in '..\Model\Model.Produto.pas',
  DAOConexao in '..\DAO\DAOConexao.pas',
  Controller.Conexao in '..\Controller\Controller.Conexao.pas',
  DAOPedidos in '..\DAO\DAOPedidos.pas',
  DAOPedidoItem in '..\DAO\DAOPedidoItem.pas',
  Controller.PedidoItem in '..\Controller\Controller.PedidoItem.pas';

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown   := False;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormVendas, FormVendas);
  Application.Run;
end.
