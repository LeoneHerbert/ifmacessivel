import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:ifmaacessivel/src/models/questionario.dart';

class Relatorio {
  CollectionReference questionario =
      Firestore.instance.collection("criterios_de_acessibilidade");
  static List<Questionario> acessoAEdificacaoList;
  static List<Questionario> auditoriosList;
  static List<Questionario> banheirosList;
  static List<Questionario> bibliotecaList;
  static List<Questionario> calcadaList;
  static List<Questionario> circulacaoInternaList;
  static List<Questionario> esquadriasList;
  static List<Questionario> estacionamentoList;
  static List<Questionario> mobiliarioList;
  static List<Questionario> restaurantesList;
  static List<Questionario> vestiariosList;
  static double valorAcessoAEdificacao = 0;
  static double valorAuditorios = 0;
  static double valorBanheiros = 0;
  static double valorBiblioteca = 0;
  static double valorCalcada = 0;
  static double valorCirculacaoInterna = 0;
  static double valorEsquadrias = 0;
  static double valorEstacionamento = 0;
  static double valorMobiliario = 0;
  static double valorRestaurantes = 0;
  static double valorVestiarios = 0;
  static double valorTotalAcessoAEdificacao = 0;
  static double valorTotalAuditorios = 0;
  static double valorTotalBanheiros = 0;
  static double valorTotalBiblioteca = 0;
  static double valorTotalCalcada = 0;
  static double valorTotalCirculacaoInterna = 0;
  static double valorTotalEsquadrias = 0;
  static double valorTotalEstacionamento = 0;
  static double valorTotalMobiliario = 0;
  static double valorTotalRestaurantes = 0;
  static double valorTotalVestiarios = 0;

  Relatorio() {
    getCalcadaList();
    getAcessoAEdificacaoList();
    getAuditoriosList();
    getBanheirosList();
    getBibliotecaList();
    getCirculacaoInternaList();
    getEsquadriasList();
    getEstacionamentoList();
    getMobiliarioList();
    getRestaurantesList();
    getVestiariosList();
  }

  static void valorDeAcessibilidade() {
    valorAcessoAEdificacao = 0;
    valorAuditorios = 0;
    valorBanheiros = 0;
    valorBiblioteca = 0;
    valorCalcada = 0;
    valorCirculacaoInterna = 0;
    valorEsquadrias = 0;
    valorEstacionamento = 0;
    valorMobiliario = 0;
    valorRestaurantes = 0;
    valorVestiarios = 0;
    valorTotalAcessoAEdificacao = 0;
    valorTotalAuditorios = 0;
    valorTotalBanheiros = 0;
    valorTotalBiblioteca = 0;
    valorTotalCalcada = 0;
    valorTotalCirculacaoInterna = 0;
    valorTotalEsquadrias = 0;
    valorTotalEstacionamento = 0;
    valorTotalMobiliario = 0;
    valorTotalRestaurantes = 0;
    valorTotalVestiarios = 0;

    acessoAEdificacaoList.forEach((questionario) {
      valorTotalAcessoAEdificacao = valorTotalAcessoAEdificacao + questionario.q;
      if (questionario.situacao == 'Sim' || questionario.situacao == 'N/A') {
        valorAcessoAEdificacao = valorAcessoAEdificacao + questionario.q;
      }
    });
     auditoriosList.forEach((questionario) {
       valorTotalAuditorios = valorTotalAuditorios + questionario.q;
      if (questionario.situacao == 'Sim' || questionario.situacao == 'N/A') {
        valorAuditorios = valorAuditorios + questionario.q;
      }
    });
     banheirosList.forEach((questionario) {
       valorTotalBanheiros = valorTotalBanheiros + questionario.q;
      if (questionario.situacao == 'Sim' || questionario.situacao == 'N/A') {
        valorBanheiros = valorBanheiros + questionario.q;
      }
    });

    bibliotecaList.forEach((questionario) {
      valorTotalBiblioteca = valorTotalBiblioteca + questionario.q;
      if (questionario.situacao == 'Sim' || questionario.situacao == 'N/A') {
        valorBiblioteca = valorBiblioteca + questionario.q;
      }
    });
     calcadaList.forEach((questionario) {
       valorTotalCalcada = valorTotalCalcada + questionario.q;
      if (questionario.situacao == 'Sim' || questionario.situacao == 'N/A') {
        valorCalcada = valorCalcada + questionario.q;
      }
    });
     circulacaoInternaList.forEach((questionario) {
       valorTotalCirculacaoInterna = valorTotalCirculacaoInterna + questionario.q;
      if (questionario.situacao == 'Sim' || questionario.situacao == 'N/A') {
        valorCirculacaoInterna = valorCirculacaoInterna + questionario.q;
      }
    });
     esquadriasList.forEach((questionario) {
       valorTotalEsquadrias = valorTotalEsquadrias + questionario.q;
      if (questionario.situacao == 'Sim' || questionario.situacao == 'N/A') {
        valorEsquadrias = valorEsquadrias + questionario.q;
      }
    });
     estacionamentoList.forEach((questionario) {
       valorTotalEstacionamento = valorTotalEstacionamento + questionario.q;
      if (questionario.situacao == 'Sim' || questionario.situacao == 'N/A') {
        valorEstacionamento = valorEstacionamento + questionario.q;
      }
    });
     mobiliarioList.forEach((questionario) {
       valorTotalMobiliario = valorTotalMobiliario + questionario.q;
      if (questionario.situacao == 'Sim' || questionario.situacao == 'N/A') {
        valorMobiliario = valorMobiliario + questionario.q;
      }
    });
     restaurantesList.forEach((questionario) {
       valorTotalRestaurantes = valorTotalRestaurantes + questionario.q;
      if (questionario.situacao == 'Sim' || questionario.situacao == 'N/A') {
        valorRestaurantes = valorRestaurantes + questionario.q;
      }
    });
     vestiariosList.forEach((questionario) {
       valorTotalVestiarios = valorTotalVestiarios + questionario.q;
      if (questionario.situacao == 'Sim' || questionario.situacao == 'N/A') {
        valorVestiarios = valorVestiarios + questionario.q;
      }
    });
  }

  static double valorTotal(){
    double valorTotal = 0;
    valorTotal = valorVestiarios +
        valorRestaurantes +
        valorMobiliario +
        valorEstacionamento +
        valorEsquadrias +
        valorCirculacaoInterna +
        valorCalcada +
        valorBanheiros +
        valorAcessoAEdificacao +
        valorAuditorios +
        valorBiblioteca;
    return valorTotal;
  }

  void getAcessoAEdificacaoList() {
    questionario
        .document("Acesso à Edificação")
        .collection('itens')
        .snapshots()
        .listen(
      (data) {
        acessoAEdificacaoList = data.documents
            .map(
              (document) => Questionario(
                document.data['id'],
                document.data['texto'],
                document.data['q'],
                document.data['situacao'],
                "Acesso à Edificação",
                null,
              ),
            )
            .toList();
      },
    );
  }

  void getAuditoriosList() {
    questionario
        .document("Auditórios e Similares")
        .collection('itens')
        .snapshots()
        .listen(
      (data) {
        auditoriosList = data.documents
            .map(
              (document) => Questionario(
                document.data['id'],
                document.data['texto'],
                document.data['q'],
                document.data['situacao'],
                "Auditórios e Similares",
                null,
              ),
            )
            .toList();
      },
    );
  }

  void getBanheirosList() {
    questionario.document("Banheiros").collection('itens').snapshots().listen(
      (data) {
        banheirosList = data.documents
            .map(
              (document) => Questionario(
                document.data['id'],
                document.data['texto'],
                document.data['q'],
                document.data['situacao'],
                "Banheiros",
                null,
              ),
            )
            .toList();
      },
    );
  }

  void getBibliotecaList() {
    questionario.document("Biblioteca").collection('itens').snapshots().listen(
      (data) {
        bibliotecaList = data.documents
            .map(
              (document) => Questionario(
                document.data['id'],
                document.data['texto'],
                document.data['q'],
                document.data['situacao'],
                "Biblioteca",
                null,
              ),
            )
            .toList();
      },
    );
  }

  void getCalcadaList() {
    questionario.document("Calçada").collection('itens').snapshots().listen(
      (data) {
        calcadaList = data.documents
            .map(
              (document) => Questionario(
                document.data['id'],
                document.data['texto'],
                document.data['q'],
                document.data['situacao'],
                "Calçada",
                null,
              ),
            )
            .toList();
      },
    );
  }

  void getCirculacaoInternaList() {
    questionario
        .document("Circulação Interna")
        .collection('itens')
        .snapshots()
        .listen(
      (data) {
        circulacaoInternaList = data.documents
            .map(
              (document) => Questionario(
                document.data['id'],
                document.data['texto'],
                document.data['q'],
                document.data['situacao'],
                "Circulação Interna",
                null,
              ),
            )
            .toList();
      },
    );
  }

  void getEsquadriasList() {
    questionario.document("Esquadrias").collection('itens').snapshots().listen(
      (data) {
        esquadriasList = data.documents
            .map(
              (document) => Questionario(
                document.data['id'],
                document.data['texto'],
                document.data['q'],
                document.data['situacao'],
                "Esquadrias",
                null,
              ),
            )
            .toList();
      },
    );
  }

  void getEstacionamentoList() {
    questionario
        .document("Estacionamento")
        .collection('itens')
        .snapshots()
        .listen(
      (data) {
        estacionamentoList = data.documents
            .map(
              (document) => Questionario(
                document.data['id'],
                document.data['texto'],
                document.data['q'],
                document.data['situacao'],
                "Estacionamento",
                null,
              ),
            )
            .toList();
      },
    );
  }

  void getMobiliarioList() {
    questionario.document("Mobiliário").collection('itens').snapshots().listen(
      (data) {
        mobiliarioList = data.documents
            .map(
              (document) => Questionario(
                document.data['id'],
                document.data['texto'],
                document.data['q'],
                document.data['situacao'],
                "Mobiliário",
                null,
              ),
            )
            .toList();
      },
    );
  }

  void getRestaurantesList() {
    questionario
        .document("Restaurantes e Similares")
        .collection('itens')
        .snapshots()
        .listen(
      (data) {
        restaurantesList = data.documents
            .map(
              (document) => Questionario(
                document.data['id'],
                document.data['texto'],
                document.data['q'],
                document.data['situacao'],
                "Restaurantes e Similares",
                null,
              ),
            )
            .toList();
      },
    );
  }

  void getVestiariosList() {
    questionario.document("Vestiários").collection('itens').snapshots().listen(
      (data) {
        vestiariosList = data.documents
            .map(
              (document) => Questionario(
                document.data['id'],
                document.data['texto'],
                document.data['q'],
                document.data['situacao'],
                "Vestiários",
                null,
              ),
            )
            .toList();
      },
    );
  }
}
