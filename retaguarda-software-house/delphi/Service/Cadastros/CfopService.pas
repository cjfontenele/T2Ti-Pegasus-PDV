unit CfopService;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  ServiceBase,
  MVCFramework.DataSet.Utils,
  Cfop;

type

  TCfopService = class(TServiceBase)
  private

  public
    class function ConsultarLista: TObjectList<TCfop>;
    class function ConsultarListaFiltro(aWhere: string): TObjectList<TCfop>;
    class function ConsultarObjeto(aid: Integer): TCfop;
    class function ConsultarObjetoFiltro(aWhere: string): TCfop;
    class procedure Inserir(aCfop: TCfop);
    class function Alterar(aCfop: TCfop): Integer;
    class function Excluir(aCfop: TCfop): Integer;



  end;

var
  sql: string;

implementation

{ TCfopService }

class function TCfopService.Alterar(aCfop: TCfop): Integer;
begin
  aCfop.ValidarAlteracao;
  Result := AlterarBase(aCfop, 'CFOP');
end;

class function TCfopService.ConsultarLista: TObjectList<TCfop>;
begin
  sql := 'SELECT * FROM CFOP ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TCfop>;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TCfopService.ConsultarListaFiltro(
  aWhere: string): TObjectList<TCfop>;
begin
  sql := 'SELECT * FROM CFOP where ' + AWhere;
  try
    Result := GetQuery(sql).AsObjectList<TCfop>;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TCfopService.ConsultarObjeto(aid: Integer): TCfop;
begin
  sql := 'SELECT * FROM CFOP WHERE ID = ' + IntToStr(aid);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TCfop>;
    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TCfopService.ConsultarObjetoFiltro(aWhere: string): TCfop;
begin
  sql := 'SELECT * FROM CFOP where ' + AWhere;
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TCfop>;
    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TCfopService.Excluir(aCfop: TCfop): Integer;
begin

  Result := ExcluirBase(aCfop.id, 'CFOP');
end;

class procedure TCfopService.Inserir(aCfop: TCfop);
begin
  aCfop.Id := InserirBase(aCfop, 'CFOP');
end;

end.