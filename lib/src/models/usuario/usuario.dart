import 'package:ifmaacessivel/src/models/usuario/usuario_repository.dart';

class Usuario {
  UsuarioRepository repository;
  String nome;
  String imageUrl;
  String encarregado;

  Usuario({
    this.repository,
    this.nome,
    this.imageUrl,
    this.encarregado,
  });


  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      nome: json["nome"],
      imageUrl: json["imageUrl"],
      encarregado: json["encarregado"],
    );
  }

  Map<String, dynamic> toJson() => {
        'nome': nome,
        'imageUrl': imageUrl,
        'encarregado': encarregado,
      };
}
