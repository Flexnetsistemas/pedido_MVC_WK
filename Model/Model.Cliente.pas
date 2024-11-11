unit Model.Cliente;

interface

type
  TCliente = Class
    private
      FACodigo: Integer;
      FACidade: String;
      FANome: String;
      FAUF: String;
    public
     constructor Create(ACodigo:Integer; ANome, ACidade, AUF:String);
     destructor Destroy; override;
     property Codigo: Integer  read FACodigo write FACodigo;
     property Nome: string read FANome write FANome;
     property Cidade: string read FACidade write FACidade;
     property UF: string read FAUF write FAUF;
  End;


implementation

{ TCliente }

constructor TCliente.Create(ACodigo: Integer; ANome, ACidade, AUF: String);
begin

  FACodigo := ACodigo;
  FANome   := ANome;
  FACidade := ACidade;
  AUF      := AUF;

end;

destructor TCliente.Destroy;
begin

  inherited;
end;

end.
