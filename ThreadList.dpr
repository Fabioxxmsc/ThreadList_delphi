program ThreadList;

uses
  Vcl.Forms,
  Main_U in 'Main_U.pas' {frmMenu},
  nThreadMonitora_U in 'nThreadMonitora_U.pas',
  nFila_U in 'nFila_U.pas',
  nInformacao_U in 'nInformacao_U.pas',
  nThreadExecutora_U in 'nThreadExecutora_U.pas',
  nListaThread_U in 'nListaThread_U.pas',
  IProcessaRecurso_U in 'IProcessaRecurso_U.pas',
  nProcessaRecurso_U in 'nProcessaRecurso_U.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.Run;
end.
