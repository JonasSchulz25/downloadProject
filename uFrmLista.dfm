object frmLista: TfrmLista
  Left = 0
  Top = 0
  Caption = 'Historico'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 33
    Width = 635
    Height = 266
    Align = alClient
    DataSource = ds
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'STATUS'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'URL'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_INICIO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_FIM'
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 635
    Height = 33
    Align = alTop
    TabOrder = 1
    object Button1: TButton
      Left = 552
      Top = 2
      Width = 75
      Height = 25
      Caption = 'Recarregar'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object cds: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 312
    Top = 152
    object cdsSTATUS: TStringField
      DisplayLabel = 'Status'
      FieldName = 'STATUS'
      Size = 15
    end
    object cdsURL: TStringField
      DisplayLabel = 'Url'
      FieldName = 'URL'
      Size = 150
    end
    object cdsDATA_INICIO: TDateTimeField
      DisplayLabel = 'Data Inicio'
      FieldName = 'DATA_INICIO'
    end
    object cdsDATA_FIM: TDateTimeField
      DisplayLabel = 'Data Fim'
      FieldName = 'DATA_FIM'
    end
  end
  object ds: TDataSource
    DataSet = cds
    Left = 192
    Top = 160
  end
end
