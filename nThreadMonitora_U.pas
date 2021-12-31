unit nThreadMonitora_U;

interface

uses
  System.Classes,
  System.Generics.Collections;

type
  TnThreadMonitora = class(TThread)
  private
    FList: TList<string>;
    procedure AdicionarRecurso;
    procedure Aguardar;
    procedure PreparaLista;

    function GetCount: Integer;
  protected
    procedure Execute; override;
  public
    constructor Create;
    destructor Destroy; override;

    property Count: Integer read GetCount;
  end;

implementation

uses
  System.SysUtils,
  nInformacao_U,
  nFila_U;

{ TnThreadMonitora }

constructor TnThreadMonitora.Create;
begin
  inherited Create(True);

  FreeOnTerminate := False;
  PreparaLista;
end;

procedure TnThreadMonitora.PreparaLista;
begin
  FList := TList<string>.Create;

  FList.Add('Um');
  FList.Add('Dois');
  FList.Add('Tres');
  FList.Add('Quatro');
  FList.Add('Cinco');
end;

procedure TnThreadMonitora.Execute;
begin
  inherited;

  while not Terminated do
  begin
    AdicionarRecurso;
    Aguardar;
  end;
end;

function TnThreadMonitora.GetCount: Integer;
begin
  Result := FList.Count;
end;

procedure TnThreadMonitora.AdicionarRecurso;
var
  AItem: string;
  AList: TList<TnInformacao>;
begin
  AList := FFila.LockList;
  try
    for AItem in FList do
    begin
      AList.Add(TnInformacao.Create);
      AList[AList.Count - 1].Mensagem   := AItem;
      AList[AList.Count - 1].Executando := False;
    end;
  finally
    FFila.UnlockList;
  end;
end;

procedure TnThreadMonitora.Aguardar;
var
  ACount: Integer;
begin
  ACount := 0;
  while (not Terminated) and (ACount < 10) do
  begin
    Sleep(1000);
    Inc(ACount);
  end;
end;

destructor TnThreadMonitora.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

end.
