import 'dart:async';

class ProfileValidator {
  final inputValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (text, sink) {
    if (text.trim().length > 0) {
      sink.add(text);
    } else {
      sink.addError("Campo vazio!");
    }
  });
}
