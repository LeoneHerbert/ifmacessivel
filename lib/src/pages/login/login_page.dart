import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifmaacessivel/src/models/enums/estado.dart';
import 'package:ifmaacessivel/src/pages/home/home_module.dart';
import 'package:ifmaacessivel/src/pages/login/login_bloc.dart';
import 'package:ifmaacessivel/src/pages/login/login_module.dart';
import 'package:ifmaacessivel/src/shared/widgets/custom_text_field.dart';
import 'package:ifmaacessivel/src/shared/widgets/default_button.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginBloc = LoginModule.to.getBloc<LoginBloc>();

  @override
  void initState() {
    _loginBloc.outEstado.listen(
      (estado) {
        switch (estado) {
          case Estado.SUCESSO:
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => Provider<Map>.value(
                  value: _loginBloc.dadosLogin,
                  child: HomeModule(),
                ),
              ),
            );
            break;
          case Estado.NAUTORIZADO:
          case Estado.FALHA:
          case Estado.CARREGANDO:
          case Estado.OCIOSO:
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loginShape(),
    );
  }

  Widget _loginShape() {
    return StreamBuilder<Estado>(
      stream: _loginBloc.outEstado,
      initialData: Estado.FALHA,
      builder: (context, snapshot) {
        switch (snapshot.data) {
          case Estado.CARREGANDO:
            return Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation(Theme.of(context).primaryColor),
              ),
            );
          case Estado.FALHA:
          case Estado.NAUTORIZADO:
            return _loginBuilder();
            break;
          case Estado.OCIOSO:
          case Estado.SUCESSO:
            Container();
        }
        return Container();
      },
    );
  }

  Widget _loginBuilder() {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 2.3,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            "images/background.png",
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          height: 40,
          width: 100,
          top: 228,
          left: 20,
          child: Container(
            padding: EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Text(
              "Login",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 265),
            child: Form(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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
                            stream: _loginBloc.outEmail,
                            onChanged: _loginBloc.changeEmail,
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
                            stream: _loginBloc.outPassword,
                            onChanged: _loginBloc.changePassword,
                            obscure: true,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Esqueceu sua senha? Clique aqui.",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    StreamBuilder<bool>(
                        stream: _loginBloc.outSubmitValido,
                        builder: (context, snapshot) {
                          return DefaultButton(
                            child: Text(
                              "Entrar",
                              style: TextStyle(
                                color: Theme.of(context).highlightColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: snapshot.hasData
                                ? () async {
                                    _loginBloc.submit();
                                  }
                                : null,
                          );
                        })
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
