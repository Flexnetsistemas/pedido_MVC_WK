object FormVendas: TFormVendas
  Left = 0
  Top = 0
  Caption = 'Vendas'
  ClientHeight = 441
  ClientWidth = 692
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 57
    Width = 692
    Height = 137
    Align = alTop
    TabOrder = 0
    DesignSize = (
      692
      137)
    object GroupBox1: TGroupBox
      Left = 215
      Top = 5
      Width = 466
      Height = 60
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Cliente'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Label1: TLabel
        Left = 11
        Top = 15
        Width = 38
        Height = 15
        Caption = 'C'#243'digo'
      end
      object Label2: TLabel
        Left = 95
        Top = 15
        Width = 33
        Height = 15
        Caption = 'Nome'
      end
      object edCodigoCliente: TEdit
        Left = 11
        Top = 32
        Width = 78
        Height = 23
        Hint = 'Digite o c'#243'digo e tecle "Enter"'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnChange = edCodigoClienteChange
        OnExit = edCodigoClienteExit
      end
      object edNomeCliente: TEdit
        Left = 93
        Top = 32
        Width = 348
        Height = 23
        ReadOnly = True
        TabOrder = 1
      end
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 67
      Width = 673
      Height = 62
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Produto'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Label5: TLabel
        Left = 11
        Top = 16
        Width = 38
        Height = 15
        Caption = 'C'#243'digo'
      end
      object Label6: TLabel
        Left = 87
        Top = 16
        Width = 52
        Height = 15
        Caption = 'Descri'#231#227'o'
      end
      object Label7: TLabel
        Left = 408
        Top = 16
        Width = 62
        Height = 15
        Caption = 'Quantidade'
      end
      object Label8: TLabel
        Left = 487
        Top = 16
        Width = 72
        Height = 15
        Caption = 'Valor Unit'#225'rio'
      end
      object edCodigoProduto: TEdit
        Tag = 1
        Left = 8
        Top = 32
        Width = 73
        Height = 23
        Hint = 'Digite o c'#243'digo e tecle "Enter"'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnExit = edCodigoProdutoExit
      end
      object edDescricaoProduto: TEdit
        Tag = 1
        Left = 87
        Top = 32
        Width = 315
        Height = 23
        ReadOnly = True
        TabOrder = 1
      end
      object edQtde: TEdit
        Tag = 1
        Left = 408
        Top = 32
        Width = 73
        Height = 23
        TabOrder = 2
        OnKeyPress = edQtdeKeyPress
      end
      object edPreco: TEdit
        Tag = 1
        Left = 487
        Top = 32
        Width = 73
        Height = 23
        TabOrder = 3
        OnKeyPress = edPrecoKeyPress
      end
      object btnAcao: TBitBtn
        Left = 576
        Top = 30
        Width = 75
        Height = 25
        Caption = 'Incluir'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        OnClick = btnAcaoClick
      end
    end
    object GroupBox3: TGroupBox
      Left = 8
      Top = 5
      Width = 201
      Height = 60
      Caption = 'Venda'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object Label3: TLabel
        Left = 10
        Top = 15
        Width = 66
        Height = 14
        Caption = 'N'#186' Pedido'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 89
        Top = 14
        Width = 71
        Height = 15
        Caption = 'Data Emiss'#227'o'
      end
      object edNVenda: TEdit
        Left = 10
        Top = 30
        Width = 73
        Height = 23
        Enabled = False
        TabOrder = 0
        OnChange = edNVendaChange
      end
      object dtEmissao: TDateTimePicker
        Left = 89
        Top = 31
        Width = 102
        Height = 23
        Date = 45582.000000000000000000
        Time = 0.997419953702774400
        TabOrder = 1
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 194
    Width = 692
    Height = 247
    Align = alClient
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 690
      Height = 204
      Align = alClient
      DataSource = DsItens
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnDblClick = DBGrid1DblClick
      OnKeyDown = DBGrid1KeyDown
      Columns = <
        item
          Expanded = False
          FieldName = 'CodigoProduto'
          ReadOnly = True
          Title.Caption = 'C'#243'digo'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -12
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = [fsBold]
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Descricao'
          ReadOnly = True
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -12
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = [fsBold]
          Width = 262
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Quantidade'
          ReadOnly = True
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -12
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = [fsBold]
          Width = 96
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VLRUnitario'
          ReadOnly = True
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -12
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = [fsBold]
          Width = 74
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VlrTotal'
          ReadOnly = True
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -12
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = [fsBold]
          Width = 102
          Visible = True
        end>
    end
    object Panel4: TPanel
      Left = 1
      Top = 205
      Width = 690
      Height = 41
      Align = alBottom
      TabOrder = 1
      DesignSize = (
        690
        41)
      object Label9: TLabel
        Left = 470
        Top = 12
        Width = 36
        Height = 17
        Anchors = [akTop, akRight]
        Caption = 'Total :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object nbTotal: TNumberBox
        Left = 528
        Top = 6
        Width = 113
        Height = 25
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        DisplayFormat = '#######0.00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
    end
  end
  object pnlTopo: TPanel
    Left = 0
    Top = 0
    Width = 692
    Height = 57
    Align = alTop
    TabOrder = 2
    DesignSize = (
      692
      57)
    object btnSalvarVenda: TBitBtn
      Left = 263
      Top = 6
      Width = 110
      Height = 45
      Caption = '&Gravar Pedido'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      Kind = bkAll
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      OnClick = btnSalvarVendaClick
    end
    object btnFechar: TBitBtn
      Left = 559
      Top = 6
      Width = 110
      Height = 45
      Anchors = [akTop, akRight]
      Caption = '&Fechar'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      Kind = bkClose
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      OnClick = btnFecharClick
    end
    object btnCancelarPedido: TBitBtn
      Left = 379
      Top = 6
      Width = 110
      Height = 45
      Action = actCancelarPedido
      Caption = 'Cancelar Pedido'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      Kind = bkCancel
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 2
    end
    object btnLocalizarPedido: TBitBtn
      Left = 147
      Top = 6
      Width = 110
      Height = 45
      Action = actLocalizarPedido
      Caption = 'Localizar Pedido'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      Kind = bkHelp
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 3
    end
    object btnNovo: TBitBtn
      Left = 32
      Top = 7
      Width = 110
      Height = 45
      Caption = '&Novo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      Kind = bkRetry
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 4
      OnClick = btnNovoClick
    end
  end
  object FDMemTable: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 544
    Top = 231
    object FDMemTableID: TIntegerField
      FieldName = 'ID'
    end
    object FDMemTableCodigoProduto: TIntegerField
      FieldName = 'CodigoProduto'
    end
    object FDMemTableDescricao: TStringField
      FieldName = 'Descricao'
      Size = 100
    end
    object FDMemTableVLRUnitario: TFloatField
      DisplayLabel = 'VlrUnitario'
      FieldName = 'VLRUnitario'
      DisplayFormat = '####0.00'
    end
    object FDMemTableVlrTotal: TFloatField
      FieldName = 'VlrTotal'
      DisplayFormat = '####0.00'
    end
    object FDMemTableUUID: TStringField
      FieldName = 'UUID'
    end
    object FDMemTableQuantidade: TIntegerField
      FieldName = 'Quantidade'
    end
  end
  object DsItens: TDataSource
    DataSet = FDMemTable
    Left = 608
    Top = 207
  end
  object ActionList: TActionList
    Left = 512
    Top = 8
    object actLocalizarPedido: TAction
      Caption = 'Localizar Pedido'
      OnExecute = btnLocalizarPedidoClick
    end
    object actCancelarPedido: TAction
      Caption = 'Cancelar Pedido'
      Enabled = False
      OnExecute = btnCancelarPedidoClick
    end
  end
end