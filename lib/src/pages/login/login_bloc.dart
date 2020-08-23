import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ifmaacessivel/src/app/app_module.dart';
import 'package:ifmaacessivel/src/auth/auth.dart';
import 'package:ifmaacessivel/src/models/enums/login_state.dart';
import 'package:ifmaacessivel/src/shared/validators/login_validator.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BlocBase with LoginValidator {
  Map<String, String> _loginData;
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<LoginState>();

  Stream<String> get outEmail => _emailController.stream.transform(emailValidation);
  Stream<String> get outPassword => _passwordController.stream.transform(passwordValidation);
  Stream<LoginState> get outLoginState => _stateController.stream;

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  Map<String, dynamic> get loginData => _loginData;

  Stream<bool> get outSubmitValid => Observable.combineLatest2(
      outEmail,
      outPassword,
      (a, b) => true
  );


  void submit() async {
    try {
      Auth auth = AppModule.to.getDependency<Auth>();

      Map<String, String> data = {
        'email': _emailController.value,
        'password': _passwordController.value,
      };

      _stateController.add(LoginState.CARREGANDO);

      FirebaseUser user = await auth.signIn(data);

      if(user != null){
        _stateController.add(LoginState.SUCESSO);
      } else {
        _stateController.add(LoginState.FALHA);
      }
      
      _loginData = {
        'email': _emailController.value,
        'password': _passwordController.value,
      };
      _stateController.add(LoginState.SUCESSO);
    } catch (e) {
      _stateController.add(LoginState.FALHA);
    }
  }

  void loginFalha(){
    _stateController.add(LoginState.OCIOSO);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.close();
    _passwordController.close();
    _stateController.close();
  }
}
