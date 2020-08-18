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
