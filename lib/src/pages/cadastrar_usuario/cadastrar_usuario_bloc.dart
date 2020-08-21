import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ifmaacessivel/src/app/app_module.dart';
import 'package:ifmaacessivel/src/auth/authentification.dart';
import 'package:ifmaacessivel/src/shared/validators/login_validator.dart';
import 'package:rxdart/rxdart.dart';

class CadastrarUsuarioBloc extends BlocBase with LoginValidator {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get outEmail =>
      _emailController.stream.transform(emailValidation);

  Stream<String> get outPassword =>
      _passwordController.stream.transform(passwordValidation);

  Function(String) get changeEmail => _emailController.sink.add;

  Function(String) get changePassword => _passwordController.sink.add;

  Stream<bool> get outSubmitValido =>
      Observable.combineLatest2(outEmail, outPassword, (a, b) => true);

  Future<bool> submit() async {
    try {
      Authentification auth = AppModule.to.getDependency<Authentification>();

      Map<String, String> data = {
        'email': _emailController.value,
        'password': _passwordController.value,
      };

      FirebaseUser user = await auth.register(data);

      Map<String, String> usuario = {
        'campus': 'Campus',
        'email': _emailController.value,
        'endereco': 'Endereço',
        'telefone': 'Telefone',
        'encarregado': 'Encarregado',
      };

      Map<String, String> image = {
        'url':
            'https://firebasestorage.googleapis.com/v0/b/ifmacessivel-48fa8.appspot.com/o/default_image.png?alt=media&token=e7f0a050-f7cd-4ab5-8ff0-6ecf2cf78f8f',
      };

      Map<String, bool> nivelDeAcesso = {
        'administrador': false,
      };

      Firestore.instance
          .collection(user.uid)
          .document("usuario")
          .setData(usuario);

      Firestore.instance.collection(user.uid).document("image").setData(image);

      Firestore.instance
          .collection(user.uid)
          .document("nivel_de_acesso")
          .setData(nivelDeAcesso);

      return true;
    } catch (e) {
      print('E-mail utilizado');
      return false;
    }
  }

  @override
  void dispose() {
    _emailController.close();
    _passwordController.close();
  }
}
