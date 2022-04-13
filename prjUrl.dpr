program prjUrl;

uses
  Vcl.Forms,
  uFrmUrl in 'uFrmUrl.pas' {FrmPrincipal},
  uTIdHTTPProgress in 'uTIdHTTPProgress.pas',
  uDmConexao in 'uDmConexao.pas' {dmconexao: TDataModule},
  uTDownload in 'uTDownload.pas',
  uFrmLista in 'uFrmLista.pas' {frmLista};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(Tdmconexao, dmconexao);
  Application.CreateForm(TfrmLista, frmLista);
  Application.Run;
end.
