unit Model.PedidoItem;

interface

type
  TModelPedidoItem  = Class
  private
    FVlrTotal: Double;
    FCodigoProduto: Integer;
    FID: Integer;
    FQtde: Double;
    FNumeropedido_id: Integer;
    FVlrUnitario: Double;
    FDescricao: String;
    procedure SetCodigoProduto(const Value: Integer);
    procedure SetID(const Value: Integer);
    procedure SetNumeropedido_id(const Value: Integer);
    procedure SetQtde(const Value: Double);
    procedure SetVlrTotal(const Value: Double);
    procedure SetVlrUnitario(const Value: Double);
    procedure SetDescricao(const Value: String);
  public
   constructor Create;
   destructor Destroy; Override;
   function IncluirItem:Boolean;

   property ID: Integer read FID write SetID;
   property Numeropedido_id: Integer read FNumeropedido_id write SetNumeropedido_id;
   property CodigoProduto: Integer read FCodigoProduto write SetCodigoProduto;
   property Qtde: Double read FQtde write SetQtde;
   property VlrUnitario : Double read FVlrUnitario write SetVlrUnitario;
   property VlrTotal:Double  read FVlrTotal write SetVlrTotal;
   property Descricao: String read FDescricao write SetDescricao;

  End;

implementation

uses
  DAOPedidoItem;

{ TModelPedidoItem }

constructor TModelPedidoItem.Create;
begin

inherited Create;
end;

destructor TModelPedidoItem.Destroy;
begin


  inherited;
end;

function TModelPedidoItem.IncluirItem:Boolean;
var
 FPedidoItem : TDaoPedidoItem;
begin

    FPedidoItem := TDaoPedidoItem.Create;
    try
      if FPedidoItem.incluirItem(Self) then
       result := true
       else
       result := false;
    finally
     FPedidoItem.free;
    end;


end;

procedure TModelPedidoItem.SetCodigoProduto(const Value: Integer);
begin
  FCodigoProduto := Value;
end;

procedure TModelPedidoItem.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TModelPedidoItem.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TModelPedidoItem.SetNumeropedido_id(const Value: Integer);
begin
  FNumeropedido_id := Value;
end;

procedure TModelPedidoItem.SetQtde(const Value: Double);
begin
  FQtde := Value;
end;

procedure TModelPedidoItem.SetVlrTotal(const Value: Double);
begin
  FVlrTotal := Value;
end;

procedure TModelPedidoItem.SetVlrUnitario(const Value: Double);
begin
  FVlrUnitario := Value;
end;

end.
