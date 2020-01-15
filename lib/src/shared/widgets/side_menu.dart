import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifmaacessivel/src/pages/home/home_page.dart';
import 'package:ifmaacessivel/src/pages/login/login_module.dart';
import 'package:ifmaacessivel/src/pages/login/login_page.dart';

class SideMenu extends StatelessWidget {
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
                accountName: new Text('Herbert'),
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
                accountEmail: new Text('herbleopin@gmail.com'),
                currentAccountPicture: ClipOval(
                  child: Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/sistema-de-estoque.appspot.com/o/Fotoperfil.png?alt=media&token=60a32e98-cb29-4961-8465-1b4dbb1207dd"),
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
