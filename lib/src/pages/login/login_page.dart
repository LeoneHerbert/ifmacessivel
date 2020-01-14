import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifmaacessivel/src/pages/home/home_page.dart';
import 'package:ifmaacessivel/src/shared/widgets/default_button.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailInputController;
  TextEditingController pwdInputController;

  @override
  initState() {
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 265),
            child: Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 70,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              controller: emailInputController,
                              validator: (input) {
                                if (input.isEmpty) {
                                  return 'Digite o e-mail.';
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "E-mail",
                              ),
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
                            child: TextFormField(
                              obscureText: true,
                              controller: pwdInputController,
                              validator: (input) {
                                if (input.length < 6) {
                                  return 'Mínimo de 6 caracteres.';
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Senha",
                              ),
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
                      DefaultButton(
                        child: Text(
                          "Entrar",
                          style: TextStyle(
                            color: Theme.of(context).highlightColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: signIn,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<int> signIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }
    return 0;
  }
}

class LoadingCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: CircularProgressIndicator(),
        alignment: Alignment(0.0, 0.0),
      ),
    );
  }
}
