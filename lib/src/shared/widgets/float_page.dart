import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifmaacessivel/src/models/user.dart';
import 'package:ifmaacessivel/src/pages/profile/profile_bloc.dart';
import 'package:ifmaacessivel/src/pages/profile/profile_module.dart';
import 'package:ifmaacessivel/src/shared/widgets/custom_text_field.dart';

class FloatPage extends StatelessWidget {
  final _profileBloc = ProfileModule.to.getBloc<ProfileBloc>();

  FloatPage() {
    _profileBloc.changeCampus(User.campus);
    _profileBloc.changeEmail(User.email);
    _profileBloc.changeEncarregado(User.encarregado);
    _profileBloc.changeEndereco(User.endereco);
    _profileBloc.changeTelefone(User.telefone);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Editar Perfil',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              CustomTextField(
                icon: Icons.location_city,
                hint: 'Campus',
                stream: _profileBloc.outCampus,
                onChanged: _profileBloc.changeCampus,
                valorInicial: User.campus,
                obscure: false,
              ),
              CustomTextField(
                icon: Icons.person,
                hint: 'Encarregado(a)',
                stream: _profileBloc.outEncarregado,
                onChanged: _profileBloc.changeEncarregado,
                valorInicial: User.encarregado,
                obscure: false,
              ),
              CustomTextField(
                icon: Icons.mail,
                hint: 'E-mail',
                stream: _profileBloc.outEmail,
                onChanged: _profileBloc.changeEmail,
                valorInicial: User.email,
                obscure: false,
              ),
              CustomTextField(
                icon: Icons.phone,
                hint: 'Telefone',
                stream: _profileBloc.outTelefone,
                onChanged: _profileBloc.changeTelefone,
                valorInicial: User.telefone,
                obscure: false,
              ),
              CustomTextField(
                icon: Icons.location_on,
                hint: 'Endereço',
                stream: _profileBloc.outEndereco,
                onChanged: _profileBloc.changeEndereco,
                valorInicial: User.endereco,
                obscure: false,
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: RaisedButton(
                      child: Text(
                        "Cancelar",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        "Confirmar",
                        style: TextStyle(
                          color: Theme.of(context).highlightColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        _profileBloc.submit();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
