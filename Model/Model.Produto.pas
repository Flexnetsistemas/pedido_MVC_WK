unit Model.Produto;

interface

type

 TProduto = class
   private
    FDescricao: String;
    FCodigoProduto: Integer;
    FPrecoVenda: Double;
    procedure SetCodigoProduto(const Value: Integer);
    procedure SetDescricao(const Value: String);
    procedure SetPrecoVenda(const Value: Double);
   public
    constructor Create;
    destructor  Destroy; override;

   property CodigoProduto : Integer read FCodigoProduto write SetCodigoProduto;
   property Descricao     : String read FDescricao write SetDescricao;
   property PrecoVenda    : Double read FPrecoVenda write SetPrecoVenda;


end;

implementation

{ TProduto }

constructor TProduto.Create;
begin

end;

destructor TProduto.Destroy;
begin

  inherited;
end;

procedure TProduto.SetCodigoProduto(const Value: Integer);
begin
  FCodigoProduto := Value;
end;

procedure TProduto.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TProduto.SetPrecoVenda(const Value: Double);
begin
  FPrecoVenda := Value;
end;

end.
