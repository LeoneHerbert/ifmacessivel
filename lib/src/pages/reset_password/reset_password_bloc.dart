import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:ifmaacessivel/src/app/app_module.dart';
import 'package:ifmaacessivel/src/auth/auth.dart';
import 'package:ifmaacessivel/src/shared/validators/login_validator.dart';
import 'package:rxdart/rxdart.dart';

class ResetPasswordBloc extends BlocBase with LoginValidator {
  final _emailController = BehaviorSubject<String>();

  Stream<String> get outEmail =>
      _emailController.stream.transform(emailValidation);

  Function(String) get changeEmail => _emailController.sink.add;

  Stream<bool> get outSubmitValid =>
      Observable.combineLatest2(outEmail, outEmail, (a, b) => true);

  Future<bool> submit() async {
    try {
      Auth auth = AppModule.to.getDependency<Auth>();
      auth.resetPasswordViaEmail(_emailController.value);
      return true;
    } catch (e) {
      print('E-mail utilizado');
      return false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.close();
  }
}
