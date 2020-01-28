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
  String _nome,
      _url,
      imageCard =
          "https://firebasestorage.googleapis.com/v0/b/ifmacessivel-48fa8.appspot.com/o/default.jpg?alt=media&token=4c877c08-998e-49f9-a97c-2354ca38b555";
  List<DropdownMenuItem<String>> _dropDownMenuItems = new List();

  @override
  void initState() {
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
    setDropdownList();
    super.initState();
  }

  void setDropdownList() {
    _dropDownMenuItems.add(
      new DropdownMenuItem(
        child: new Text('SELECIONE'),
      ),
    );

    _dropDownMenuItems.add(
      new DropdownMenuItem(
        value: 'escada',
        child: new Text('ESCADA'),
      ),
    );

    _dropDownMenuItems.add(
      new DropdownMenuItem(
        value: 'estacionamento',
        child: new Text('ESTACIONAMENTO'),
      ),
    );

    _dropDownMenuItems.add(
      new DropdownMenuItem(
        value: 'acesso_a_edificacao',
        child: new Text('ACESSO À EDIFICAÇÃO'),
      ),
    );

    _dropDownMenuItems.add(
      new DropdownMenuItem(
        value: 'circulacao_interna',
        child: new Text('CIRCULAÇÃO  INTERNA'),
      ),
    );

    _dropDownMenuItems.add(
      new DropdownMenuItem(
        value: 'esquadrias',
        child: new Text('ESQUADRIAS'),
      ),
    );

    _dropDownMenuItems.add(
      new DropdownMenuItem(
        value: 'banheiro',
        child: new Text('BANHEIRO'),
      ),
    );

    _dropDownMenuItems.add(
      new DropdownMenuItem(
        value: 'vestiarios',
        child: new Text('VESTIÁRIOS'),
      ),
    );

    _dropDownMenuItems.add(
      new DropdownMenuItem(
        value: 'biblioteca',
        child: new Text('BIBLIOTECA'),
      ),
    );

    _dropDownMenuItems.add(
      new DropdownMenuItem(
        value: 'auditorios',
        child: new Text('AUDITÓRIOS  E SIMILARES'),
      ),
    );

    _dropDownMenuItems.add(
      new DropdownMenuItem(
        value: 'restaurantes',
        child: new Text('RESTAURANTES  E SIMILARES'),
      ),
    );

    _dropDownMenuItems.add(
      new DropdownMenuItem(
        value: 'mobiliario',
        child: new Text('MOBILIÁRIO'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection(auth.getUserId())
            .document("setores")
            .collection("setor")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');
            default:
              return ListView(
                children: <Widget>[
                  new CustomAppBar(_nome, _url),
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
                      children: snapshot.data.documents
                          .map(
                            (document) => CardItem(
                              imageCard,
                              document.data['nome'],
                            ),
                          )
                          .toList(),
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
            builder: (context) => new FloatPage(_dropDownMenuItems),
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
