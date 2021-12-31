unit nListaThread_U;

interface

uses
  System.Generics.Collections,
  nThreadExecutora_U;

type
  TnListaThread = class(TObjectList<TnThreadExecutora>)
  private
    FCount: Integer;
    procedure Iniciar;
  public
    constructor Create(_ACount: Integer);
    procedure Parar;
  end;

implementation

{ TnListaThread }

constructor TnListaThread.Create(_ACount: Integer);
begin
  inherited Create(False);

  FCount := _ACount;
  Iniciar;
end;

procedure TnListaThread.Iniciar;
var
  ACount: Integer;
begin
  for ACount := 0 to FCount - 1 do
  begin
    Add(TnThreadExecutora.Create);
    Items[Count - 1].Start;
  end;
end;

procedure TnListaThread.Parar;
var
  AItem: TnThreadExecutora;
begin
  for AItem in Self do
  begin
    Remove(AItem);
    AItem.Suspended := True;
  end;
end;

end.
