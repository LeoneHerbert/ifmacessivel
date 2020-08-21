import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifmaacessivel/src/pages/home/home_module.dart';
import 'package:ifmaacessivel/src/pages/redefinir_senha/redefinir_senha_bloc.dart';
import 'package:ifmaacessivel/src/pages/redefinir_senha/redefinir_senha_module.dart';
import 'package:ifmaacessivel/src/shared/widgets/custom_text_field.dart';
import 'package:ifmaacessivel/src/shared/widgets/default_button.dart';
import 'package:ifmaacessivel/src/shared/widgets/float_notification.dart';


// ignore: must_be_immutable
class RedefinirSenhaPage extends StatefulWidget {


  @override
  _RedefinirSenhaPageState createState() => _RedefinirSenhaPageState();
}

class _RedefinirSenhaPageState extends State<RedefinirSenhaPage> {
  final _cadastrarUsuarioBloc = RedefinirSenhaModule.to.getBloc<RedefinirSenhaBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Redefinir Senha"),
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
                height: 40,
              ),
              StreamBuilder<bool>(
                stream: _cadastrarUsuarioBloc.outSubmitValido,
                builder: (context, snapshot) {
                  return DefaultButton(
                    child: Text(
                      "Confirmar",
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
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (context) => FloatNotification("Solicitação enviada sucesso!"),
                        );
                      }else {
                        showDialog(
                          context: context,
                          builder: (context) => FloatNotification("E-mail não cadastrado."),
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
