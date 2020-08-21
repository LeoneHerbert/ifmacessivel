import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ifmaacessivel/src/app/app_module.dart';
import 'package:ifmaacessivel/src/models/chart.dart';
import 'package:ifmaacessivel/src/models/debouncer.dart';
import 'package:ifmaacessivel/src/models/relatorio.dart';
import 'package:ifmaacessivel/src/models/setor.dart';
import 'package:ifmaacessivel/src/shared/widgets/card_chart.dart';
import 'package:ifmaacessivel/src/shared/widgets/float_chart.dart';

class EstatisticasPage extends StatefulWidget {
  @override
  _EstatisticasPageState createState() => _EstatisticasPageState();
}

class _EstatisticasPageState extends State<EstatisticasPage> {
  List<charts.Series<Chart, String>> _listGeral;
  var setoresChart;
  String acessibilidade;
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
    _listGeral = List<charts.Series<Chart, String>>();
    _generateData();
  }

  double format(double number) {
    return double.parse((number).toStringAsFixed(2));
  }

  _generateData() {

    var geral = [
      new Chart('Acessibilidade', format(Relatorio.valorTotal()),
          cor(Relatorio.valorTotal())),
      new Chart(
          'Inacessibilidade', format(100 - Relatorio.valorTotal()), Colors.amberAccent),
    ];

    _listGeral.add(
      charts.Series(
        id: 'geral',
        // ignore: missing_return
        insideLabelStyleAccessorFn: (Chart geral, _) {
          charts.MaterialPalette.black;
        },
        measureFn: (Chart geral, _) => geral.valor,
        colorFn: (Chart geral, _) =>
            charts.ColorUtil.fromDartColor(geral.color),
        data: geral,
        labelAccessorFn: (Chart row, _) => '${row.valor}%',
        domainFn: (Chart geral, _) => geral.nome,
      ),
    );
  }

  Color cor(double valor) {
    if (valor < 70) {
      acessibilidade = "Irregular";
      return Colors.red;
    } else if (valor >= 70 && valor <= 85) {
      acessibilidade = "Regular";
      return Colors.green;
    }
    acessibilidade = "Ótimo";
    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(FontAwesomeIcons.chartPie),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Geral'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(FontAwesomeIcons.chartPie),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Setores'),
                    ],
                  ),
                ),
              ],
            ),
            title: Text('Estatísticas'),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 70, horizontal: 20),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Gráfico do Relatório Geral',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Expanded(
                          child: charts.PieChart(
                            _listGeral,
                            animate: true,
                            animationDuration: Duration(seconds: 2),
                            defaultRenderer: new charts.ArcRendererConfig(
                              arcWidth: 100,
                              arcRendererDecorators: [
                                new charts.ArcLabelDecorator(
                                  insideLabelStyleSpec: new charts.TextStyleSpec(fontSize: 20, color: charts.MaterialPalette.black),
                                  labelPosition: charts.ArcLabelPosition.inside,
                                )
                              ],
                            ),
                            behaviors: [
                              new charts.DatumLegend(
                                outsideJustification:
                                    charts.OutsideJustification.endDrawArea,
                                horizontalFirst: false,
                                position: charts.BehaviorPosition.top,
                                desiredMaxRows: 1,
                                entryTextStyle: charts.TextStyleSpec(
                                  color: charts
                                      .MaterialPalette.purple.shadeDefault,
                                  fontFamily: 'Arial',
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                        ),
                        Text(
                          acessibilidade,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
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
                                      .where((setor) => (setor.nome
                                          .toLowerCase()
                                          .contains(string.toLowerCase())))
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
                          return GestureDetector(
                            child: CardChart(
                              filteredSetores[index].imageUrl,
                              filteredSetores[index].nome,
                              'Gráfico',
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => FloatChart(filteredSetores[index].nome, index),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
