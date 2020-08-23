import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifmaacessivel/src/app/app_module.dart';
import 'package:ifmaacessivel/src/auth/auth.dart';
import 'package:ifmaacessivel/src/models/user.dart';
import 'package:ifmaacessivel/src/pages/home/home_module.dart';
import 'package:ifmaacessivel/src/pages/login/login_module.dart';
import 'package:ifmaacessivel/src/pages/profile/profile_module.dart';
import 'package:ifmaacessivel/src/pages/register_user/register_user_module.dart';
import 'package:ifmaacessivel/src/pages/sectors/sectors_module.dart';
import 'package:ifmaacessivel/src/pages/statistics/statistics_module.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class SideMenu extends StatelessWidget {

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print(' could not launch $command');
    }
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
              StreamBuilder<DocumentSnapshot>(
                stream: Firestore.instance
                    .collection(AppModule.to
                        .getDependency<Auth>()
                        .getUserId())
                    .document("usuario")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return new Text('Loading...');
                    default:
                      return new UserAccountsDrawerHeader(
                        accountName: new Text(snapshot.data['encarregado']),
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
                        currentAccountPicture: new Container(
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                User.image,
                              ),
                            ),
                          ),
                        ),
                      );
                  }
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Theme.of(context).accentColor,
                  size: 25,
                ),
                title: new Text(
                  'Home',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => HomeModule(),
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
                  size: 25,
                ),
                title: new Text(
                  'Setores',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                      fontSize: 15
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => SectorsModule(),
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
                  size: 25,
                ),
                title: new Text(
                  'Documentos',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                      fontSize: 15
                  ),
                ),
                onTap: () => launch(
                    'https://drive.google.com/drive/folders/1lRbgNRwxfFmRkeLoG5YIzsaaDHdn5S7S?usp=sharing'),
              ),
              Divider(
                color: Theme.of(context).accentColor,
              ),
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: Theme.of(context).accentColor,
                  size: 25,
                ),
                title: new Text(
                  'Perfil',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                      fontSize: 15
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => ProfileModule(),
                    ),
                  );
                },
              ),
              Divider(
                color: Theme.of(context).accentColor,
              ),
              ListTile(
                leading: Icon(
                  Icons.insert_chart,
                  color: Theme.of(context).accentColor,
                  size: 25,
                ),
                title: new Text(
                  'Estatísticas',
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => StatisticsModule(),
                    ),
                  );
                },
              ),
              Divider(
                color: Theme.of(context).accentColor,
              ),
              StreamBuilder<DocumentSnapshot>(
                stream: Firestore.instance
                    .collection(AppModule.to
                        .getDependency<Auth>()
                        .getUserId())
                    .document("nivel_de_acesso")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return new Text('Loading...');
                    default:
                      if(snapshot.data['administrador']){
                        return Column(
                          children: <Widget>[
                            ListTile(
                              leading: Icon(
                                Icons.group_add,
                                color: Theme.of(context).accentColor,
                              ),
                              title: new Text(
                                'Cadastrar Usuário',
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.bold,fontSize: 15,),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => RegisterUserModule(),
                                  ),
                                );
                              },
                            ),
                            Divider(
                              color: Theme.of(context).accentColor,
                            ),
                          ],
                        );
                      }
                      return Container();
                  }
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
                      fontSize: 15,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => LoginModule(),
                    ),
                  );
                  AppModule.to.getDependency<Auth>().logout();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
