import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifmaacessivel/src/models/enums/login_state.dart';
import 'package:ifmaacessivel/src/models/report.dart';
import 'package:ifmaacessivel/src/pages/home/home_module.dart';
import 'package:ifmaacessivel/src/pages/login/login_bloc.dart';
import 'package:ifmaacessivel/src/pages/login/login_module.dart';
import 'package:ifmaacessivel/src/pages/reset_password/reset_password_module.dart';
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
    super.initState();
    new Report();
    _loginBloc.outLoginState.listen(
      (estado) {
        switch (estado) {
          case LoginState.SUCESSO:
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => Provider<Map>.value(
                  value: _loginBloc.loginData,
                  child: HomeModule(),
                ),
              ),
            );
            break;
          case LoginState.NAUTORIZADO:
          case LoginState.FALHA:
          case LoginState.CARREGANDO:
          case LoginState.OCIOSO:
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
    return StreamBuilder<LoginState>(
      stream: _loginBloc.outLoginState,
      initialData: LoginState.OCIOSO,
      builder: (context, snapshot) {
        switch (snapshot.data) {
          case LoginState.CARREGANDO:
            return Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation(Theme.of(context).primaryColor),
              ),
            );
          case LoginState.FALHA:
          case LoginState.NAUTORIZADO:
            return _loginError();
            break;
          case LoginState.OCIOSO:
            return _loginBuilder();
            break;
          case LoginState.SUCESSO:
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
          height: MediaQuery.of(context).size.height/2.15,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            "images/background.png",
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          height: MediaQuery.of(context).size.height/18,
          width: 100,
          top: MediaQuery.of(context).size.height/2.9,
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
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.5),
            child: Form(
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
                      height: 10,
                    ),
                    GestureDetector(
                      child: Text(
                        "Esqueceu sua senha? Clique aqui.",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => ResetPasswordModule(),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    StreamBuilder<bool>(
                      stream: _loginBloc.outSubmitValid,
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
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _loginError() {
    return Container(
      color: Colors.grey,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 1.5,
            height: MediaQuery.of(context).size.height / 4,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Erro',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.error_outline,
                      color: Colors.red,
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  'Dados incorretos!',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 30,
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
                          "Tente novamente",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          _loginBloc.loginFalha();
                          _loginBuilder();
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
