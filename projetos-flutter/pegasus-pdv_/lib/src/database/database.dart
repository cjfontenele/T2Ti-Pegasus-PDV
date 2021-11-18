import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';

import 'package:path_provider/path_provider.dart' as paths;
import 'package:path/path.dart' as p;

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/database/migracao.dart';

import 'database_classes.dart';

part 'database.g.dart';

LazyDatabase _openConnection() {
    if (Biblioteca.isMobile()) {
      final executor = LazyDatabase(() async {
        final dataDir = await paths.getApplicationDocumentsDirectory();
        Sessao.caminhoBancoDados = p.join(dataDir.path, 'pegasus.sqlite');
        final dbFile = File(Sessao.caminhoBancoDados);
        return VmDatabase(dbFile, logStatements: true);
      });
      return executor;
    } else if (Platform.isWindows) {
      final executor = LazyDatabase(() async {
        final dataDir = await paths.getApplicationDocumentsDirectory();
        Sessao.caminhoBancoDados = p.join(dataDir.path, 'pegasus.sqlite');
        final dbFile = File(Sessao.caminhoBancoDados);
        // final dbFile = File('pegasus.sqlite');
        return VmDatabase(dbFile, logStatements: true);
      });
      return executor;        
    }
    return LazyDatabase(() async {
      return VmDatabase.memory(logStatements: true);
    });
}

@UseMoor(
  tables: [
    Cfops,
    Clientes,
    Colaboradors,
    CompraPedidoCabecalhos,
    CompraPedidoDetalhes,
    Contadors,
    ContasPagars,
    ContasRecebers,
    EcfAliquotass,
    EcfDocumentosEmitidoss,
    EcfE3s,
    EcfImpressoras,
    EcfLogTotaiss,
    EcfR01s,
    EcfR02s,
    EcfR03s,
    EcfR06s,
    EcfR07s,
    EcfRecebimentoNaoFiscals,
    EcfRelatorioGerencials,
    EcfSintegra60As,
    EcfSintegra60Ms,
    Empresas,
    Fornecedors,
    Ibpts,
    LogImportacaos,
    PdvCaixas,
    PdvConfiguracaos,
    PdvConfiguracaoBalancas,
    PdvConfiguracaoLeitorSerials,
    PdvFechamentos,
    PdvMovimentos,
    PdvOperadors,
    PdvSangrias,
    PdvSuprimentos,
    PdvTipoPagamentos,
    PdvTotalTipoPagamentos,
    PdvVendaCabecalhos,
    PdvVendaDetalhes,
    Produtos,
    ProdutoFichaTecnicas,
    ProdutoPromocaos,
    ProdutoUnidades,
    NfeAcessoXmls,
    NfeCabecalhos,
    NfeCanas,
    NfeCanaDeducoesSafras,
    NfeCanaFornecimentoDiarios,
    NfeConfiguracaos,
    NfeCteReferenciados,
    NfeCupomFiscalReferenciados,
    NfeDeclaracaoImportacaos,
    NfeDestinatarios,
    NfeDetEspecificoArmamentos,
    NfeDetEspecificoCombustivels,
    NfeDetEspecificoMedicamentos,
    NfeDetEspecificoVeiculos,
    NfeDetalhes,
    NfeDetalheImpostoCofinss,
    NfeDetalheImpostoCofinsSts,
    NfeDetalheImpostoIcmss,
    NfeDetalheImpostoIcmsUfdests,
    NfeDetalheImpostoIis,
    NfeDetalheImpostoIpis,
    NfeDetalheImpostoIssqns,
    NfeDetalheImpostoPiss,
    NfeDetalheImpostoPisSts,
    NfeDuplicatas,
    NfeEmitentes,
    NfeExportacaos,
    NfeFaturas,
    NfeImportacaoDetalhes,
    NfeInformacaoPagamentos,
    NfeItemRastreados,
    NfeLocalEntregas,
    NfeLocalRetiradas,
    NfeNfReferenciadas,
    NfeNumeros,
    NfeNumeroInutilizados,
    NfeProcessoReferenciados,
    NfeProdRuralReferenciadas,
    NfeReferenciadas,
    NfeResponsavelTecnicos,
    NfeTransportes,
    NfeTransporteReboques,
    NfeTransporteVolumes,
    NfeTransporteVolumeLacres,
    NfcePlanoPagamentos,
    TributCofinss,
    TributConfiguraOfGts,
    TributGrupoTributarios,
    TributIcmsCustomCabs,
    TributIcmsCustomDets,
    TributIcmsUfs,
    TributIpis,
    TributIsss,
    TributOperacaoFiscals,
    TributPiss,
 ], 
  daos: [
    CfopDao,
    ClienteDao,
    ColaboradorDao,
    CompraPedidoCabecalhoDao,
    CompraPedidoDetalheDao,
    ContadorDao,
    ContasPagarDao,
    ContasReceberDao,
    EcfAliquotasDao,
    EcfDocumentosEmitidosDao,
    EcfE3Dao,
    EcfImpressoraDao,
    EcfLogTotaisDao,
    EcfR01Dao,
    EcfR02Dao,
    EcfR03Dao,
    EcfR06Dao,
    EcfR07Dao,
    EcfRecebimentoNaoFiscalDao,
    EcfRelatorioGerencialDao,
    EcfSintegra60ADao,
    EcfSintegra60MDao,
    EmpresaDao,
    FornecedorDao,
    IbptDao,
    LogImportacaoDao,
    PdvCaixaDao,
    PdvConfiguracaoDao,
    PdvConfiguracaoBalancaDao,
    PdvConfiguracaoLeitorSerialDao,
    PdvFechamentoDao,
    PdvMovimentoDao,
    PdvOperadorDao,
    PdvSangriaDao,
    PdvSuprimentoDao,
    PdvTipoPagamentoDao,
    PdvTotalTipoPagamentoDao,
    PdvVendaCabecalhoDao,
    PdvVendaDetalheDao,
    ProdutoDao,
    ProdutoFichaTecnicaDao,
    ProdutoPromocaoDao,
    ProdutoUnidadeDao,
    NfeCabecalhoDao,
    NfeConfiguracaoDao,
    NfeNumeroDao,
    NfeNumeroInutilizadoDao,
    NfcePlanoPagamentoDao,
    TributConfiguraOfGtDao,
    TributGrupoTributarioDao,
    TributIcmsCustomCabDao,
    TributOperacaoFiscalDao,
    TributIcmsUfDao,
    TributIpiDao,
    TributIssDao,
    TributPisDao,
  ],
    )
class AppDatabase extends _$AppDatabase {
  // we tell the database where to store the data with this constructor
  AppDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition.
  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
      await _popularBanco(this);
      await _popularBancoSchema02(this);
      await _popularBancoSchema03(this);
      await _popularBancoSchema04(this);
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from == 1) {
        await MigracaoParaSchema2(this).migrarParaSchema2(m, from, to);
        await _popularBancoSchema02(this);
        await MigracaoParaSchema3(this).migrarParaSchema3(m, from, to);
        await _popularBancoSchema03(this);
        await MigracaoParaSchema4(this).migrarParaSchema4(m, from, to);
        await _popularBancoSchema04(this);
      } 
      if (from == 2) {
        await MigracaoParaSchema3(this).migrarParaSchema3(m, from, to);
        await _popularBancoSchema03(this);
        await MigracaoParaSchema4(this).migrarParaSchema4(m, from, to);
        await _popularBancoSchema04(this);
      }
      if (from == 3) {
        await MigracaoParaSchema4(this).migrarParaSchema4(m, from, to);
        await _popularBancoSchema04(this);
      }
    },    
  );

}

Future<void> _popularBancoSchema04(AppDatabase db) async {
  // ---> CONFIGURACAO PDV
  db.customStatement("UPDATE PDV_CONFIGURACAO SET DECIMAIS_QUANTIDADE = '3', DECIMAIS_VALOR = '2' WHERE ID = 1");
  // ---> TIPO PAGAMENTO
  db.customStatement("UPDATE PDV_TIPO_PAGAMENTO SET CODIGO_PAGAMENTO_NFCE = '01' WHERE CODIGO = '01'");
  db.customStatement("UPDATE PDV_TIPO_PAGAMENTO SET CODIGO = '02', CODIGO_PAGAMENTO_NFCE = '02' WHERE CODIGO = '04'");
  db.customStatement("UPDATE PDV_TIPO_PAGAMENTO SET CODIGO_PAGAMENTO_NFCE = '03' WHERE CODIGO = '03'");
  // ---> NFE_NUMERO
  await db.customStatement("INSERT INTO NFE_NUMERO (ID, MODELO, SERIE, NUMERO) VALUES (1, '65', '1', '1')");
  // ---> NFE_CONFIGURACAO
  await db.customStatement("INSERT INTO NFE_CONFIGURACAO "
  "(ID, FORMATO_IMPRESSAO_DANFE, WEBSERVICE_AMBIENTE, NFCE_MODELO_IMPRESSAO, NFCE_IMPRIMIR_ITENS_UMA_LINHA, NFCE_IMPRIMIR_DESCONTO_POR_ITEM, NFCE_IMPRIMIR_QRCODE_LATERAL, NFCE_IMPRIMIR_GTIN, NFCE_IMPRIMIR_NOME_FANTASIA, NFCE_ID_CSC, NFCE_CSC, NFCE_IMPRESSAO_TRIBUTOS, NFCE_MARGEM_SUPERIOR, NFCE_MARGEM_INFERIOR, NFCE_MARGEM_DIREITA, NFCE_MARGEM_ESQUERDA, NFCE_RESOLUCAO_IMPRESSAO, NFCE_TAMANHO_FONTE_ITEM) "
  "VALUES (1, '4', '2', '80', 'S', 'N', 'S', 'N', 'N', '0', '0', 'S', '0.80', '0.80', '0.7', '0.7', '280', '7')");
}

Future<void> _popularBancoSchema03(AppDatabase db) async {
  // ---> TRIBUT_GRUPO_TRIBUTARIO
  await db.customStatement("INSERT INTO TRIBUT_GRUPO_TRIBUTARIO (ID, DESCRICAO, ORIGEM_MERCADORIA) VALUES (1, 'PRODUTO DE FABRICACAO PROPRIA', '0')");
  await db.customStatement("INSERT INTO TRIBUT_GRUPO_TRIBUTARIO (ID, DESCRICAO, ORIGEM_MERCADORIA) VALUES (2, 'PRODUTO ADQUIRIDO OU RECEBIDO DE TERCEIROS', '0')");
  // ---> TRIBUT_OPERACAO_FISCAL
  await db.customStatement("INSERT INTO TRIBUT_OPERACAO_FISCAL (ID, DESCRICAO, OBSERVACAO) VALUES (1, 'VENDA DE PRODUCAO DO ESTABELECIMENTO', 'NORMALMENTE ESTA OPERACAO FISCAL SERA VINCULADA AO CFOP 5.101 E PODERA SER VINCULADA A UM OU MAIS CST OU CSOSN')");
  await db.customStatement("INSERT INTO TRIBUT_OPERACAO_FISCAL (ID, DESCRICAO, OBSERVACAO) VALUES (2, 'VENDA DE MERCADORIA ADQUIRIDA OU RECEBIDA DE TERCEIROS', 'NORMALMENTE UTILIZADO COM O CFOP 5.102 EM COMBINACAO COM CST OU CSOSN.')");
  // ---> TRIBUT_CONFIGURA_OF_GT
  await db.customStatement("INSERT INTO TRIBUT_CONFIGURA_OF_GT (ID, ID_TRIBUT_GRUPO_TRIBUTARIO, ID_TRIBUT_OPERACAO_FISCAL) VALUES (1, 1, 1)");
  await db.customStatement("INSERT INTO TRIBUT_CONFIGURA_OF_GT (ID, ID_TRIBUT_GRUPO_TRIBUTARIO, ID_TRIBUT_OPERACAO_FISCAL) VALUES (2, 2, 2)");
  // ---> TRIBUT_ICMS_UF
  await db.customStatement("INSERT INTO TRIBUT_ICMS_UF (ID, ID_TRIBUT_CONFIGURA_OF_GT, CFOP, CSOSN, CST) VALUES (1, 1, 5101, '102', '00')");
  await db.customStatement("INSERT INTO TRIBUT_ICMS_UF (ID, ID_TRIBUT_CONFIGURA_OF_GT, CFOP, CSOSN, CST) VALUES (2, 2, 5102, '102', '00')");
  // ---> TRIBUT_PIS
  await db.customStatement("INSERT INTO TRIBUT_PIS (ID, ID_TRIBUT_CONFIGURA_OF_GT, CST_PIS, MODALIDADE_BASE_CALCULO, ALIQUOTA_PORCENTO) VALUES (1, 1, '99', '0', 0)");
  await db.customStatement("INSERT INTO TRIBUT_PIS (ID, ID_TRIBUT_CONFIGURA_OF_GT, CST_PIS, MODALIDADE_BASE_CALCULO, ALIQUOTA_PORCENTO) VALUES (2, 2, '99', '0', 0)");

  // ---> TRIBUT_COFINS
  await db.customStatement("INSERT INTO TRIBUT_COFINS (ID, ID_TRIBUT_CONFIGURA_OF_GT, CST_COFINS, MODALIDADE_BASE_CALCULO, ALIQUOTA_PORCENTO) VALUES (1, 1, '99', '0', 0)");
  await db.customStatement("INSERT INTO TRIBUT_COFINS (ID, ID_TRIBUT_CONFIGURA_OF_GT, CST_COFINS, MODALIDADE_BASE_CALCULO, ALIQUOTA_PORCENTO) VALUES (2, 2, '99', '0', 0)");
}


Future<void> _popularBancoSchema02(AppDatabase db) async {
  // ---> CONFIGURACAO PDV
  await db.customStatement("INSERT INTO PDV_CONFIGURACAO (ID, MODULO, RECIBO_FORMATO_PAGINA, RECIBO_LARGURA_PAGINA, RECIBO_MARGEM_PAGINA, PERMITE_ESTOQUE_NEGATIVO) VALUES (1, 'G', 'A4', NULL, NULL, 'S')");
}

Future<void> _popularBanco(AppDatabase db) async {
  // ***
  // DADOS PARA PRODUÇÃO
  // ***
  // ---> TIPO PAGAMENTO
  db.customStatement("INSERT INTO PDV_TIPO_PAGAMENTO (ID, CODIGO, DESCRICAO, TEF, IMPRIME_VINCULADO, PERMITE_TROCO, TEF_TIPO_GP, GERA_PARCELAS) VALUES (1, '01', 'DINHEIRO', 'N', 'N', 'S', 'N', 'N')");
  db.customStatement("INSERT INTO PDV_TIPO_PAGAMENTO (ID, CODIGO, DESCRICAO, TEF, IMPRIME_VINCULADO, PERMITE_TROCO, TEF_TIPO_GP, GERA_PARCELAS) VALUES (2, '04', 'CHEQUE', 'N', 'S', 'N', 'N', 'N')");
  db.customStatement("INSERT INTO PDV_TIPO_PAGAMENTO (ID, CODIGO, DESCRICAO, TEF, IMPRIME_VINCULADO, PERMITE_TROCO, TEF_TIPO_GP, GERA_PARCELAS) VALUES (3, '03', 'CARTAO', 'S', 'S', 'N', '1', 'N')");
  // ---> EMPRESA
  db.customStatement("INSERT INTO EMPRESA (ID, RAZAO_SOCIAL, NOME_FANTASIA) VALUES (1, 'RAZAO SOCIAL DA EMPRESA', 'NOME DE FANTASIA DA EMPRESA')");
  // ---> COLABORADOR
  db.customStatement("INSERT INTO COLABORADOR (ID, NOME) VALUES (1, 'ADMINISTRADOR')");
  // ---> CLIENTE
  db.customStatement("INSERT INTO CLIENTE (ID, TIPO_PESSOA, NOME) VALUES (1, 'Física', 'CLIENTE PF PADRAO')");
  // ---> UNIDADE
  db.customStatement("INSERT INTO PRODUTO_UNIDADE (ID, SIGLA, DESCRICAO, PODE_FRACIONAR) VALUES (1, 'KG', NULL, 'S')");
  db.customStatement("INSERT INTO PRODUTO_UNIDADE (ID, SIGLA, DESCRICAO, PODE_FRACIONAR) VALUES (2, 'UND', NULL, 'N')");
  db.customStatement("INSERT INTO PRODUTO_UNIDADE (ID, SIGLA, DESCRICAO, PODE_FRACIONAR) VALUES (3, 'MT', NULL, 'S')");
  db.customStatement("INSERT INTO PRODUTO_UNIDADE (ID, SIGLA, DESCRICAO, PODE_FRACIONAR) VALUES (4, 'M2', NULL, 'S')");
  db.customStatement("INSERT INTO PRODUTO_UNIDADE (ID, SIGLA, DESCRICAO, PODE_FRACIONAR) VALUES (5, 'M3', NULL, 'S')");
  db.customStatement("INSERT INTO PRODUTO_UNIDADE (ID, SIGLA, DESCRICAO, PODE_FRACIONAR) VALUES (6, 'PCT', NULL, 'N')");
  db.customStatement("INSERT INTO PRODUTO_UNIDADE (ID, SIGLA, DESCRICAO, PODE_FRACIONAR) VALUES (7, 'CX', NULL, 'N')");
  db.customStatement("INSERT INTO PRODUTO_UNIDADE (ID, SIGLA, DESCRICAO, PODE_FRACIONAR) VALUES (10, 'PC', 'PACOTE', 'N')");
  // ---> PRODUTO
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (1,1,'3011010827133','30113','01 PRODUTO PARA TESTES','01 PRODUTO PARA TESTES','01 PRODUTO PARA TESTES','10.000000','-168.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'7.000000','000','1900','04T0700','07',NULL,'T','859dba8c255ea32d52d40a880a0a66d0')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (2,1,'0312011604499','03129','02 PRODUTO PARA TESTES','02 PRODUTO PARA TESTES','02 PRODUTO PARA TESTES','35.000000','38.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'7.000000','000','1900','04T0700','07',NULL,'T','36b2f8acbf6b3415593761c3375a5376')");


  // ***
  // DADOS PARA TESTE
  // ***
  // ---> PRODUTO
  /*
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (1,1,'3011010827133','30113','01 PRODUTO TRIBUTADO A 7%','01 PRODUTO TRIBUTADO A 7%','01 PRODUTO TRIBUTADO A 7%','10.000000','-168.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'7.000000','000','1900','04T0700','07',NULL,'T','859dba8c255ea32d52d40a880a0a66d0')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (2,1,'0312011604499','03129','02 PRODUTO TRIBUTADO A 7%','02 PRODUTO TRIBUTADO A 7%','02 PRODUTO TRIBUTADO A 7%','35.000000','38.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'7.000000','000','1900','04T0700','07',NULL,'T','36b2f8acbf6b3415593761c3375a5376')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (3,2,'0001170000005','00015','01 SERVICO TRIBUTADO A 5%','01 SERVICO TRIBUTADO A 5%','01 SERVICO TRIBUTADO A 5%','1200.000000','22.000000','10.000000','1000.000000','A','T','40129010','04',NULL,'5.000000',NULL,NULL,'0.000000','090','1900','01S0500','05',NULL,'S','b91a39fd72ad76bc7a5dea5c86761806')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (4,2,'0001180000002','00012','SERVICO TRIBUTADO A 3%','SERVICO TRIBUTADO A 3%','SERVICO TRIBUTADO A 3%','558.000000','42.000000','10.000000','1000.000000','A','T','40129010','04',NULL,'3.000000',NULL,NULL,'0.000000','090','1900','02S0300','03',NULL,'S','518ed490b056ead636e3ff57d7640b75')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (5,3,'0001190000009','00019','01 PRODUTO TIBUTADO A 12%','01 PRODUTO TIBUTADO A 12%','01 PRODUTO TIBUTADO A 12%','120.000000','35.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'12.000000','000','1900','03T1200','12',NULL,'T','29cd753d019190b64bd2bf55c3353e19')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (6,4,'0001234567898','00018','PRODUTO TRIBUTADO A 17%','PRODUTO TRIBUTADO A 17%','PRODUTO TRIBUTADO A 17%','5.800000','16.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'17.000000','000','1900','05T1700','17',NULL,'T','8a29a9d84d507fd9e2f9a2918859224a')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (7,5,'0407011150500','04070','PRODUTO TRIBUTADO A 25%','PRODUTO TRIBUTADO A 25%','PRODUTO TRIBUTADO A 25%','29.800000','13.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'25.000000','000','1900','02T2500','25',NULL,'T','121944f630e7b552a79f895671a11dd1')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (8,6,'1603041234428','16038','PRODUTO ISENTO','PRODUTO ISENTO','PRODUTO ISENTO','120.000000','35.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'0.000000','040','1900','I1','II',NULL,'I','8c7c178fceea111998be13d20fc57480')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (9,7,'0507021132142','05072','PRODUTO SUBSTITUICAO TRIBUTARIA','PRODUTO SUBSTITUICAO TRIBUTARIA','PRODUTO SUBSTITUICAO TRIBUTARI','30.000000','27.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'0.000000','010','1900','F1','FF',NULL,'F','c456e7cb91bf7c3d2127891a40a63d80')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (10,1,'1','25098','PRODUTO NAO TRIBUTADO','PRODUTO NAO TRIBUTADO','PRODUTO NAO TRIBUTADO','558.000000','41.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'0.000000','041','1900','N1','NN',NULL,'N','b4305c923540d030f45d98ce3b0f38ff')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (11,2,'2608021532487','26087','02 PRODUTO TIBUTADO A 12%','02 PRODUTO TIBUTADO A 12%','02 PRODUTO TIBUTADO A 12%','30.000000','46.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'12.000000','000','1900','03T1200','12',NULL,'T','460ebcb1e29360a7492b3ab7657b0757')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (12,2,'2106021651318','21068','02 SERVICO TRIBUTADO A 5%','02 SERVICO TRIBUTADO A 5%','1','700.000000','21.000000','10.000000','1000.000000','A','T','40129010','04',NULL,'5.000000',NULL,NULL,'0.000000','090','1900','01S0500','05',NULL,'S','4c40bda38afb88a3c69297d499bbbf8e')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (13,1,'1234567894568','12348','PRODUTO PARA DAV POR 350','PRODUTO PARA DAV POR 350','PRODUTO PARA DAV POR 350','350.000000','94.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'17.000000','000','1900','05T1700','17',NULL,'T','9bf519e02b39ad60a8269871035d0aa8')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (14,1,'5488654654665','54885','PRODUTO PARA PRE VENDA POR 90','PRODUTO PARA PRE VENDA POR 90','PRODUTO PARA PRE VENDA POR 90','90.000000','92.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'17.000000','000','1900','05T1700','17',NULL,'T','a009db059cf4c65dd2fb1d90649d88b3')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (15,1,'8797897998555','87985','PRODUTO PARA TESTE VALOR 200','PRODUTO PARA TESTE VALOR 200','PRODUTO PARA TESTE VALOR 200','200.000000','1.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'17.000000','000','1900','05T1700','17',NULL,'T','7ea7b58ecfb223193ea592fa9f49e153')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (16,1,'5555554444564','55554','PRODUTO PARA TESTE VALOR 150','PRODUTO PARA TESTE VALOR 150','PRODUTO PARA TESTE VALOR 150','150.000000','99.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'17.000000','000','1900','05T1700','17',NULL,'T','6a590c5d1e68242fd54db9a15337d7ae')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (17,1,'6465487987999','64659','PRODUTO PARA TESTE VALOR 30','PRODUTO PARA TESTE VALOR 30','PRODUTO PARA TESTE VALOR 30','30.000000','99.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'17.000000','000','1900','05T1700','17',NULL,'T','aa12c8f26747b7045d1b84bbc7a4a16c')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (18,1,'8521479787998','85218','PRODUTO PARA TESTE VALOR 500','PRODUTO PARA TESTE VALOR 500','PRODUTO PARA TESTE VALOR 500','500.000000','90.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'17.000000','000','1900','05T1700','17',NULL,'T','4f0cb6bde3d96dcb765d6d4c86385334')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (19,1,'8798546521325','87985','PRODUTO PARA TESTE VALOR 50','PRODUTO PARA TESTE VALOR 50','PRODUTO PARA TESTE VALOR 50','49.000000','96.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'17.000000','000','1900','05T1700','17',NULL,'T','a5a5d92ef483a3241900464eb8d6b0b1')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (20,1,'2581473698888','25818','PRODUTO PARA TESTE VALOR 20','PRODUTO PARA TESTE VALOR 20','PRODUTO PARA TESTE VALOR 20','20.000000','76.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'17.000000','000','1900','05T1700','05',NULL,'T','29d89983b44756d39a2926f4be6362aa')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (21,1,'9876465431323','98763','PRODUTO PARA TESTE VALOR 140','PRODUTO PARA TESTE VALOR 140','PRODUTO PARA TESTE VALOR 140','140.000000','57.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'15.000000','000','1900','05T1700','17',NULL,'T','3f2338b4a6e906b4547518d4955c7790')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (23,1,'2548798532156','25486','PRODUTO DE PRODUCAO PROPRIA','PRODUTO DE PRODUCAO PROPRIA','PRODUTO DE PRODUCAO PROPRIA','10.000000','100.000000','10.000000','1000.000000','A','P','40129010','04',NULL,NULL,NULL,NULL,'17.000000','000','1900','05T1700','17',NULL,'T','342753e90364d1e2e30314c33807527e')");
	*/
	
  // popular CFOP

  // popular IBPT
}
