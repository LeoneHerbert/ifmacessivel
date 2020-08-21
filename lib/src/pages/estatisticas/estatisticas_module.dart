import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:ifmaacessivel/src/pages/estatisticas/estatisticas_bloc.dart';
import 'package:ifmaacessivel/src/pages/estatisticas/estatisticas_page.dart';

class EstatisticasModule extends ModuleWidget {

  @override
  List<Bloc> get blocs => [
    Bloc((i) => EstatisticasBloc()),
  ];

  @override
  List<Dependency> get dependencies => [
  ];

  @override
  Widget get view => EstatisticasPage();

  static Inject get to => Inject<EstatisticasModule>.of();
}