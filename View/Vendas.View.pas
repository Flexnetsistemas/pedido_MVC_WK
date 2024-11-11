unit Vendas.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Controller.PedidoItem, FireDAC.Phys.FB, FireDAC.Phys.FBDef,System.UITypes,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, Controller.Pedido, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  Vcl.NumberBox, System.Generics.Collections, Model.PedidoItem, Vcl.Mask,
  System.Actions, Vcl.ActnList, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
  FireDAC.Phys.MSAcc, FireDAC.Phys.MSAccDef;

type
   TFormVendas = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    pnlTopo: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    edCodigoCliente: TEdit;
    edNomeCliente: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edCodigoProduto: TEdit;
    edDescricaoProduto: TEdit;
    edQtde: TEdit;
    edPreco: TEdit;
    btnAcao: TBitBtn;
    FDMemTable: TFDMemTable;
    DBGrid1: TDBGrid;
    DsItens: TDataSource;
    FDMemTableID: TIntegerField;
    FDMemTableCodigoProduto: TIntegerField;
    FDMemTableDescricao: TStringField;
    FDMemTableVLRUnitario: TFloatField;
    FDMemTableVlrTotal: TFloatField;
    GroupBox3: TGroupBox;
    edNVenda: TEdit;
    dtEmissao: TDateTimePicker;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    FDMemTableUUID: TStringField;
    Panel4: TPanel;
    nbTotal: TNumberBox;
    Label9: TLabel;
    btnSalvarVenda: TBitBtn;
    btnFechar: TBitBtn;
    btnCancelarPedido: TBitBtn;
    btnLocalizarPedido: TBitBtn;
    FDMemTableQuantidade: TIntegerField;
    ActionList: TActionList;
    actLocalizarPedido: TAction;
    actCancelarPedido: TAction;
    btnNovo: TBitBtn;
    procedure btnAcaoClick(Sender: TObject);
    procedure edCodigoProdutoExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSalvarVendaClick(Sender: TObject);
    procedure btnLocalizarPedidoClick(Sender: TObject);
    procedure btnCancelarPedidoClick(Sender: TObject);
    procedure edCodigoClienteExit(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure edCodigoClienteChange(Sender: TObject);
    procedure edNVendaChange(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure edQtdeKeyPress(Sender: TObject; var Key: Char);
    procedure edPrecoKeyPress(Sender: TObject; var Key: Char);
  private
    GUIDGerado : String;
    State      : String;
    function totalizarItens : Double;
    function validaInputs: Boolean;
    procedure CarregarDataSet(vDataSet:TDataSet);
    procedure limparCampos(State:Integer);
  public
    { Public declarations }

  end;

var
  FormVendas: TFormVendas;

implementation


{$R *.dfm}

procedure TFormVendas.btnFecharClick(Sender: TObject);
begin
 Close();
end;

procedure TFormVendas.btnCancelarPedidoClick(Sender: TObject);
var
 PedidoController : TControllerPedido;
begin
  if MessageDLG('Deseja excluir este pedido ?', mtConfirmation,[mbyes,mbno],0) = mrYes then
  begin
   PedidoController := TControllerPedido.Create;
   try
       if PedidoController.CancelarPedido(StrToInt(ednVenda.Text)) then
       begin
          limparCampos(0);
          showmessage('Pedido excluido com sucesso !');
       end
       else
          showmessage('Falha ao excluir este pedido');
   finally
      PedidoController.Free;
   end;


  end;
end;

procedure TFormVendas.btnLocalizarPedidoClick(Sender: TObject);
var
  InputValor:  string;
  IntValor  :  Integer;
  PedidoController : TControllerPedido;
  ResultDataSet    : TDataSet;
begin

   InputValor := InputBox('Localizar Pedido', 'Digite o n�mero do Pedido:', '');

   if trim(InputValor) = '' then
   exit;

  if TryStrToInt(InputValor, IntValor) then
  begin
   try
     PedidoController := TControllerPedido.Create;
     ResultDataSet :=  PedidoController.LocalizarPedido(StrToInt(InputValor));
    if (ResultDataSet <> nil) then
      begin
         CarregarDataSet(ResultDataSet);
       end
      else
       MessageDlg('Venda n� '+InputValor+' n�o localizada !' ,mtWarning,[mbok],0);


   finally
    PedidoController.free;
   end;

  end
  else
    ShowMessage('Digite um n�mero v�lido !.');

end;

procedure TFormVendas.btnNovoClick(Sender: TObject);
begin
 limparCampos(0);
 State := '';
 edCodigoCliente.SetFocus;
end;

procedure TFormVendas.btnAcaoClick(Sender: TObject);
Var
 GUID: TGUID;
begin

  if not validaInputs then
  exit;

  if State = 'ALTERAR' then
  begin
   FDMemTable.Open;
    if FDMemTable.locate('UUID', GUIDGerado,[]) then
    begin
     FDMemTable.Edit;
     FDMemTable.FieldByName('Quantidade').AsFloat      := StrToFloat(edQtde.Text);
     FDMemTable.FieldByName('VlrUnitario').AsFloat     := StrToFloat(edPreco.Text);
     FDMemTable.FieldByName('VlrTotal').AsFloat        := StrToFloat(edPreco.Text) *  StrToFloat(edQtde.Text);
     FDMemTable.Post;
     LimparCampos(1);
     btnAcao.Caption := 'Incluir';
     edCodigoProduto.ReadOnly := False;
     edCodigoProduto.SetFocus;
    end;
  end
  else
  begin
     CreateGUID(GUID);
     GUIDGerado := GUIDToString(GUID);
     FDMemTable.Open;
     FDMemTable.Append;
     FDMemTable.FieldByName('UUID').AsString           :=  GUIDGerado;
     FDMemTable.FieldByName('CodigoProduto').AsInteger := StrToInt(edCodigoProduto.Text);
     FDMemTable.FieldByName('Descricao').AsString      := edDescricaoProduto.Text;
     FDMemTable.FieldByName('Quantidade').AsFloat      := StrToFloat(edQtde.Text);
     FDMemTable.FieldByName('VlrUnitario').AsFloat     := StrToFloat(edPreco.Text);
     FDMemTable.FieldByName('VlrTotal').AsFloat        := StrToFloat(edPreco.Text) *  StrToFloat(edQtde.Text);
     FDMemTable.Post;
     limparCampos(1);
     edCodigoProduto.SetFocus;
   end;

   nbTotal.Value := TotalizarItens;
end;

procedure TFormVendas.btnSalvarVendaClick(Sender: TObject);
var
 PedidoController  : TControllerPedido;
 Itens             : TObjectList<TModelPedidoItem>;
 PedidoItens       : TModelPedidoItem;
 ResultDataSet     : TDataSet;
 lPedido, lCliente : Integer;
 lPedidoGerado     : Integer;
 id                : Integer;
begin

  if FDMemTable.IsEmpty then
   begin
    MessageDlg('Pedido sem produto(s) !', mtwarning, [mbok],0);
    exit;
  end
  else
  if trim(edCodigoCliente.Text) = '' then
  begin
    MessageDlg('Informe o c�digo de um cliente v�lido!', mtwarning, [mbok],0);
    exit;
  end;

 Itens := TObjectList<TModelPedidoItem>.Create;
 Itens.Clear;
 FDMemTable.First;
  while not FDMemTable.Eof do
  begin

      if FDMemTable.FieldByName('id').IsNull  then
       id := 0
      else
       id := FDMemTable.FieldByName('id').AsInteger;

      PedidoItens                := TModelPedidoItem.Create;
      PedidoItens.id             :=  id;
      PedidoItens.CodigoProduto  := FDMemTable.FieldByName('CodigoProduto').AsInteger;
      PedidoItens.Descricao      := FDMemTable.FieldByName('Descricao').AsString;
      PedidoItens.Qtde           := FDMemTable.FieldByName('Quantidade').AsFloat;
      PedidoItens.VlrUnitario    := FDMemTable.FieldByName('VlrUnitario').AsFloat;
      PedidoItens.VlrTotal       := FDMemTable.FieldByName('VlrTotal').AsFloat;
      Itens.add(PedidoItens);
      FDMemTable.Next;
     end;

   if ednVenda.Text = ''  then
    lPedido := -1
   else
    lPedido := StrToInt(ednVenda.Text);

  lCliente := StrToInt(edCodigoCliente.text);

  PedidoController  :=  TControllerPedido.Create;
  try
    lPedidoGerado := PedidoController.salvarPedido(lPedido,lCliente,Itens);
    ResultDataSet := PedidoController.LocalizarPedido(lPedidoGerado);
    if (ResultDataSet <> nil) then
      begin
         CarregarDataSet(ResultDataSet);
       end
      else
       MessageDlg('N�o foi poss�vel gravar o pedido !' ,mtError,[mbok],0);


  finally
   FreeAndNil(PedidoController);
   FreeAndNil(Itens);
  end;

end;

procedure TFormVendas.CarregarDataSet(vDataSet: TDataSet);
begin

  ednVenda.text        := vDataSet.FieldByName('numeropedido').AsString;
  dtEmissao.Date       := vDataSet.FieldByName('dataemissao').AsDateTime;
  edCodigoCliente.text := vDataSet.FieldByName('codigo').AsString;
  edNomeCliente.Text   := vDataSet.FieldByName('nome').AsString;
  nbTotal.Value        := vDataSet.FieldByName('valortotal').AsFloat;

  FDMemTable.Close;
  FDMemTable.CopyDataSet(vDataSet, [coRestart, coAppend]);
  FDMemTable.Open;


end;

procedure TFormVendas.DBGrid1DblClick(Sender: TObject);
begin
  if not FdMemTable.IsEmpty then
  begin
    LimparCampos(1);
    GUIDGerado               := FDMemTable.FieldByName('UUID').AsString;
    edCodigoProduto.Text     := IntToStr(FDMemTable.FieldByName('CodigoProduto').AsInteger);
    edDescricaoProduto.Text  := FDMemTable.FieldByName('Descricao').AsString;
    edQtde.Text              := FloatToStr(FDMemTable.FieldByName('Quantidade').AsFloat);
    edPreco.Text             := FloatToStr(FDMemTable.FieldByName('VlrUnitario').AsFloat);
    edCodigoProduto.ReadOnly := True;
    BtnAcao.Caption          := 'Alterar';
    State                    := 'ALTERAR';
    edQtde.SetFocus;
    end;



end;

procedure TFormVendas.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key = VK_RETURN then
  begin
    DBGrid1DblClick(Sender);
  end
  else if Key = VK_DELETE then
  begin
    if MessageDLG('Deseja excluir o item selecionado ?', mtConfirmation,[mbyes,mbno],0) = mrYes then
      FDMemTable.Delete;
      nbTotal.Value := TotalizarItens;
  end;
end;
procedure TFormVendas.edCodigoClienteChange(Sender: TObject);
begin
  actLocalizarPedido.Enabled := edCodigocliente.Text = '';
end;

procedure TFormVendas.edCodigoClienteExit(Sender: TObject);
var
 PedidoController  :  TControllerPedido;
 lCliente : Integer;
 Nome     : String;
begin

  if trim(edCodigoCliente.Text) = '' then
  begin
   edNomeCliente.Text := '';
   exit;
  end;


  if not TryStrToInt(edCodigoCliente.Text, lCliente) then
   begin
    MessageDlg('Digite um c�digo de cliente v�lido !', mterror, [mbok],0);
    exit;
  end
  else
   lCliente:= StrToInt(edCodigoCliente.Text);


  PedidoController  :=  TControllerPedido.Create;

  try
     Nome := PedidoController.localizarCliente(lCliente);
    if Nome  <> '' then
    edNomeCliente.Text := Nome
    else
    begin
     MessageDlg('Cliente n�o localizado/cadastrado !', mtwarning, [mbok],0);
     edNomeCliente.Clear;
     edCodigoCliente.Clear;
     edCodigoCliente.SetFocus;
    end;
  finally
   freeandnil(PedidoController);
   end;
end;

procedure TFormVendas.edCodigoProdutoExit(Sender: TObject);
Var
PedidoController : TControllerPedido;
lCodProduto       : Integer;
begin

  if trim(edCodigoProduto.Text) = '' then
   exit;

  if not TryStrToInt(edCodigoProduto.Text, lCodProduto) then
   begin
    MessageDlg('Digite o c�digo de produto v�lido !', mterror, [mbok],0);
    exit;
  end
  else
   lCodProduto := StrToInt(edCodigoProduto.Text);

  PedidoController  :=  TControllerPedido.Create;
  try

    PedidoController.aResArray := PedidoController.localizarProduto(lCodProduto);

    if length(PedidoController.aResArray) > 0 then
    begin
     SetLength(PedidoController.aResArray, 2);
     edDescricaoProduto.Text :=   PedidoController.aResArray[0];
     edPreco.Text            :=   FloatToStr(PedidoController.aResArray [1]);
     edQtde.Text             :=  '1';
    end
    else
    begin
       LimparCampos(1);
       MessageDlg('Produto n�o localizado !', mtWarning, [mbok],0);
       edCodigoProduto.SetFocus;
     end;

  finally
   PedidoController.free;
  end;
end;

procedure TFormVendas.edNVendaChange(Sender: TObject);
begin
  actCancelarPedido.Enabled := edNVenda.Text <> '';
end;

procedure TFormVendas.edPrecoKeyPress(Sender: TObject; var Key: Char);
begin

  if not (Key in ['0'..'9', ',', #8]) then
  begin
    Key := #0;
  end;

  if (Key = ',') and (Pos(',', edPreco.Text) > 0) then
  begin
    Key := #0;
  end;

end;

procedure TFormVendas.edQtdeKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', ',', #8]) then
  begin
    Key := #0;
  end;

end;

procedure TFormVendas.FormKeyPress(Sender: TObject; var Key: Char);
begin

if Key = #13 then
  begin
    Key := #0;
    SelectNext(ActiveControl, True, True);
  end;

end;

procedure TFormVendas.limparCampos(State: Integer);
var
 i : Integer;
begin

    for i := 0 to ComponentCount -1 do
      begin
       if ((Components[i] is TEdit)) and ((Components[i] as TEdit).tag = 1) and (State = 1)  then
          (Components[i] as TEdit).Text  := ''
        else
        if (Components[i] is TEdit) and (State = 0)  then
           (Components[i] as TEdit).Text  := '';

      end;

      if State = 0 then
      begin
       FDMemTable.Open;
       FDMemTable.EmptyDataSet;
       nbtotal.value := 0;
      end;

end;


function TFormVendas.totalizarItens: Double;
var
  Total: Double;
begin
  Total := 0;
  FDMemTable.First;
  while not FDMemTable.Eof do
  begin
    Total := Total + FDMemTable.FieldByName('VlrTotal').AsFloat;
    FDMemTable.Next;
  end;

  result := Total;

end;

function TFormVendas.validaInputs: Boolean;
begin
  Result := True;

  if edCodigoProduto.Text  = ''  then
  begin
    MessageDlg('Informe o codigo do produto',mtwarning,[mbok],0);
    Result := False;
   end
  else
  if (edQtde.Text  = '')  or (edPreco.Text = '') then
  begin
    MessageDlg('Informe a quantidade e Valor',mtwarning,[mbok],0);
     Result := False;
  end;

end;

end.