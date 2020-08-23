import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:ifmaacessivel/src/pages/register_user/register_user_bloc.dart';
import 'register_user_page.dart';

class RegisterUserModule extends ModuleWidget {

  @override
  List<Bloc> get blocs => [
    Bloc((i) => RegisterUserBloc()),
  ];

  @override
  List<Dependency> get dependencies => [
  ];

  @override
  Widget get view => RegisterUserPage();

  static Inject get to => Inject<RegisterUserModule>.of();
}
