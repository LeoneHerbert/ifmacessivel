import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ifmaacessivel/src/app/app_module.dart';
import 'package:ifmaacessivel/src/auth/authentification.dart';
import 'package:ifmaacessivel/src/shared/widgets/float_notification.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Perfil"),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                child: IconButton(
                  icon: Icon(
                    Icons.notifications,
                    size: 35,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => FloatNotification());
                  },
                ),
              ),
              IconButton(
                padding: EdgeInsets.only(left: 20, bottom: 12),
                icon: Icon(
                  Icons.brightness_1,
                  color: Colors.red,
                  size: 17,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => FloatNotification());
                },
              ),
              Container(
                padding: EdgeInsets.only(left: 31, top: 12),
                child: Text(
                  "1",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection(AppModule.to.getDependency<Authentification>().getUserId())
              .document("usuario")
              .snapshots(),
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 3.25,
                    width: double.infinity,
                    decoration: new BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).accentColor,
                          blurRadius: 5.0,
                          spreadRadius: 2.0,
                        )
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        new Container(
                          width: 165,
                          height: 165,
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                snapshot.data['imageUrl'],
                                scale: 20,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  Icons.settings,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Nome",
                          style: Theme.of(context).textTheme.title,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          snapshot.data['nome'],
                          style: Theme.of(context).textTheme.headline,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Encarregado",
                          style: Theme.of(context).textTheme.title,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          snapshot.data['encarregado'],
                          style: Theme.of(context).textTheme.headline,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "E-mail",
                          style: Theme.of(context).textTheme.title,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          snapshot.data['email'],
                          style: Theme.of(context).textTheme.headline,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Telefone",
                          style: Theme.of(context).textTheme.title,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          snapshot.data['telefone'],
                          style: Theme.of(context).textTheme.headline,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Endereço",
                          style: Theme.of(context).textTheme.title,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          snapshot.data['endereco'],
                          style: Theme.of(context).textTheme.headline,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        Text(
                          "Descrição",
                          style: Theme.of(context).textTheme.title,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          snapshot.data['descricao'],
                          style: Theme.of(context).textTheme.headline,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
