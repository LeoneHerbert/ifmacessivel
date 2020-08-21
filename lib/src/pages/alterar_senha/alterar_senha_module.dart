import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:ifmaacessivel/src/pages/alterar_senha/alterar_senha_bloc.dart';
import 'package:ifmaacessivel/src/pages/alterar_senha/alterar_senha_page.dart';

class AlterarSenhaModule extends ModuleWidget {

  @override
  List<Bloc> get blocs => [
    Bloc((i) => AlterarSenhaBloc()),
  ];

  @override
  List<Dependency> get dependencies => [
  ];

  @override
  Widget get view => AlterarSenhaPage();

  static Inject get to => Inject<AlterarSenhaModule>.of();
}
