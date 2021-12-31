unit Main_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, nThreadMonitora_U, nListaThread_U;

type
  TfrmMenu = class(TForm)
    ButtonIniciar: TButton;
    ButtonParar  : TButton;
    procedure ButtonIniciarClick(Sender: TObject);
    procedure ButtonPararClick(Sender: TObject);
  private
    FThreadMonitora: TnThreadMonitora;
    FListaThread   : TnListaThread;

    procedure Iniciar;
    procedure Parar;
  end;

var
  frmMenu: TfrmMenu;

implementation

{$R *.dfm}

procedure TfrmMenu.ButtonIniciarClick(Sender: TObject);
begin
  Iniciar;
end;

procedure TfrmMenu.ButtonPararClick(Sender: TObject);
begin
  Parar;
end;

procedure TfrmMenu.Iniciar;
var
  ACount: Integer;
begin
  ACount := 0;
  if not Assigned(FThreadMonitora) then
  begin
    FThreadMonitora := TnThreadMonitora.Create;
    ACount          := FThreadMonitora.Count;
    FThreadMonitora.Start;
  end;

  if not Assigned(FListaThread) then
    FListaThread := TnListaThread.Create(ACount);
end;

procedure TfrmMenu.Parar;
begin
  if Assigned(FThreadMonitora) then
  begin
    FThreadMonitora.Terminate;
    FThreadMonitora.WaitFor;
    FreeAndNil(FThreadMonitora);
  end;

  if Assigned(FListaThread) then
  begin
    FListaThread.Parar;
    FreeAndNil(FListaThread);
  end;
end;

end.
