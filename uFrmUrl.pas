unit uFrmUrl;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  uTIdHTTPProgress,
  IdBaseComponent,
  IdComponent,
  IdIOHandler,
  IdIOHandlerSocket,
  IdIOHandlerStack,
  IdSSL,
  IdSSLOpenSSL,
  utDownload,
  uDmConexao,
  uFrmLista;

type
  TTipoEvento = (teBaixando, teCancelado, teParado);

  TFrmPrincipal = class(TForm)
    Panel1: TPanel;
    lblUrl: TLabel;
    edtUrl: TEdit;
    btnBaixar: TButton;
    chkFechar: TCheckBox;
    btnCancelar: TButton;
    btnFechar: TButton;
    pgBaixar: TProgressBar;
    lblStatus: TLabel;
    btnHistorico: TButton;
    SaveDialog: TSaveDialog;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFecharClick(Sender: TObject);
    procedure btnBaixarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnHistoricoClick(Sender: TObject);
  private
    { Private declarations }
    procedure SalvarArquivo;
    function ValidarDownloadAndamento: Boolean;
    procedure GravarDownload(pEvento: TTipoEvento);
    { Botoes }
    procedure TratarBotoes(pEvento: TTipoEvento);
    procedure EventoCancelado;
    procedure EventoBaixando;
    procedure EventoParado;
  public
    { Public declarations }
    vIdHttp: TIdHTTPProgress;
    FdataInicio: TdateTime;
    FDataFim: TdateTime;
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

procedure TFrmPrincipal.btnBaixarClick(Sender: TObject);
begin
  if edtUrl.Text <> EmptyStr then
  begin
    SaveDialog.Filter := '|*' + ExtractFileExt(edtUrl.Text);
    if SaveDialog.Execute then
    begin
      TratarBotoes(teBaixando);
      pgBaixar.Position := 0;
      vIdHttp.ProgressBar := pgBaixar;
      FdataInicio := Now;
      TThread.CreateAnonymousThread(
        procedure
        begin
          vIdHttp.DownloadFile(edtUrl.Text, SaveDialog.FileName);
          if chkFechar.Checked then
          begin
            Close;
          end;
          FDataFim := Now;
          TratarBotoes(teParado);
        end).Start;
    end;
  end
  else
  begin
    ShowMessage('Nenhuma URL informada, Verifique!');
    edtUrl.SetFocus;
  end;
end;

procedure TFrmPrincipal.btnCancelarClick(Sender: TObject);
begin
  if ValidarDownloadAndamento then
  begin
    TratarBotoes(teCancelado);
  end;
end;

procedure TFrmPrincipal.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmPrincipal.btnHistoricoClick(Sender: TObject);
begin
  if not Assigned(frmLista) then
  begin
    frmLista := TfrmLista.Create(nil);
  end;
  frmLista.Show;
end;

procedure TFrmPrincipal.EventoBaixando;
begin
  lblStatus.Caption := 'Download Em andamento';
  btnCancelar.Enabled := True;
  btnBaixar.Enabled := False;
  pgBaixar.Visible := True;
end;

procedure TFrmPrincipal.EventoCancelado;
begin
  lblStatus.Caption := 'Download Cancelado';
  btnCancelar.Enabled := False;
  btnBaixar.Enabled := True;
  pgBaixar.Visible := False;
end;

procedure TFrmPrincipal.EventoParado;
begin
  lblStatus.Caption := 'Download Parado';
  btnCancelar.Enabled := False;
  btnBaixar.Enabled := True;
  pgBaixar.Visible := False;
end;

procedure TFrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ValidarDownloadAndamento then
  begin
    Action := caFree;
    FrmPrincipal := nil;
    Application.Terminate;
  end;
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  if not Assigned(dmConexao) then
  begin
    dmConexao := TdmConexao.Create(nil);
  end;

  if not Assigned(vIdHttp) then
  begin
    vIdHttp := TIdHTTPProgress.Create(nil);
  end;
  EventoParado;
end;

procedure TFrmPrincipal.GravarDownload(pEvento: TTipoEvento);
var
  vDownload: TDownload;
begin
  try
    vDownload := TDownload.Create;
    vDownload.url := edtUrl.Text;
    vDownload.data_inicio := FdataInicio;
    vDownload.data_fim := FDataFim;
    case pEvento of
      teCancelado:
        vDownload.status := 'CANCELADO';
      teParado:
        vDownload.status := 'FINALIZADO';
    end;
    vDownload.Gravar;
  finally
    vDownload.Free;
  end;
end;

procedure TFrmPrincipal.SalvarArquivo;
begin

end;

procedure TFrmPrincipal.TratarBotoes(pEvento: TTipoEvento);
begin
  case pEvento of
    teBaixando:
      EventoBaixando;
    teCancelado:
      EventoCancelado;
    teParado:
      EventoParado;
  end;
  if pEvento <> teBaixando then
  begin
    GravarDownload(pEvento);
  end;
end;

function TFrmPrincipal.ValidarDownloadAndamento: Boolean;
begin
  Result := False;
  if (vIdHttp.BytesToTransfer > 0) and (chkFechar.Checked or (MessageDlg('Download em andamento, deseja cancelar?', mtWarning, mbYesNo,
    0) = mrYes)) then
  begin
    vIdHttp.Disconnect;
    GravarDownload(teCancelado);
    Result := True;
  end;
end;

end.
