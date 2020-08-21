import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:ifmaacessivel/src/pages/cadastrar_usuario/cadastrar_usuario_bloc.dart';

import 'cadastrar_usuario_page.dart';

class CadastrarUsuarioModule extends ModuleWidget {

  @override
  List<Bloc> get blocs => [
    Bloc((i) => CadastrarUsuarioBloc()),
  ];

  @override
  List<Dependency> get dependencies => [
  ];

  @override
  Widget get view => CadastrarUsuarioPage();

  static Inject get to => Inject<CadastrarUsuarioModule>.of();
}
