unit nInformacao_U;

interface

type
  TnInformacao = class
  private
    FMensagem  : string;
    FExecutando: Boolean;

  public
    property Mensagem  : string  read FMensagem   write FMensagem;
    property Executando: Boolean read FExecutando write FExecutando;
  end;

implementation

end.
