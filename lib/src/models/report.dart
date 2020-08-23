import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ifmaacessivel/src/models/questionnaire.dart';

class Report {
  CollectionReference questionnaire =
      Firestore.instance.collection("criterios_de_acessibilidade");
  static List<Questionnaire> acessoAEdificacaoList;
  static List<Questionnaire> auditoriosList;
  static List<Questionnaire> banheirosList;
  static List<Questionnaire> bibliotecaList;
  static List<Questionnaire> calcadaList;
  static List<Questionnaire> circulacaoInternaList;
  static List<Questionnaire> esquadriasList;
  static List<Questionnaire> estacionamentoList;
  static List<Questionnaire> mobiliarioList;
  static List<Questionnaire> restaurantesList;
  static List<Questionnaire> vestiariosList;
  static double valueAcessoAEdificacao = 0;
  static double valueAuditorios = 0;
  static double valueBanheiros = 0;
  static double valueBiblioteca = 0;
  static double valueCalcada = 0;
  static double valueCirculacaoInterna = 0;
  static double valueEsquadrias = 0;
  static double valueEstacionamento = 0;
  static double valueMobiliario = 0;
  static double valueRestaurantes = 0;
  static double valueVestiarios = 0;
  static double totalValueAcessoAEdificacao = 0;
  static double totalValueAuditorios = 0;
  static double totalValueBanheiros = 0;
  static double totalValueBiblioteca = 0;
  static double totalValueCalcada = 0;
  static double totalValueCirculacaoInterna = 0;
  static double totalValueEsquadrias = 0;
  static double totalValueEstacionamento = 0;
  static double totalValueMobiliario = 0;
  static double totalValueRestaurantes = 0;
  static double totalValueVestiarios = 0;

  Report() {
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

  static void acessibilityValue() {
    valueAcessoAEdificacao = 0;
    valueAuditorios = 0;
    valueBanheiros = 0;
    valueBiblioteca = 0;
    valueCalcada = 0;
    valueCirculacaoInterna = 0;
    valueEsquadrias = 0;
    valueEstacionamento = 0;
    valueMobiliario = 0;
    valueRestaurantes = 0;
    valueVestiarios = 0;
    totalValueAcessoAEdificacao = 0;
    totalValueAuditorios = 0;
    totalValueBanheiros = 0;
    totalValueBiblioteca = 0;
    totalValueCalcada = 0;
    totalValueCirculacaoInterna = 0;
    totalValueEsquadrias = 0;
    totalValueEstacionamento = 0;
    totalValueMobiliario = 0;
    totalValueRestaurantes = 0;
    totalValueVestiarios = 0;

    acessoAEdificacaoList.forEach((questionnaire) {
      totalValueAcessoAEdificacao = totalValueAcessoAEdificacao + questionnaire.q;
      if (questionnaire.situation == 'Sim' || questionnaire.situation == 'N/A') {
        valueAcessoAEdificacao = valueAcessoAEdificacao + questionnaire.q;
      }
    });
     auditoriosList.forEach((questionnaire) {
       totalValueAuditorios = totalValueAuditorios + questionnaire.q;
      if (questionnaire.situation == 'Sim' || questionnaire.situation == 'N/A') {
        valueAuditorios = valueAuditorios + questionnaire.q;
      }
    });
     banheirosList.forEach((questionnaire) {
       totalValueBanheiros = totalValueBanheiros + questionnaire.q;
      if (questionnaire.situation == 'Sim' || questionnaire.situation == 'N/A') {
        valueBanheiros = valueBanheiros + questionnaire.q;
      }
    });

    bibliotecaList.forEach((questionnaire) {
      totalValueBiblioteca = totalValueBiblioteca + questionnaire.q;
      if (questionnaire.situation == 'Sim' || questionnaire.situation == 'N/A') {
        valueBiblioteca = valueBiblioteca + questionnaire.q;
      }
    });
     calcadaList.forEach((questionnaire) {
       totalValueCalcada = totalValueCalcada + questionnaire.q;
      if (questionnaire.situation == 'Sim' || questionnaire.situation == 'N/A') {
        valueCalcada = valueCalcada + questionnaire.q;
      }
    });
     circulacaoInternaList.forEach((questionnaire) {
       totalValueCirculacaoInterna = totalValueCirculacaoInterna + questionnaire.q;
      if (questionnaire.situation == 'Sim' || questionnaire.situation == 'N/A') {
        valueCirculacaoInterna = valueCirculacaoInterna + questionnaire.q;
      }
    });
     esquadriasList.forEach((questionnaire) {
       totalValueEsquadrias = totalValueEsquadrias + questionnaire.q;
      if (questionnaire.situation == 'Sim' || questionnaire.situation == 'N/A') {
        valueEsquadrias = valueEsquadrias + questionnaire.q;
      }
    });
     estacionamentoList.forEach((questionnaire) {
       totalValueEstacionamento = totalValueEstacionamento + questionnaire.q;
      if (questionnaire.situation == 'Sim' || questionnaire.situation == 'N/A') {
        valueEstacionamento = valueEstacionamento + questionnaire.q;
      }
    });
     mobiliarioList.forEach((questionnaire) {
       totalValueMobiliario = totalValueMobiliario + questionnaire.q;
      if (questionnaire.situation == 'Sim' || questionnaire.situation == 'N/A') {
        valueMobiliario = valueMobiliario + questionnaire.q;
      }
    });
     restaurantesList.forEach((questionnaire) {
       totalValueRestaurantes = totalValueRestaurantes + questionnaire.q;
      if (questionnaire.situation == 'Sim' || questionnaire.situation == 'N/A') {
        valueRestaurantes = valueRestaurantes + questionnaire.q;
      }
    });
     vestiariosList.forEach((questionnaire) {
       totalValueVestiarios = totalValueVestiarios + questionnaire.q;
      if (questionnaire.situation == 'Sim' || questionnaire.situation == 'N/A') {
        valueVestiarios = valueVestiarios + questionnaire.q;
      }
    });
  }

  static double totalValue(){
    double totalValue = 0;
    totalValue = valueVestiarios +
        valueRestaurantes +
        valueMobiliario +
        valueEstacionamento +
        valueEsquadrias +
        valueCirculacaoInterna +
        valueCalcada +
        valueBanheiros +
        valueAcessoAEdificacao +
        valueAuditorios +
        valueBiblioteca;
    return totalValue;
  }

  void getAcessoAEdificacaoList() {
    questionnaire
        .document("Acesso à Edificação")
        .collection('itens')
        .snapshots()
        .listen(
      (data) {
        acessoAEdificacaoList = data.documents
            .map(
              (document) => Questionnaire(
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
    questionnaire
        .document("Auditórios e Similares")
        .collection('itens')
        .snapshots()
        .listen(
      (data) {
        auditoriosList = data.documents
            .map(
              (document) => Questionnaire(
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
    questionnaire.document("Banheiros").collection('itens').snapshots().listen(
      (data) {
        banheirosList = data.documents
            .map(
              (document) => Questionnaire(
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
    questionnaire.document("Biblioteca").collection('itens').snapshots().listen(
      (data) {
        bibliotecaList = data.documents
            .map(
              (document) => Questionnaire(
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
    questionnaire.document("Calçada").collection('itens').snapshots().listen(
      (data) {
        calcadaList = data.documents
            .map(
              (document) => Questionnaire(
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
    questionnaire
        .document("Circulação Interna")
        .collection('itens')
        .snapshots()
        .listen(
      (data) {
        circulacaoInternaList = data.documents
            .map(
              (document) => Questionnaire(
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
    questionnaire.document("Esquadrias").collection('itens').snapshots().listen(
      (data) {
        esquadriasList = data.documents
            .map(
              (document) => Questionnaire(
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
    questionnaire
        .document("Estacionamento")
        .collection('itens')
        .snapshots()
        .listen(
      (data) {
        estacionamentoList = data.documents
            .map(
              (document) => Questionnaire(
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
    questionnaire.document("Mobiliário").collection('itens').snapshots().listen(
      (data) {
        mobiliarioList = data.documents
            .map(
              (document) => Questionnaire(
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
    questionnaire
        .document("Restaurantes e Similares")
        .collection('itens')
        .snapshots()
        .listen(
      (data) {
        restaurantesList = data.documents
            .map(
              (document) => Questionnaire(
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
    questionnaire.document("Vestiários").collection('itens').snapshots().listen(
      (data) {
        vestiariosList = data.documents
            .map(
              (document) => Questionnaire(
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
