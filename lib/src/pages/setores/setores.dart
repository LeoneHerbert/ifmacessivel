import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifmaacessivel/src/shared/widgets/card_item.dart';
import 'package:ifmaacessivel/src/shared/widgets/custom_appbar.dart';
import 'package:ifmaacessivel/src/shared/widgets/float_page.dart';

class SetoresPage extends StatefulWidget {
  @override
  _SetoresPageState createState() => _SetoresPageState();
}

class _SetoresPageState extends State<SetoresPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          new CustomAppBar("IFMA - Monte Castelo", ""),
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
          new CardItem(
            "https://firebasestorage.googleapis.com/v0/b/sistema-de-estoque.appspot.com/o/Meu-Biju_Arroz-Produto.png?alt=media&token=f3c3b2ea-1afd-4b62-a5dc-a0209ac9c1fc",
            "Arroz Meu Biju",
          ),
          new CardItem(
            "https://firebasestorage.googleapis.com/v0/b/sistema-de-estoque.appspot.com/o/TioJorge_Feija%CC%83o-Fradinho.png?alt=media&token=0de7bc21-aad5-4e2f-88d9-a4a6a466347d",
            "Feijão Tio Jorge",
          ),
          new CardItem(
            "https://firebasestorage.googleapis.com/v0/b/sistema-de-estoque.appspot.com/o/filedepeito.jpg?alt=media&token=ef355344-25af-4bdb-b0f4-2f9e716bd8a4",
            "Filé de Peito de Frango Seara",
          ),
          new CardItem(
            "https://firebasestorage.googleapis.com/v0/b/sistema-de-estoque.appspot.com/o/leiteintegral.png?alt=media&token=71c2be16-207f-42f3-82af-8702e2f39baf",
            "Leite Integral Piracanjuba",
          ),
        ],
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
