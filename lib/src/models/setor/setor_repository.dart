import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ifmaacessivel/src/app/app_module.dart';
import 'package:ifmaacessivel/src/auth/authentification.dart';

class SetorRepository {
  Authentification auth = AppModule.to.getDependency<Authentification>();

  void save(numero, nome, observacao) {
    Firestore.instance
        .collection(auth.getUser().uid)
        .document("ifmacessiveldb").collection("setores").document(nome)
        .setData({
      'numero': numero,
      'nome': nome,
      'observacao': observacao
    });
  }

  void update() {}

  void getSetor() {}

  void getList() {}
}
