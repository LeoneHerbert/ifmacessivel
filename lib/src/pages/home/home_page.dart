import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifmaacessivel/src/app/app_module.dart';
import 'package:ifmaacessivel/src/auth/authentification.dart';
import 'package:ifmaacessivel/src/models/usuario/usuario_repository.dart';
import 'package:ifmaacessivel/src/pages/setores/setores_page.dart';
import 'package:ifmaacessivel/src/shared/widgets/side_menu.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

  HomePage() {
    UsuarioRepository();
  }
}

class _HomePageState extends State<HomePage> {
  
  Decoration box() {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey, // Theme.of(context).accentColor
          blurRadius: 5.0,
          spreadRadius: 0.5,
        ),
      ],
      borderRadius: BorderRadiusDirectional.circular(10),
      gradient: LinearGradient(
        colors: [
          Color.fromARGB(255, 245, 245, 245),
          Theme.of(context).highlightColor
        ],
        begin: Alignment.centerRight,
        end: Alignment.center,
      ),
    );
  }

  TextStyle text(cor) {
    return TextStyle(color: cor, fontWeight: FontWeight.bold, fontSize: 25);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
        ),
      ),
      
      drawer: new SideMenu(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => SetoresPage(),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(20),
                  height: 170,
                  width: 170,
                  decoration: box(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.location_city,
                        size: 100,
                        color: Theme.of(context).accentColor,
                      ),
                      Text(
                        'Setores',
                        style: text(
                          Theme.of(context).accentColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 170,
                  width: 170,
                  decoration: box(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.folder,
                        size: 100,
                        color: Theme.of(context).accentColor,
                      ),
                      Text(
                        'Documentos',
                        style: text(
                          Theme.of(context).accentColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(20),
                  height: 170,
                  width: 170,
                  decoration: box(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        size: 100,
                        color: Theme.of(context).accentColor,
                      ),
                      Text(
                        'Perfil',
                        style: text(
                          Theme.of(context).accentColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 170,
                  width: 170,
                  decoration: box(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.email,
                        size: 100,
                        color: Theme.of(context).accentColor,
                      ),
                      Text(
                        'E-mail',
                        style: text(
                          Theme.of(context).accentColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
