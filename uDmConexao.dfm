object dmconexao: Tdmconexao
  OldCreateOrder = False
  Height = 252
  Width = 374
  object FDConnection: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    LoginPrompt = False
    AfterConnect = FDConnectionAfterConnect
    BeforeConnect = FDConnectionBeforeConnect
    Left = 96
    Top = 64
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 200
    Top = 64
  end
  object FDSQLiteBackup1: TFDSQLiteBackup
    Database = '\\srv\db\data.sdb'
    Catalog = 'MAIN'
    DestDatabase = 'C:\desenvolvimento\teste\banco.sdb'
    DestCatalog = 'MAIN'
    Left = 80
    Top = 128
  end
  object fdq: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'CREATE TABLE IF NOT EXISTS download ('
      '    codigo          INTEGER       PRIMARY KEY AUTOINCREMENT,'
      '    data_inicio DATETIME,'
      '    data_fim    DATETIME,'
      '    url         VARCHAR (600),'
      '    status      VARCHAR (15) '
      ');')
    Left = 160
    Top = 128
  end
end
