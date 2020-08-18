import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifmaacessivel/src/app/app_module.dart';
import 'package:ifmaacessivel/src/auth/authentification.dart';
import 'package:ifmaacessivel/src/models/user.dart';
import 'package:ifmaacessivel/src/pages/home/home_module.dart';
import 'package:ifmaacessivel/src/pages/login/login_module.dart';
import 'package:ifmaacessivel/src/pages/profile/profile_module.dart';
import 'package:ifmaacessivel/src/pages/setores/setores_module.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class SideMenu extends StatelessWidget {
  String image =
      "https://firebasestorage.googleapis.com/v0/b/ifmacessivel-48fa8.appspot.com/o/default_image.png?alt=media&token=e7f0a050-f7cd-4ab5-8ff0-6ecf2cf78f8f";

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
                        .getDependency<Authentification>()
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
                        accountName: new Text(snapshot.data['campus']),
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
                      builder: (context) => SetoresModule(),
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
                  customLaunch('mailto:gabinete@ifma.edu.br');
                },
              ),
              Divider(
                color: Theme.of(context).accentColor,
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
                      builder: (context) => LoginModule(),
                    ),
                  );
                  AppModule.to.getDependency<Authentification>().logout();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
