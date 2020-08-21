import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ifmaacessivel/src/app/app_module.dart';
import 'package:ifmaacessivel/src/auth/authentification.dart';
import 'package:rxdart/rxdart.dart';

class ProfileBloc extends BlocBase {
  final _campusController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _enderecoController = BehaviorSubject<String>();
  final _telefoneController = BehaviorSubject<String>();
  final _encarregadoController = BehaviorSubject<String>();

  Stream<String> get outCampus => _campusController;

  Stream<String> get outEmail => _emailController;

  Stream<String> get outEndereco => _enderecoController;

  Stream<String> get outTelefone => _telefoneController;

  Stream<String> get outEncarregado => _encarregadoController;

  Function(String) get changeCampus => _campusController.sink.add;

  Function(String) get changeEmail => _emailController.sink.add;

  Function(String) get changeEndereco => _enderecoController.sink.add;

  Function(String) get changeTelefone => _telefoneController.sink.add;

  Function(String) get changeEncarregado => _encarregadoController.sink.add;

  void submit() {
    Map<String, String> data = {
      'campus': _campusController.value,
      'email': _emailController.value,
      'endereco': _enderecoController.value,
      'telefone': _telefoneController.value,
      'encarregado': _encarregadoController.value,
    };

    Firestore.instance
        .collection(AppModule.to.getDependency<Authentification>().getUserId())
        .document("usuario")
        .setData(data);
  }

  @override
  void dispose() {
    _campusController.close();
    _emailController.close();
    _enderecoController.close();
    _telefoneController.close();
    _encarregadoController.close();
  }
}
