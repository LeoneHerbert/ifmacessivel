import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ifmaacessivel/src/app/app_module.dart';
import 'package:ifmaacessivel/src/auth/authentification.dart';
import 'package:ifmaacessivel/src/models/setor.dart';
import 'package:rxdart/rxdart.dart';

class SetoresBloc extends BlocBase {
  BehaviorSubject<List> _setoresController = BehaviorSubject<List>();
  Stream<List> get outSetores => _setoresController.stream;

  void getSetores() async {
    try {
      var resposta = await AppModule.setores;
      _setoresController.sink.add(resposta);
    }catch(e) {
      _setoresController.addError(e);
    }
  }

  @override
  void dispose() {
    _setoresController.close();
  }
}