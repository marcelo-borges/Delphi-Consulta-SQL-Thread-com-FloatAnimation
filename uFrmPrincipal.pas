unit uFrmPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  System.Rtti, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.DBScope, FMX.Layouts, FMX.Grid, System.Bindings.Outputs,
  Data.DBXFirebird, Data.FMTBcd, Data.DB, Datasnap.DBClient, Datasnap.Provider,
  Data.SqlExpr, Data.Bind.Grid, Fmx.Bind.Grid, Fmx.Bind.Editors,
  Data.Bind.Controls, Fmx.Bind.Navigator, FMX.Controls.Presentation, FMX.Edit,
  FMX.EditBox, FMX.NumberBox, FMX.SpinBox, uFrameAnimacao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.Threading;

type
  TfrmPrincipal = class(TForm)
    pnlBotoes: TPanel;
    btnConsultar: TButton;
    StringGridLogradouro: TStringGrid;
    BindingsListLogradouro: TBindingsList;
    BindSourceDBLogradouro: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    FDConexao: TFDConnection;
    FDQryLogradouro: TFDQuery;
    FDQryLogradouroCEP: TStringField;
    FDQryLogradouroID_LOGRADOURO: TIntegerField;
    FDQryLogradouroTIPO: TStringField;
    FDQryLogradouroDESCRICAO: TStringField;
    FDQryLogradouroID_CIDADE: TIntegerField;
    FDQryLogradouroUF: TStringField;
    FDQryLogradouroCOMPLEMENTO: TStringField;
    FDQryLogradouroDESCRICAO_SEM_NUMERO: TStringField;
    FDQryLogradouroDESCRICAO_CIDADE: TStringField;
    FDQryLogradouroCODIGO_CIDADE_IBGE: TIntegerField;
    FDQryLogradouroDESCRICAO_BAIRRO: TStringField;
    PanelAnimacao: TPanel;
    frmAnimacao: TframeAnimacao;
    procedure btnConsultarClick(Sender: TObject);
  private
    { Private declarations }
    MinhaThread: TThread;
    procedure BuscarDados;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

procedure TfrmPrincipal.btnConsultarClick(Sender: TObject);
begin
  BuscarDados;
end;


procedure TfrmPrincipal.BuscarDados;
begin
  PanelAnimacao.Visible := True;
  frmAnimacao.Visible := True;
  frmAnimacao.FloatAnimacao.Enabled := True;
  btnConsultar.Enabled := False;

  MinhaThread := TThread.CreateAnonymousThread(
    procedure
    begin
      FDConexao.Connected := True;
      FDQryLogradouro.Close;
      FDQryLogradouro.SQL.Clear;
      FDQryLogradouro.SQL.Add('SELECT FIRST 10000 * FROM LOGRADOURO');
      FDQryLogradouro.Open;

      TThread.Synchronize(nil,
        procedure
        begin
          PanelAnimacao.Visible := False;
          frmAnimacao.Visible := False;
          frmAnimacao.FloatAnimacao.Enabled := False;
          btnConsultar.Enabled := True;
        end
      );
    end
  );
  MinhaThread.Start;
end;

end.
