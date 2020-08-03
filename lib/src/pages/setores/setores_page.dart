import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifmaacessivel/src/app/app_module.dart';
import 'package:ifmaacessivel/src/models/debouncer.dart';
import 'package:ifmaacessivel/src/models/setor.dart';
import 'package:ifmaacessivel/src/pages/setores/setores_bloc.dart';
import 'package:ifmaacessivel/src/pages/setores/setores_module.dart';
import 'package:ifmaacessivel/src/shared/widgets/card_item.dart';

class SetoresPage extends StatefulWidget {
  @override
  _SetoresPageState createState() => _SetoresPageState();
}

class _SetoresPageState extends State<SetoresPage> {
  SetoresBloc _setoresBloc = SetoresModule.to.getBloc<SetoresBloc>();
  final _debouncer = Debouncer(milliseconds: 100);

  List<Setor> setores = List();
  List<Setor> filteredSetores = List();

  @override
  void initState() {
    super.initState();
    setores = AppModule.setores;
    filteredSetores = setores;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Setores',
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            color: Colors.white,
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                fillColor: Colors.white,
                suffixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).primaryColor,
                ),
                hintText: 'Buscar setor',
              ),
              onChanged: (string) {
                _debouncer.run(
                  () {
                    setState(
                      () {
                        filteredSetores = setores
                            .where(
                              (setor) => (setor.nome
                                  .toLowerCase()
                                  .contains(string.toLowerCase())),
                            )
                            .toList();
                      },
                    );
                  },
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredSetores.length,
              itemBuilder: (BuildContext context, int index) {
                return CardItem(
                  filteredSetores[index].imageUrl,
                  filteredSetores[index].nome,
                  filteredSetores[index].itens,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
