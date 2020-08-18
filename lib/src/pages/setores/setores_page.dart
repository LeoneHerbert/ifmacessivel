import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifmaacessivel/src/app/app_module.dart';
import 'package:ifmaacessivel/src/models/debouncer.dart';
import 'package:ifmaacessivel/src/models/relatorio.dart';
import 'package:ifmaacessivel/src/models/setor.dart';
import 'package:ifmaacessivel/src/pages/pdf/relatorio_geral/relatorio_geral_pdf.dart';
import 'package:ifmaacessivel/src/pages/setores/setores_bloc.dart';
import 'package:ifmaacessivel/src/pages/setores/setores_module.dart';
import 'package:ifmaacessivel/src/shared/widgets/card_item.dart';

class SetoresPage extends StatefulWidget {
  @override
  _SetoresPageState createState() => _SetoresPageState();
}

class _SetoresPageState extends State<SetoresPage> {
  bool loading;
  final _debouncer = Debouncer(milliseconds: 100);

  List<Setor> setores = List();
  List<Setor> filteredSetores = List();

  @override
  void initState() {
    super.initState();
    setores = AppModule.setores;
    filteredSetores = setores;
    loading = true;
  }

  Widget _mensagem(bool state) {
    if (state) {
      return Text('Setor não encontrado');
    } else {}
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
                        loading = false;
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => RelatorioGeralPDF(),
            ),
          );
        },
        child: Icon(Icons.picture_as_pdf),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
