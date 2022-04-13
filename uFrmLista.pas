unit uFrmLista;

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
  Data.DB,
  Datasnap.DBClient,
  Vcl.Grids,
  Vcl.DBGrids,
  utDownload,
  Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TfrmLista = class(TForm)
    DBGrid1: TDBGrid;
    cds: TClientDataSet;
    ds: TDataSource;
    cdsSTATUS: TStringField;
    cdsURL: TStringField;
    cdsDATA_INICIO: TDateTimeField;
    cdsDATA_FIM: TDateTimeField;
    Panel1: TPanel;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    procedure CarregarCds;
  public
    { Public declarations }
  end;

var
  frmLista: TfrmLista;

implementation

{$R *.dfm}

procedure TfrmLista.Button1Click(Sender: TObject);
begin
  CarregarCds;
end;

procedure TfrmLista.CarregarCds;
var
  vDownload: tDownload;
begin
  cds.Active := False;
  cds.Close;
  cds.FieldDefs.Clear;
  cds.CreateDataSet;
  cds.Open;
  vDownload := tDownload.Create;
  vDownload.Carregar(cds);
end;

procedure TfrmLista.FormShow(Sender: TObject);
begin
  CarregarCds;
end;

end.
