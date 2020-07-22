import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifmaacessivel/src/pages/profile/profile_module.dart';
import 'package:ifmaacessivel/src/pages/setores/setores_module.dart';
import 'package:ifmaacessivel/src/shared/widgets/side_menu.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _path = '...';
  String _extension;
  bool _hasValidMime = false;
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

  void _openFileExplorer() async {
    try {
      _path = await FilePicker.getFilePath(
          type: FileType.ANY, fileExtension: _extension);
    } catch (e) {
      print("Unsupported operation" + e.toString());
    }
  }

  TextStyle text(cor) {
    return TextStyle(color: cor, fontWeight: FontWeight.bold, fontSize: 23);
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
                  height: MediaQuery.of(context).size.width/2.5,
                  width: MediaQuery.of(context).size.width/2.5,
                  decoration: box(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.location_city,
                        size: MediaQuery.of(context).size.height/7,
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
                onTap: _openFileExplorer,
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.width/2.5,
                  width: MediaQuery.of(context).size.width/2.5,
                  decoration: box(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.folder,
                        size: MediaQuery.of(context).size.height/7,
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
                  height: MediaQuery.of(context).size.width/2.5,
                  width: MediaQuery.of(context).size.width/2.5,
                  decoration: box(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        size: MediaQuery.of(context).size.height/7,
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
                  customLaunch(
                      'mailto:reitoria');
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.width/2.5,
                  width: MediaQuery.of(context).size.width/2.5,
                  decoration: box(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.email,
                        size: MediaQuery.of(context).size.height/7,
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
