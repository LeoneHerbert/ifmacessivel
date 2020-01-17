import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifmaacessivel/src/app/app_module.dart';
import 'package:ifmaacessivel/src/auth/authentification.dart';
import 'package:ifmaacessivel/src/shared/widgets/card_item.dart';
import 'package:ifmaacessivel/src/shared/widgets/custom_appbar.dart';
import 'package:ifmaacessivel/src/shared/widgets/float_page.dart';

class SetoresPage extends StatefulWidget {
  @override
  _SetoresPageState createState() => _SetoresPageState();
}

class _SetoresPageState extends State<SetoresPage> {
  Authentification auth = AppModule.to.getDependency<Authentification>();
  String _nome, _url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection("criterios_de_acessibilidade")
            .document("calcada").collection("geral").
            snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');
            default:
              return ListView(
                children: <Widget>[
                  new CustomAppBar("herbert", "snapshot.data['imageUrl']"),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Setores",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: 
                        snapshot.data.documents.map((document) => CardItem(document.data['situacao'], document.data['texto'])).toList()
                
                    ),
                  )
                ],
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => FloatPage(
              'Pedido de Estoque',
              'Filial',
              'Cliente',
              'Observação',
              1,
              5,
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).highlightColor,
        ),
      ),
    );
  }
}
