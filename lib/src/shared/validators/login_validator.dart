import 'dart:async';

class LoginValidator {
  final emailValidation = StreamTransformer<String, String>.fromHandlers(
    handleData: (usuario, sink){
      if(usuario.trim().length > 12){
        sink.add(usuario);
      }else{
        sink.addError("Digite um e-mail válido!");
      }
    }
  );

  final passwordValidation = StreamTransformer<String, String>.fromHandlers(
    handleData:  (senha, sink){
      if(senha.trim().length >= 6){
        sink.add(senha);
      }else{
        sink.addError("Senha inválida! Mínimo de 6 caracteres.");
      }
    }
  );
}