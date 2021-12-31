unit nProcessaRecurso_U;

interface

uses
  IProcessaRecurso_U,
  nInformacao_U;

type
  TnProcessaRecurso = class(TInterfacedObject, IProcessaRecurso)
  private
    procedure Executar(_AInformacao: TnInformacao);
    procedure GravarSaida(_AMsg: string; _AThreadID: Cardinal);
  end;

implementation

uses
  IdHTTP,
  System.SysUtils,
  System.Classes;

{ TnProcessaRecurso }

procedure TnProcessaRecurso.Executar(_AInformacao: TnInformacao);
var
  AIdHTTP  : TIdHTTP;
  AResponse: string;
  AThreadID: Cardinal;
begin
  AIdHTTP := TIdHTTP.Create(nil);
  try
    AThreadID := TThread.CurrentThread.ThreadID;
    try
      AResponse := AIdHTTP.Get('http://127.0.0.1:9090/consulta/json/' + _AInformacao.Mensagem);

      GravarSaida(AResponse, AThreadID);
    except
      GravarSaida('Erro Thread ' + IntToStr(AThreadID) + ' ' + Exception(ExceptObject).Message, AThreadID);
    end;
  finally
    FreeAndNil(AIdHTTP);
  end;
end;

procedure TnProcessaRecurso.GravarSaida(_AMsg: string; _AThreadID: Cardinal);
var
  AArq: TextFile;
  AExt: string;
begin
  try
    try
      if _AMsg.Contains('erro') or _AMsg.Contains('Erro') or _AMsg.Contains('ERRO') then
        AExt := '.error'
      else
        AExt := '.log';

      AssignFile(AArq, '../../Saida/Thread_' + IntToStr(_AThreadID) + '_Time_' + FormatDateTime('hh_mm_ss_zzz', Now) + AExt);
      Rewrite(AArq);
      Writeln(AArq, _AMsg);
    finally
      CloseFile(AArq);
    end;
  except
  end;
end;

end.
