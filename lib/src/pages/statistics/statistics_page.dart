import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ifmaacessivel/src/app/app_module.dart';
import 'package:ifmaacessivel/src/models/chart.dart';
import 'package:ifmaacessivel/src/models/debounce.dart';
import 'package:ifmaacessivel/src/models/report.dart';
import 'package:ifmaacessivel/src/models/sector.dart';
import 'package:ifmaacessivel/src/shared/widgets/card_chart.dart';
import 'package:ifmaacessivel/src/shared/widgets/float_chart.dart';

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  List<charts.Series<Chart, String>> _generalList;
  String accessibility;
  bool _isEmpty = false;
  final _debounce = Debounce(milliseconds: 100);

  List<Sector> sectors = List();
  List<Sector> filteredSectors = List();

  @override
  void initState() {
    super.initState();
    sectors = AppModule.sectors;
    filteredSectors = sectors;
    _generalList = List<charts.Series<Chart, String>>();
    _generateData();
  }

  double format(double number) {
    return double.parse((number).toStringAsFixed(2));
  }

  _generateData() {

    List<Chart> chart = [
      new Chart('Acessibilidade', format(Report.totalValue()),
          cor(Report.totalValue())),
      new Chart(
          'Inacessibilidade', format(100 - Report.totalValue()), Colors.amberAccent),
    ];

    _generalList.add(
      charts.Series(
        id: 'chart',
        // ignore: missing_return
        insideLabelStyleAccessorFn: (Chart chart, _) {
        },
        measureFn: (Chart chart, _) => chart.value,
        colorFn: (Chart chart, _) =>
            charts.ColorUtil.fromDartColor(chart.color),
        data: chart,
        labelAccessorFn: (Chart row, _) => '${row.value}%',
        domainFn: (Chart chart, _) => chart.name,
      ),
    );
  }

  Color cor(double value) {
    if (value < 70) {
      accessibility = "Irregular";
      return Colors.red;
    } else if (value >= 70 && value <= 85) {
      accessibility = "Regular";
      return Colors.green;
    }
    accessibility = "Ótimo";
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
                            _generalList,
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
                          accessibility,
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
                    StreamBuilder<Object>(
                      stream: null,
                      builder: (context, snapshot) {
                        if (_isEmpty) {
                          return Container(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              'Setor não encontrado',
                              style:
                              TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          );
                        }
                        return Expanded(
                          child: ListView.builder(
                            itemCount: filteredSectors.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                child: CardChart(
                                  filteredSectors[index].imageUrl,
                                  filteredSectors[index].name,
                                  'Gráfico',
                                ),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => FloatChart(filteredSectors[index].name, index),
                                  );
                                },
                              );
                            },
                          ),
                        );
                      }
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
