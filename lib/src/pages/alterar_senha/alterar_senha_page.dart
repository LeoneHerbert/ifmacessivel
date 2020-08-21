import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifmaacessivel/src/pages/alterar_senha/alterar_senha_bloc.dart';
import 'package:ifmaacessivel/src/pages/alterar_senha/alterar_senha_module.dart';
import 'package:ifmaacessivel/src/pages/home/home_module.dart';
import 'package:ifmaacessivel/src/shared/widgets/custom_text_field.dart';
import 'package:ifmaacessivel/src/shared/widgets/default_button.dart';
import 'package:ifmaacessivel/src/shared/widgets/float_notification.dart';


// ignore: must_be_immutable
class AlterarSenhaPage extends StatefulWidget {

  @override
  _AlterarSenhaPageState createState() => _AlterarSenhaPageState();
}

class _AlterarSenhaPageState extends State<AlterarSenhaPage> {
  final _alterarSenhaBloc = AlterarSenhaModule.to.getBloc<AlterarSenhaBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alterar Senha"),
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
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: CustomTextField(
                      icon: Icons.lock,
                      hint: 'Senha',
                      stream: _alterarSenhaBloc.outPassword,
                      onChanged: _alterarSenhaBloc.changePassword,
                      obscure: true,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              StreamBuilder<bool>(
                stream: _alterarSenhaBloc.outSubmitValido,
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
                      state = await _alterarSenhaBloc.submit();
                      if(state){
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (context) => FloatNotification("Senha alterada com sucesso!"),
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
