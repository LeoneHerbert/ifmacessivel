import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ifmaacessivel/src/app/app_module.dart';
import 'package:ifmaacessivel/src/auth/authentification.dart';
import 'package:ifmaacessivel/src/models/enums/estado.dart';
import 'package:ifmaacessivel/src/shared/validators/login_validator.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BlocBase with LoginValidator {
  Map<String, String> _dadosLogin;
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _estadoController = BehaviorSubject<Estado>();

  Stream<String> get outEmail => _emailController.stream.transform(emailValidation);
  Stream<String> get outPassword => _passwordController.stream.transform(passwordValidation);
  Stream<Estado> get outEstado => _estadoController.stream;

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  Map<String, dynamic> get dadosLogin => _dadosLogin;

  Stream<bool> get outSubmitValido => Observable.combineLatest2(
      outEmail,
      outPassword,
      (a, b) => true
  );


  void submit() async {
    try {
      Authentification auth = AppModule.to.getDependency<Authentification>();

      Map<String, String> data = {
        'email': _emailController.value,
        'password': _passwordController.value,
      };

      _estadoController.add(Estado.CARREGANDO);

      FirebaseUser user = await auth.signIn(data);

      if(user != null){
        _estadoController.add(Estado.SUCESSO);
      } else {
        _estadoController.add(Estado.FALHA);
      }
      
      _dadosLogin = {
        'email': _emailController.value,
        'password': _passwordController.value,
      };
      _estadoController.add(Estado.SUCESSO);
    } catch (e) {
      _estadoController.add(Estado.FALHA);
    }
  }

  @override
  void dispose() {
    _emailController.close();
    _passwordController.close();
    _estadoController.close();
  }
}
