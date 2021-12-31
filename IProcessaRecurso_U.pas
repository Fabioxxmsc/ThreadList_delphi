unit IProcessaRecurso_U;

interface

uses
  nInformacao_U;

type
  IProcessaRecurso = interface
  ['{4C0147AD-4F69-4D19-B537-9FB7DE0DABD0}']
    procedure Executar(_AInformacao: TnInformacao);
  end;

implementation

end.
