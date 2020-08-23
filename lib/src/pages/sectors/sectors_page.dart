import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifmaacessivel/src/app/app_module.dart';
import 'package:ifmaacessivel/src/models/debounce.dart';
import 'package:ifmaacessivel/src/models/sector.dart';
import 'package:ifmaacessivel/src/pages/pdf/general_report/general_report_page.dart';
import 'package:ifmaacessivel/src/shared/widgets/card_item.dart';

class SectorsPage extends StatefulWidget {
  @override
  _SectorsPageState createState() => _SectorsPageState();
}

class _SectorsPageState extends State<SectorsPage> {
  final _debounce = Debounce(milliseconds: 100);
  bool _isEmpty = false;
  List<Sector> sectors = List<Sector>();
  List<Sector> filteredSectors = List<Sector>();

  @override
  void initState() {
    super.initState();
    sectors = AppModule.sectors;
    filteredSectors = sectors;
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
                _debounce.run(
                  () {
                    setState(
                      () {
                        filteredSectors = sectors
                            .where((sector) => (sector.name
                                .toLowerCase()
                                .contains(string.toLowerCase())))
                            .toList();
                        if (filteredSectors.isEmpty) {
                          _isEmpty = true;
                        } else {
                          _isEmpty = false;
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
          StreamBuilder<bool>(
              stream: null,
              builder: (context, snapshot) {
                if (_isEmpty) {
                  return Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Setor não encontrado',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: filteredSectors.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CardItem(
                        filteredSectors[index].imageUrl,
                        filteredSectors[index].name,
                        filteredSectors[index].itens,
                      );
                    },
                  ),
                );
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => GeneralReportPage(),
            ),
          );
        },
        child: Icon(Icons.picture_as_pdf),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
