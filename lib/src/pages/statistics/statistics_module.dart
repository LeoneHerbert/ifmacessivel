import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:ifmaacessivel/src/pages/statistics/statistics_bloc.dart';
import 'package:ifmaacessivel/src/pages/statistics/statistics_page.dart';

class StatisticsModule extends ModuleWidget {

  @override
  List<Bloc> get blocs => [
    Bloc((i) => StatisticsBloc()),
  ];

  @override
  List<Dependency> get dependencies => [
  ];

  @override
  Widget get view => StatisticsPage();

  static Inject get to => Inject<StatisticsModule>.of();
}