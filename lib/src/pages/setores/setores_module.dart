import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:ifmaacessivel/src/pages/setores/setores_bloc.dart';
import 'package:ifmaacessivel/src/pages/setores/setores_page.dart';

class SetoresModule extends ModuleWidget {

  @override
  List<Bloc> get blocs => [
    Bloc((i) => SetoresBloc()),
  ];

  @override
  List<Dependency> get dependencies => [
  ];

  @override
  Widget get view => SetoresPage();

  static Inject get to => Inject<SetoresModule>.of();
}