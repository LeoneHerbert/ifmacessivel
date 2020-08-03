import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:ifmaacessivel/src/app/app_bloc.dart';
import 'package:ifmaacessivel/src/app/app_widget.dart';
import 'package:ifmaacessivel/src/auth/authentification.dart';
import 'package:ifmaacessivel/src/models/questionario.dart';
import 'package:ifmaacessivel/src/models/setor.dart';



class AppModule extends ModuleWidget {
  static List<Setor> setores;
  @override
  List<Bloc> get blocs => [
        Bloc((i) => AppBloc()),
      ];

  @override
  List<Dependency> get dependencies => [
    Dependency((i) => Authentification())
  ];

  @override
  Widget get view => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
