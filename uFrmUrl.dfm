object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Principal'
  ClientHeight = 178
  ClientWidth = 478
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 478
    Height = 178
    Align = alClient
    TabOrder = 0
    object lblUrl: TLabel
      Left = 16
      Top = 13
      Width = 18
      Height = 17
      Caption = 'Url'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblStatus: TLabel
      Left = 16
      Top = 83
      Width = 105
      Height = 17
      Caption = 'Download Parado'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object edtUrl: TEdit
      Left = 16
      Top = 32
      Width = 434
      Height = 21
      TabOrder = 0
    end
    object btnBaixar: TButton
      Left = 214
      Top = 129
      Width = 75
      Height = 25
      Caption = 'Baixar'
      TabOrder = 1
      OnClick = btnBaixarClick
    end
    object chkFechar: TCheckBox
      Left = 16
      Top = 59
      Width = 153
      Height = 17
      Caption = 'Fechar Automaticamente'
      TabOrder = 2
    end
    object btnCancelar: TButton
      Left = 294
      Top = 129
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 3
      OnClick = btnCancelarClick
    end
    object btnFechar: TButton
      Left = 375
      Top = 129
      Width = 75
      Height = 25
      Caption = 'Fechar'
      TabOrder = 4
      OnClick = btnFecharClick
    end
    object pgBaixar: TProgressBar
      Left = 16
      Top = 106
      Width = 434
      Height = 17
      TabOrder = 5
    end
    object btnHistorico: TButton
      Left = 16
      Top = 129
      Width = 89
      Height = 25
      Caption = 'Exibir Historico'
      TabOrder = 6
      OnClick = btnHistoricoClick
    end
  end
  object SaveDialog: TSaveDialog
    Left = 432
    Top = 56
  end
end
