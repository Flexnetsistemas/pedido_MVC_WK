unit Controller.PedidoItem;

interface

uses
  Model.PedidoItem,
  system.SysUtils,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client;

 Type
   TControllerPedidoItem = class
     private
    FModelPedidoItem: TModelPedidoItem;
    FVlrTotal: Double;
    FDescricao: String;
    FCodigoProduto: Integer;
    FQtde: Double;
    FNumeropedido_id: Integer;
    FVlrUnitario: Double;
    procedure SetCodigoProduto(const Value: Integer);
    procedure SetDescricao(const Value: String);
    procedure SetNumeropedido_id(const Value: Integer);
    procedure SetQtde(const Value: Double);
    procedure SetVlrTotal(const Value: Double);
    procedure SetVlrUnitario(const Value: Double);
     public
     constructor Create;
     destructor Destroy; override;

     function   editarItem       :TFDQuery;
     function   incluirItem:Boolean;

     property ModelPedidoItem :TModelPedidoItem read FModelPedidoItem write FModelPedidoItem;
     property Numeropedido_id: Integer read FNumeropedido_id write SetNumeropedido_id;
     property CodigoProduto: Integer read FCodigoProduto write SetCodigoProduto;
     property Qtde: Double read FQtde write SetQtde;
     property VlrUnitario : Double read FVlrUnitario write SetVlrUnitario;
     property VlrTotal:Double  read FVlrTotal write SetVlrTotal;
     property Descricao: String read FDescricao write SetDescricao;
  end;


implementation

{ TControllerPedidoItem }


constructor TControllerPedidoItem.Create;
begin
 FModelPedidoItem := TModelPedidoItem.Create;
end;

destructor TControllerPedidoItem.Destroy;
begin
   FModelPedidoItem.free;
  inherited;
end;

function TControllerPedidoItem.editarItem: TFDQuery;
begin

end;

function TControllerPedidoItem.incluirItem: Boolean;
begin
   if FModelPedidoItem.IncluirItem then
    result := true
   else
    result := false;
end;

procedure TControllerPedidoItem.SetCodigoProduto(const Value: Integer);
begin
  FCodigoProduto := Value;
end;

procedure TControllerPedidoItem.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TControllerPedidoItem.SetNumeropedido_id(const Value: Integer);
begin
  FNumeropedido_id := Value;
end;

procedure TControllerPedidoItem.SetQtde(const Value: Double);
begin
  FQtde := Value;
end;

procedure TControllerPedidoItem.SetVlrTotal(const Value: Double);
begin
  FVlrTotal := Value;
end;

procedure TControllerPedidoItem.SetVlrUnitario(const Value: Double);
begin
  FVlrUnitario := Value;
end;

end.
