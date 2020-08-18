import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ifmaacessivel/src/app/app_module.dart';
import 'package:ifmaacessivel/src/auth/authentification.dart';

class User {
  static String campus;
  static String email;
  static String endereco;
  static String telefone;
  static String encarregado;
  static String image;

  User() {
    Firestore.instance
        .collection(AppModule.to.getDependency<Authentification>().getUserId())
        .document("usuario")
        .snapshots()
        .listen(
      (data) {
        campus = data.data['campus'];
        email = data.data['email'];
        endereco = data.data['endereco'];
        telefone = data.data['telefone'];
        encarregado = data.data['encarregado'];
      },
    );
    Firestore.instance
        .collection(AppModule.to.getDependency<Authentification>().getUserId())
        .document("image")
        .snapshots()
        .listen(
          (data) {
        image = data.data['url'];
      },
    );
  }

}
