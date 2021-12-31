unit nFila_U;

interface

uses
  System.Generics.Collections,
  nInformacao_U;

type
  TnFila = class(TThreadList<TnInformacao>)
  public
    procedure InsertFirst(_AItem: TnInformacao);
    constructor Create;
  end;

var
  FFila: TnFila;

implementation

uses
  System.SysUtils,
  System.Classes,
  System.RTLConsts;

{ TnFila }

constructor TnFila.Create;
begin
  inherited Create;
  Duplicates := dupAccept;
end;

procedure TnFila.InsertFirst(_AItem: TnInformacao);
var
  AList: TList<TnInformacao>;
begin
  AList := LockList;
  try
    if (Duplicates = dupAccept) or (AList.IndexOf(_AItem) = -1) then
      AList.Insert(0, _AItem)
    else
    if Duplicates = dupError then
      raise EListError.CreateResFmt(@SDuplicateItem, [AList.ItemValue(_AItem)]);
  finally
    UnlockList;
  end;
end;

initialization
  FFila := TnFila.Create;

finalization
  Freeandnil(FFila);

end.
