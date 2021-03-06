unit uTIdHTTPProgress;

interface

uses
  Classes,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdHTTP,
  IdSSLOpenSSL,
  Vcl.ComCtrls,
  Vcl.Forms;

{$M+}

type
  TIdHTTPProgress = class(TIdHTTP)
  private
    FProgress: Integer;
    FBytesToTransfer: Int64;
    FOnChange: TNotifyEvent;
    IOHndl: TIdSSLIOHandlerSocketOpenSSL;
    FMaxProgress: Integer;
    FProgressBar: TProgressBar;
    procedure HTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
    procedure HTTPWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure HTTPWorkEnd(Sender: TObject; AWorkMode: TWorkMode);
  public
    Constructor Create(AOwner: TComponent);
    procedure DownloadFile(const aFileUrl: string; const aDestinationFile: String);
  published
    property BytesToTransfer: Int64 read FBytesToTransfer;
    property ProgressBar: TProgressBar read FProgressBar write FProgressBar;
  end;

implementation

uses
  Sysutils;
{ TIdHTTPProgress }

constructor TIdHTTPProgress.Create(AOwner: TComponent);
begin
  inherited;
  IOHndl := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  Request.BasicAuthentication := false;
  HandleRedirects := false;
  IOHandler := IOHndl;
  ReadTimeout := 30000;
  OnWork := HTTPWork;
  OnWorkBegin := HTTPWorkBegin;
  OnWorkEnd := HTTPWorkEnd;
  IOHndl.SSLOptions.SSLVersions := [sslvTLSv1_1,sslvTLSv1_2];
end;

procedure TIdHTTPProgress.DownloadFile(const aFileUrl: string; const aDestinationFile: String);
var
  LDestStream: TFileStream;
  aPath: String;
begin
  try
    if assigned(FProgressBar) then
    begin
      FProgressBar.Position := 0;
    end;
    FBytesToTransfer := 0;
    aPath := ExtractFilePath(aDestinationFile);
    if aPath <> '' then
      ForceDirectories(aPath);

    LDestStream := TFileStream.Create(aDestinationFile, fmCreate);
    try
      Get(aFileUrl, LDestStream);

    finally
      FreeAndNil(LDestStream);
    end;
  except
    on E: exception do
    begin
      raise exception.Create('Erro ao BAIXAR ARQUIVOS, ' + sLineBreak + E.Message);
    end;
  end;
end;

procedure TIdHTTPProgress.HTTPWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
begin
  if BytesToTransfer = 0 then // No Update File
    Exit;
  if assigned(FProgressBar) then
  begin
    FProgressBar.Position := AWorkCount;
  end;
  Application.ProcessMessages;
end;

procedure TIdHTTPProgress.HTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
  FBytesToTransfer := AWorkCountMax;
  if assigned(FProgressBar) then
  begin
    FProgressBar.Max := AWorkCountMax;
  end;
end;

procedure TIdHTTPProgress.HTTPWorkEnd(Sender: TObject; AWorkMode: TWorkMode);
begin
  FBytesToTransfer := 0;
  if assigned(FProgressBar) then
  begin
    FProgressBar.Position := 100;
  end;
end;

end.
