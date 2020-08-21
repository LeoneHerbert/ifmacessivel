import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ifmaacessivel/src/app/app_module.dart';
import 'package:ifmaacessivel/src/auth/authentification.dart';
import 'package:ifmaacessivel/src/shared/validators/login_validator.dart';
import 'package:rxdart/rxdart.dart';

class AlterarSenhaBloc extends BlocBase with LoginValidator {
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get outPassword =>
      _passwordController.stream.transform(passwordValidation);

  Function(String) get changePassword => _passwordController.sink.add;

  Stream<bool> get outSubmitValido =>
      Observable.combineLatest2(outPassword, outPassword, (a, b) => true);

  Future<bool> submit() async {
    try {
      Authentification auth = AppModule.to.getDependency<Authentification>();
      auth.passwordRedefinition(_passwordController.value);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  void dispose() {
    _passwordController.close();
  }
}
