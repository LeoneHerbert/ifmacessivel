import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:ifmaacessivel/src/app/app_module.dart';
import 'package:rxdart/rxdart.dart';

class SectorsBloc extends BlocBase {
  BehaviorSubject<List> _sectorsController = BehaviorSubject<List>();
  Stream<List> get outSectors => _sectorsController.stream;

  void getSectors() {
    try {
      var answer = AppModule.sectors;
      _sectorsController.sink.add(answer);
    }catch(e) {
      _sectorsController.addError(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _sectorsController.close();
  }
}