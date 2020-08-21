import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:ifmaacessivel/src/pages/redefinir_senha/redefinir_senha_bloc.dart';
import 'package:ifmaacessivel/src/pages/redefinir_senha/redefinir_senha_page.dart';

class RedefinirSenhaModule extends ModuleWidget {

  @override
  List<Bloc> get blocs => [
    Bloc((i) => RedefinirSenhaBloc()),
  ];

  @override
  List<Dependency> get dependencies => [
  ];

  @override
  Widget get view => RedefinirSenhaPage();

  static Inject get to => Inject<RedefinirSenhaModule>.of();
}
