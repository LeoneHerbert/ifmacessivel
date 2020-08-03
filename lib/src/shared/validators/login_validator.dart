import 'dart:async';

class LoginValidator {
  final emailValidation = StreamTransformer<String, String>.fromHandlers(
    handleData: (usuario, sink){
      if(usuario.trim().length > 13 && usuario.trim().contains("@") && usuario.trim().contains("gmail.com") || usuario.trim().contains("hotmail.com") || usuario.trim().contains("ifma.edu.br") || usuario.trim().contains("outlook.com")){
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