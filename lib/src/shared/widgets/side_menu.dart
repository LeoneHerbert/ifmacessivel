import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifmaacessivel/src/app/app_module.dart';
import 'package:ifmaacessivel/src/auth/authentification.dart';
import 'package:ifmaacessivel/src/pages/home/home_page.dart';
import 'package:ifmaacessivel/src/pages/login/login_module.dart';
import 'package:ifmaacessivel/src/pages/login/login_page.dart';

class SideMenu extends StatelessWidget {
  Authentification auth = AppModule.to.getDependency<Authentification>();
  String _nome, _url;

  SideMenu(){
    Firestore.instance
        .collection(auth.getUserId())
        .document("usuario")
        .snapshots()
        .listen(
      (dado) {
        _nome = dado.data['nome'];
        _url = dado.data['imageUrl'];
      },
    );
  }

  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 200, 200, 200),
                Theme.of(context).dividerColor,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.center,
            ),
          ),
        );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text(_nome),
                accountEmail: null,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).accentColor,
                      blurRadius: 5.0,
                      spreadRadius: 2.0,
                    )
                  ],
                ),
                currentAccountPicture: ClipOval(
                  child: Image.network(_url),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Theme.of(context).accentColor,
                ),
                title: new Text(
                  'Home',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
              ),
              Divider(
                color: Theme.of(context).accentColor,
              ),
              ListTile(
                leading: Icon(
                  Icons.location_city,
                  color: Theme.of(context).accentColor,
                ),
                title: new Text(
                  'Setores',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
              ),
              Divider(
                color: Theme.of(context).accentColor,
              ),
              ListTile(
                leading: Icon(
                  Icons.folder,
                  color: Theme.of(context).accentColor,
                ),
                title: new Text(
                  'Documentos',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
              ),
              Divider(
                color: Theme.of(context).accentColor,
              ),
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: Theme.of(context).accentColor,
                ),
                title: new Text(
                  'Perfil',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
              ),
              Divider(
                color: Theme.of(context).accentColor,
              ),
              ListTile(
                leading: Icon(
                  Icons.email,
                  color: Theme.of(context).accentColor,
                ),
                title: new Text(
                  'E-mail',
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
              ),
              Divider(
                color: Theme.of(context).accentColor,
              ),
              SizedBox(
                height: 70,
              ),
              ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  color: Theme.of(context).accentColor,
                ),
                title: new Text(
                  'Sair',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  color: Theme.of(context).accentColor,
                ),
                title: new Text(
                  'Sair',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  LoginModule();
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
