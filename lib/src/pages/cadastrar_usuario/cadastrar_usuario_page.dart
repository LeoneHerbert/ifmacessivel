import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifmaacessivel/src/models/questionario.dart';
import 'package:ifmaacessivel/src/pages/cadastrar_usuario/cadastrar_usuario_bloc.dart';
import 'package:ifmaacessivel/src/pages/cadastrar_usuario/cadastrar_usuario_module.dart';
import 'package:ifmaacessivel/src/pages/home/home_module.dart';
import 'package:ifmaacessivel/src/shared/widgets/custom_text_field.dart';
import 'package:ifmaacessivel/src/shared/widgets/default_button.dart';
import 'package:ifmaacessivel/src/shared/widgets/float_notification.dart';


// ignore: must_be_immutable
class CadastrarUsuarioPage extends StatefulWidget {


  @override
  _CadastrarUsuarioPageState createState() => _CadastrarUsuarioPageState();
}

class _CadastrarUsuarioPageState extends State<CadastrarUsuarioPage> {
  final _cadastrarUsuarioBloc = CadastrarUsuarioModule.to.getBloc<CadastrarUsuarioBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar Usuário"),
      ),
      body: Form(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.height / 20,
              vertical: 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.0),
            ),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 70,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: CustomTextField(
                      icon: Icons.mail,
                      hint: 'E-mail',
                      stream: _cadastrarUsuarioBloc.outEmail,
                      onChanged: _cadastrarUsuarioBloc.changeEmail,
                      obscure: false,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: CustomTextField(
                      icon: Icons.lock,
                      hint: 'Senha',
                      stream: _cadastrarUsuarioBloc.outPassword,
                      onChanged: _cadastrarUsuarioBloc.changePassword,
                      obscure: true,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              StreamBuilder<bool>(
                stream: _cadastrarUsuarioBloc.outSubmitValido,
                builder: (context, snapshot) {
                  return DefaultButton(
                    child: Text(
                      "Cadastrar",
                      style: TextStyle(
                        color: Theme.of(context).highlightColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: snapshot.hasData
                        ? () async {
                      bool state;
                      state = await _cadastrarUsuarioBloc.submit();
                      if(state){
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => HomeModule(),
                          ),
                        );
                        showDialog(
                          context: context,
                          builder: (context) => FloatNotification("Usuário cadastrado com sucesso!"),
                        );
                      }else {
                        showDialog(
                          context: context,
                          builder: (context) => FloatNotification("E-mail já cadastrado."),
                        );
                      }
                    }
                        : null,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
