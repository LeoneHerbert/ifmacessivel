import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:ifmaacessivel/src/app/app_module.dart';
import 'package:ifmaacessivel/src/auth/authentification.dart';
import 'package:ifmaacessivel/src/shared/validators/login_validator.dart';
import 'package:rxdart/rxdart.dart';

class RedefinirSenhaBloc extends BlocBase with LoginValidator {
  final _emailController = BehaviorSubject<String>();

  Stream<String> get outEmail =>
      _emailController.stream.transform(emailValidation);

  Function(String) get changeEmail => _emailController.sink.add;

  Stream<bool> get outSubmitValido =>
      Observable.combineLatest2(outEmail, outEmail, (a, b) => true);

  Future<bool> submit() async {
    try {
      Authentification auth = AppModule.to.getDependency<Authentification>();
      auth.passwordRedefinitionViaEmail(_emailController.value);
      return true;
    } catch (e) {
      print('E-mail utilizado');
      return false;
    }
  }

  @override
  void dispose() {
    _emailController.close();
  }
}
