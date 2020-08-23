import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ifmaacessivel/src/app/app_module.dart';
import 'package:ifmaacessivel/src/auth/auth.dart';

class User {
  static String campus;
  static String email;
  static String address;
  static String phone;
  static String responsible;
  static String image;
  static String pathGoogleDrive;

  User() {
    Firestore.instance
        .collection(AppModule.to.getDependency<Auth>().getUserId())
        .document("usuario")
        .snapshots()
        .listen(
      (data) {
        campus = data.data['campus'];
        email = data.data['email'];
        address = data.data['endereco'];
        phone = data.data['telefone'];
        responsible = data.data['encarregado'];
      },
    );
    Firestore.instance
        .collection(AppModule.to.getDependency<Auth>().getUserId())
        .document("image")
        .snapshots()
        .listen(
      (data) {
        image = data.data['url'];
      },
    );
    Firestore.instance.collection("drive").document("path").snapshots().listen(
      (data) {
        pathGoogleDrive = data.data['url'];
      },
    );
  }
}
