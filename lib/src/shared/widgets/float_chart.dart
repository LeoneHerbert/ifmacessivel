import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:ifmaacessivel/src/models/chart.dart';
import 'package:ifmaacessivel/src/models/relatorio.dart';

// ignore: must_be_immutable
class FloatChart extends StatelessWidget {
  final String nome;
  final int index;
  List<charts.Series<Chart, String>> _listGeral;
  String acessibilidade;
  Map<String, double> valorSetores = Map();
  Map<String, double> valorTotalSetores = Map();

  FloatChart(this.nome, this.index) {
    valorSetores = {
      'Acesso à Edificação': Relatorio.valorAcessoAEdificacao,
      'Auditórios e Similares': Relatorio.valorAuditorios,
      'Banheiros': Relatorio.valorBanheiros,
      'Biblioteca': Relatorio.valorBiblioteca,
      'Calçada': Relatorio.valorCalcada,
      'Circulação Interna': Relatorio.valorCirculacaoInterna,
      'Esquadrias': Relatorio.valorEsquadrias,
      'Estacionamento': Relatorio.valorEstacionamento,
      'Mobiliário': Relatorio.valorMobiliario,
      'Restaurantes e Similares': Relatorio.valorRestaurantes,
      'Vestiários': Relatorio.valorVestiarios,
    };

    valorTotalSetores = {
      'Acesso à Edificação': Relatorio.valorTotalAcessoAEdificacao,
      'Auditórios e Similares': Relatorio.valorTotalAuditorios,
      'Banheiros': Relatorio.valorTotalBanheiros,
      'Biblioteca': Relatorio.valorTotalBiblioteca,
      'Calçada': Relatorio.valorTotalCalcada,
      'Circulação Interna': Relatorio.valorTotalCirculacaoInterna,
      'Esquadrias': Relatorio.valorTotalEsquadrias,
      'Estacionamento': Relatorio.valorTotalEstacionamento,
      'Mobiliário': Relatorio.valorTotalMobiliario,
      'Restaurantes e Similares': Relatorio.valorTotalRestaurantes,
      'Vestiários': Relatorio.valorTotalVestiarios,
    };
    _listGeral = List<charts.Series<Chart, String>>();
    _generateData();
  }

  double calculoPorcentagem(double valorTotal, double valor) {
    return (valor / valorTotal) * 100;
  }

  double format(double number) {
    print(number);
    return double.parse((number).toStringAsFixed(2));
  }

  _generateData() {
    var geral = [
      new Chart(
          'Acessibilidade',
          format(
              calculoPorcentagem(valorTotalSetores[nome], valorSetores[nome])),
          cor(calculoPorcentagem(valorTotalSetores[nome], valorSetores[nome]))),
      new Chart(
          'Inacessibilidade',
          format((valorTotalSetores[nome] - valorSetores[nome]) * 10),
          Colors.amberAccent),
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

    return AlertDialog(
      content: Container(
        height: MediaQuery.of(context).size.height/2,
        width: double.maxFinite,
        child: Center(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    nome,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20 ,
                    ),
                  ),
                  GestureDetector(
                    child: Icon(Icons.close),
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0 ,
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
                      entryTextStyle: charts.TextStyleSpec(
                        color: charts.MaterialPalette.purple.shadeDefault,
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
                  fontSize: 20 ,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
