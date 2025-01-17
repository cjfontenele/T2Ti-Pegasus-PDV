
unit Cfop;

interface

uses
  MVCFramework.Serializer.Commons,
  ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TCfop = Class(TModelBase)
  private
    FID : Integer;
    FCodigo : Integer;
    FDescricao : string;
    FAplicacao :  string;
  public

  [MVCColumnAttribute('ID',True)]
  [MVCNameAsAttribute('id')]
  property ID : Integer read FID write FID;
  [MVCColumnAttribute('CODIGO')]
  [MVCNameAsAttribute('codigo')]
  property Codigo : Integer read FCodigo write FCodigo;
  [MVCColumnAttribute('DESCRICAO')]
  [MVCNameAsAttribute('descricao')]
  property Descricao : string read FDescricao write FDescricao;
  [MVCColumnAttribute('APLICACAO')]
  [MVCNameAsAttribute('aplicacao')]
  property Aplicacao : string read FAplicacao write FAplicacao;

  End;
implementation

end.
