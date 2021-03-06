unit uTDownload;

interface

uses
  FireDAC.Comp.Client,
  FireDAC.DApt,
  System.SysUtils,
  Data.DB,
  Datasnap.DBClient,
  Variants,
  uDmConexao;

type
  tDownload = class
  private
    FUrl: string;
    FDataInicio: tDatetime;
    FDataFim: tDatetime;
    Fcodigo: integer;
    FStatus: string;
    procedure PopularParametros(pQry: TFDQuery);
  public
    procedure Gravar;
    procedure Alterar;
    procedure Carregar(pCds: TClientDataSet);
  published
    property codigo: integer read Fcodigo write Fcodigo;
    property url: string read FUrl write FUrl;
    property data_inicio: tDatetime read FDataInicio write FDataInicio;
    property data_fim: tDatetime read FDataFim write FDataFim;
    property status: string read FStatus write FStatus;

  end;

implementation

{ tDownload }

procedure tDownload.Alterar;
var
  vQry: TFDQuery;
begin
  try
    try
      vQry := TFDQuery.Create(nil);
      vQry.Connection := dmConexao.FDConnection;
      vQry.SQL.Add(' UPDATE DOWNLOAD');
      vQry.SQL.Add(' SET(');
      vQry.SQL.Add(' CODIGO = :CODIGO , URL = :URL, DATA_INICIO = :DATA_INICIO, DATA_FIM= :DATA_FIM, STATUS = :STATUS)');

      PopularParametros(vQry);

      vQry.ExecSQL;
    except
      on E: Exception do
      begin
        raise Exception.Create('Erro ao alterar, Verifique' + sLineBreak + E.Message);
      end;
    end;
  finally
    vQry.Free;
  end;
end;

procedure tDownload.Carregar(pCds: TClientDataSet);
var
  vQry: TFDQuery;
begin
  vQry := TFDQuery.Create(nil);
  try
    try
      vQry.Connection := dmConexao.FDConnection;
      vQry.SQL.Add(' SELECT CODIGO, URL, DATA_INICIO, DATA_FIM, STATUS');
      vQry.SQL.Add(' FROM DOWNLOAD');
      vQry.SQL.Add(' WHERE (1=1) ');

      vQry.Open;

      if NOT vQry.IsEmpty then
      begin
        vQry.First;
        while not vQry.Eof do
        begin
          pCds.Append;
          pCds.FieldByName('DATA_INICIO').AsDateTime := vQry.FieldByName('DATA_INICIO').AsDateTime;
          pCds.FieldByName('DATA_FIM').AsDateTime := vQry.FieldByName('DATA_FIM').AsDateTime;
          pCds.FieldByName('URL').AsString := vQry.FieldByName('URL').AsString;
          pCds.FieldByName('STATUS').AsString := vQry.FieldByName('STATUS').AsString;
          pCds.Post;
          vQry.Next;
        end;
      end;
    except
      on E: Exception do
      begin
        raise Exception.Create('Erro ao CARREGAR LISTA de COR, verifique!' + sLineBreak + E.Message);
      end;
    end;
  finally
    vQry.Free;
  end;
end;

procedure tDownload.Gravar;
var
  vQry: TFDQuery;
begin
  try
    try
      vQry := TFDQuery.Create(nil);
      vQry.Connection := dmConexao.FDConnection;
      vQry.SQL.Add(' INSERT INTO DOWNLOAD(');
      vQry.SQL.Add(' CODIGO, URL, DATA_INICIO, DATA_FIM, STATUS)');
      vQry.SQL.Add(' VALUES(');
      vQry.SQL.Add(' :CODIGO, :URL, :DATA_INICIO, :DATA_FIM, :STATUS)');
      PopularParametros(vQry);

      vQry.ExecSQL;
    except
      on E: Exception do
      begin
        raise Exception.Create('Erro ao gravar, Verifique' + sLineBreak + E.Message);
      end;
    end;
  finally
    vQry.Free;
  end;
end;

procedure tDownload.PopularParametros(pQry: TFDQuery);
begin
  if Fcodigo > 0 then
  begin
    pQry.ParamByName('CODIGO').AsInteger := Fcodigo;
  end
  else
  begin
    pQry.ParamByName('CODIGO').DataType := ftInteger;
    pQry.ParamByName('CODIGO').Value := Variants.Null;
  end;
  pQry.ParamByName('DATA_INICIO').AsDateTime := FDataInicio;
  pQry.ParamByName('DATA_FIM').AsDateTime := FDataFim;
  pQry.ParamByName('URL').AsString := FUrl;
  pQry.ParamByName('STATUS').AsString := FStatus;
end;

end.
