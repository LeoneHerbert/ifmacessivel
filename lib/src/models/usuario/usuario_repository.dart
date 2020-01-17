import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ifmaacessivel/src/app/app_module.dart';
import 'package:ifmaacessivel/src/auth/authentification.dart';
import 'package:ifmaacessivel/src/models/usuario/usuario.dart';

class UsuarioRepository {
  Map<String, dynamic> _document;
  String _userId;
  Usuario _usuario = new Usuario();

  UsuarioRepository() {
    Authentification auth = AppModule.to.getDependency<Authentification>();
    _userId = auth.getUserId();
    getUsuario();
  }

  Map<String, dynamic> getUsuario() {
    try {
      Firestore.instance
          .collection(_userId)
          .document("usuario")
          .snapshots()
          .listen(
        (dado) {
          _usuario.nome = dado.data['nome'];
          _usuario.imageUrl = dado.data['imageUrl'];
          _usuario.encarregado = dado.data['encarregado'];
        },
      );
    } catch (e) {
      throw e;
    }
  }

  static List<Usuario> parseProdutos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Usuario>((json) => Usuario.fromJson(json)).toList();
  }
}
