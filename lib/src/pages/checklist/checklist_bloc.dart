import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class ChecklistBloc extends BlocBase {
  final _cardController = BehaviorSubject<String>();

  Function(String) get changeCard => _cardController.sink.add;
  
  @override
  void dispose() {
    super.dispose();
  }
  
}