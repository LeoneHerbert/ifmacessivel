import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:ifmaacessivel/src/models/chart.dart';
import 'package:ifmaacessivel/src/models/report.dart';

// ignore: must_be_immutable
class FloatChart extends StatelessWidget {
  final String name;
  final int index;
  List<charts.Series<Chart, String>> _generalList;
  String acessibility;
  Map<String, double> sectorValues = Map();
  Map<String, double> sectorTotalValues = Map();

  FloatChart(this.name, this.index) {
    sectorValues = {
      'Acesso à Edificação': Report.valueAcessoAEdificacao,
      'Auditórios e Similares': Report.valueAuditorios,
      'Banheiros': Report.valueBanheiros,
      'Biblioteca': Report.valueBiblioteca,
      'Calçada': Report.valueCalcada,
      'Circulação Interna': Report.valueCirculacaoInterna,
      'Esquadrias': Report.valueEsquadrias,
      'Estacionamento': Report.valueEstacionamento,
      'Mobiliário': Report.valueMobiliario,
      'Restaurantes e Similares': Report.valueRestaurantes,
      'Vestiários': Report.valueVestiarios,
    };

    sectorTotalValues = {
      'Acesso à Edificação': Report.totalValueAcessoAEdificacao,
      'Auditórios e Similares': Report.totalValueAuditorios,
      'Banheiros': Report.totalValueBanheiros,
      'Biblioteca': Report.totalValueBiblioteca,
      'Calçada': Report.totalValueCalcada,
      'Circulação Interna': Report.totalValueCirculacaoInterna,
      'Esquadrias': Report.totalValueEsquadrias,
      'Estacionamento': Report.totalValueEstacionamento,
      'Mobiliário': Report.totalValueMobiliario,
      'Restaurantes e Similares': Report.totalValueRestaurantes,
      'Vestiários': Report.totalValueVestiarios,
    };
    _generalList = List<charts.Series<Chart, String>>();
    _generateData();
  }

  double calculoPorcentagem(double totalValue, double value) {
    return (value / totalValue) * 100;
  }

  double format(double number) {
    print(number);
    return double.parse((number).toStringAsFixed(2));
  }

  _generateData() {
    List<Chart> chart = [
      new Chart(
          'Acessibilidade',
          format(
              calculoPorcentagem(sectorTotalValues[name], sectorValues[name])),
          cor(calculoPorcentagem(sectorTotalValues[name], sectorValues[name]))),
      new Chart(
          'Inacessibilidade',
          format((sectorTotalValues[name] - sectorValues[name]) * 10),
          Colors.amberAccent),
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
      acessibility = "Irregular";
      return Colors.red;
    } else if (value >= 70 && value <= 85) {
      acessibility = "Regular";
      return Colors.green;
    }
    acessibility = "Ótimo";
    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: MediaQuery.of(context).size.height / 2.8,
        width: double.maxFinite,
        child: Center(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        child: Icon(Icons.close),
                        onTap: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                color: Theme.of(context).accentColor,
              ),
              Text(
                acessibility,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
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
                        insideLabelStyleSpec: new charts.TextStyleSpec(
                          fontSize: 20,
                          color: charts.MaterialPalette.black,
                        ),
                        labelPosition: charts.ArcLabelPosition.inside,
                      )
                    ],
                  ),
                  behaviors: [
                    new charts.DatumLegend(
                      outsideJustification:
                          charts.OutsideJustification.endDrawArea,
                      horizontalFirst: false,
                      desiredMaxRows: 1,
                      position: charts.BehaviorPosition.bottom,
                      entryTextStyle: charts.TextStyleSpec(
                        color: charts.MaterialPalette.purple.shadeDefault,
                        fontFamily: 'Arial',
                        fontSize: 14,
                      ),
                    )
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
