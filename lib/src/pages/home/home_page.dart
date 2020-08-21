import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifmaacessivel/src/app/app_module.dart';
import 'package:ifmaacessivel/src/models/relatorio.dart';
import 'package:ifmaacessivel/src/models/setor.dart';
import 'package:ifmaacessivel/src/models/user.dart';
import 'package:ifmaacessivel/src/pages/estatisticas/estatisticas_module.dart';
import 'package:ifmaacessivel/src/pages/profile/profile_module.dart';
import 'package:ifmaacessivel/src/pages/setores/setores_module.dart';
import 'package:ifmaacessivel/src/shared/widgets/side_menu.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User user;
  Relatorio relatorio;
  String _path = '...';
  String _extension;
  TextEditingController _controller = new TextEditingController();

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

  @override
  void initState() {
    super.initState();
    super.initState();
    _controller.addListener(
      () => _extension = _controller.text,
    );
  }

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print(' could not launch $command');
    }
  }

  TextStyle text(cor) {
    return TextStyle(color: cor, fontWeight: FontWeight.bold, fontSize: 23);
  }

  @override
  Widget build(BuildContext context) {

    Relatorio.valorDeAcessibilidade();
    user = new User();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
        ),
      ),
      drawer: new SideMenu(),
      body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection("setores").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Text('Loading...');
              default:
                AppModule.setores = snapshot.data.documents
                    .map(
                      (document) => Setor(
                        document.data['nome'],
                        document.data['imageUrl'],
                        document.data['itens'],
                      ),
                    )
                    .toList(growable: true);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => SetoresModule(),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.all(20),
                            height: MediaQuery.of(context).size.width / 2.5,
                            width: MediaQuery.of(context).size.width / 2.5,
                            decoration: box(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.location_city,
                                  size: MediaQuery.of(context).size.height / 7,
                                  color: Theme.of(context).accentColor,
                                ),
                                Text(
                                  'Setores',
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => launch('https://drive.google.com/drive/folders/1lRbgNRwxfFmRkeLoG5YIzsaaDHdn5S7S?usp=sharing'),
                          child: Container(
                            margin: EdgeInsets.all(10),
                            height: MediaQuery.of(context).size.width / 2.5,
                            width: MediaQuery.of(context).size.width / 2.5,
                            decoration: box(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.folder,
                                  size: MediaQuery.of(context).size.height / 7,
                                  color: Theme.of(context).accentColor,
                                ),
                                Text(
                                  'Documentos',
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => ProfileModule(),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.all(20),
                            height: MediaQuery.of(context).size.width / 2.5,
                            width: MediaQuery.of(context).size.width / 2.5,
                            decoration: box(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.person,
                                  size: MediaQuery.of(context).size.height / 7,
                                  color: Theme.of(context).accentColor,
                                ),
                                Text(
                                  'Perfil',
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold
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
                                builder: (context) => EstatisticasModule(),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            height: MediaQuery.of(context).size.width / 2.5,
                            width: MediaQuery.of(context).size.width / 2.5,
                            decoration: box(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.insert_chart,
                                  size: MediaQuery.of(context).size.height / 7,
                                  color: Theme.of(context).accentColor,
                                ),
                                Text(
                                  'Estatísticas',
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
            }
          }),
    );
  }
}
