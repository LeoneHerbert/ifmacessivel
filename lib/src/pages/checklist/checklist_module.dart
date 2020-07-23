import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:ifmaacessivel/src/pages/checklist/checklist_bloc.dart';
import 'package:ifmaacessivel/src/pages/checklist/checklist_page.dart';

class ChecklistModule extends ModuleWidget {
  final String setor;

  ChecklistModule(this.setor);
  @override
  List<Bloc> get blocs => [
    Bloc((i) => ChecklistBloc()),
  ];

  @override
  List<Dependency> get dependencies => [
  ];

  @override
  Widget get view => ChecklistPage(setor);

  static Inject get to => Inject<ChecklistModule>.of();
}
