import 'dart:async';

class LoginValidator {
  final emailValidation = StreamTransformer<String, String>.fromHandlers(
      handleData: (email, sink) {
    if (email.trim().length > 13 &&
            email.trim().contains("@") &&
            email.trim().contains("gmail.com") ||
        email.trim().contains("hotmail.com") ||
        email.trim().contains("ifma.edu.br") ||
        email.trim().contains("outlook.com")) {
      sink.add(email);
    } else {
      sink.addError("Digite um e-mail válido!");
    }
  });

  final passwordValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (password, sink) {
    if (password.trim().length >= 6) {
      sink.add(password);
    } else {
      sink.addError("Senha inválida! Mínimo de 6 caracteres.");
    }
  });
}
