unit nThreadExecutora_U;

interface

uses
  System.Classes,
  nInformacao_U;

type
  TnThreadExecutora = class(TThread)
  private
    function BuscaRecurso: TnInformacao;

    procedure Aguardar;
    procedure ProcessaRecurso(_ARecurso: TnInformacao);
    procedure RemoverRecurso(_ARecurso: TnInformacao);
  protected
    procedure Execute; override;
  public
    constructor Create;
  end;

implementation

uses
  System.Generics.Collections,
  System.SysUtils,
  nFila_U,
  IProcessaRecurso_U,
  nProcessaRecurso_U;

{ TnThreadExecutora }

constructor TnThreadExecutora.Create;
begin
  inherited Create(True);
  FreeOnTerminate := True;
end;

function TnThreadExecutora.BuscaRecurso: TnInformacao;
var
  AList: TList<TnInformacao>;
  AItem: TnInformacao;
begin
  Result := nil;
  AList  := FFila.LockList;
  try
    for AItem in AList do
    begin
      if AItem.Executando then
        Continue;

      Result            := AItem;
      Result.Executando := True;
      Break;
    end;
  finally
    FFila.UnlockList;
  end;
end;

procedure TnThreadExecutora.Execute;
var
  ARecurso: TnInformacao;
begin
  inherited;

  while not Terminated do
  begin
    ARecurso := BuscaRecurso;
    ProcessaRecurso(ARecurso);
    RemoverRecurso(ARecurso);
    Aguardar;
  end;
end;

procedure TnThreadExecutora.ProcessaRecurso(_ARecurso: TnInformacao);
var
  AProcessaRecurso: IProcessaRecurso;
begin
  if not Assigned(_ARecurso) then
    Exit;

  AProcessaRecurso := TnProcessaRecurso.Create;
  AProcessaRecurso.Executar(_ARecurso);
end;

procedure TnThreadExecutora.RemoverRecurso(_ARecurso: TnInformacao);
var
  AList: TList<TnInformacao>;
begin
  if not Assigned(_ARecurso) then
    Exit;

  AList := FFila.LockList;
  try
    if AList.IndexOf(_ARecurso) = -1 then
    begin
      AList.Remove(_ARecurso);
      FreeAndNil(_ARecurso);
    end;
  finally
    FFila.UnlockList;
  end;
end;

procedure TnThreadExecutora.Aguardar;
var
  ACount: Integer;
begin
  ACount := 0;
  while (not Terminated) and (ACount < 1) do
  begin
    Sleep(1000);
    Inc(ACount);
  end;
end;

end.
