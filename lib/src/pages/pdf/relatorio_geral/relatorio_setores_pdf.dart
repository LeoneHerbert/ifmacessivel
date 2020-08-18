import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:ifmaacessivel/src/models/questionario.dart';
import 'package:ifmaacessivel/src/models/relatorio.dart';
import 'package:ifmaacessivel/src/models/user.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> generateSetores(PdfPageFormat pageFormat) async {
  final lorem = pw.LoremText();

  final setor = SetorConfiguracoes(
    baseColor: PdfColors.green,
    accentColor: PdfColors.redAccent700,
  );

  return await setor.buildPdf(pageFormat);
}

class SetorConfiguracoes {
  SetorConfiguracoes({
    this.baseColor,
    this.accentColor,
  });

  static List<Questionario> acessoAEdificacaoList =
      Relatorio.acessoAEdificacaoList;
  static List<Questionario> auditoriosList = Relatorio.auditoriosList;
  static List<Questionario> banheirosList = Relatorio.banheirosList;
  static List<Questionario> bibliotecaList = Relatorio.bibliotecaList;
  static List<Questionario> calcadaList = Relatorio.calcadaList;
  static List<Questionario> circulacaoInternaList =
      Relatorio.circulacaoInternaList;
  static List<Questionario> esquadriasList = Relatorio.esquadriasList;
  static List<Questionario> estacionamentoList = Relatorio.estacionamentoList;
  static List<Questionario> mobiliarioList = Relatorio.mobiliarioList;
  static List<Questionario> restaurantesList = Relatorio.restaurantesList;
  static List<Questionario> vestiariosList = Relatorio.vestiariosList;
  final PdfColor baseColor;
  final PdfColor accentColor;

  static const _darkColor = PdfColors.blueGrey800;
  static const _lightColor = PdfColors.white;

  PdfColor get _baseTextColor =>
      baseColor.luminance < 0.5 ? _lightColor : _darkColor;

  PdfColor get _accentTextColor =>
      baseColor.luminance < 0.5 ? _lightColor : _darkColor;

  double _maximoTotal() {
    return 100;
  }

  String _requisitoDeAcessibilidade(){
    if(valorAcessibilidade() < 70){
      return "Irregular";
    } else if(valorAcessibilidade () >= 70 && valorAcessibilidade() < 85){
      return "Regular";
    }else{
      return "Ótimo";
    }
  }

  double valorAcessibilidade() {
    double valorTotal = 0;
    acessoAEdificacaoList.forEach((questionario) {
      if (questionario.situacao == 'Sim' || questionario.situacao == 'N/A') {
        valorTotal = valorTotal + questionario.q;
      }
    });
    auditoriosList.forEach((questionario) {
      if (questionario.situacao == 'Sim' || questionario.situacao == 'N/A') {
        valorTotal = valorTotal + questionario.q;
      }
    });
    banheirosList.forEach((questionario) {
      if (questionario.situacao == 'Sim' || questionario.situacao == 'N/A') {
        valorTotal = valorTotal + questionario.q;
      }
    });
    calcadaList.forEach((questionario) {
      if (questionario.situacao == 'Sim' || questionario.situacao == 'N/A') {
        valorTotal = valorTotal + questionario.q;
      }
    });
    circulacaoInternaList.forEach((questionario) {
      if (questionario.situacao == 'Sim' || questionario.situacao == 'N/A') {
        valorTotal = valorTotal + questionario.q;
      }
    });
    esquadriasList.forEach((questionario) {
      if (questionario.situacao == 'Sim' || questionario.situacao == 'N/A') {
        valorTotal = valorTotal + questionario.q;
      }
    });
    estacionamentoList.forEach((questionario) {
      if (questionario.situacao == 'Sim' || questionario.situacao == 'N/A') {
        valorTotal = valorTotal + questionario.q;
      }
    });
    mobiliarioList.forEach((questionario) {
      if (questionario.situacao == 'Sim' || questionario.situacao == 'N/A') {
        valorTotal = valorTotal + questionario.q;
      }
    });
    restaurantesList.forEach((questionario) {
      if (questionario.situacao == 'Sim' || questionario.situacao == 'N/A') {
        valorTotal = valorTotal + questionario.q;
      }
    });
    vestiariosList.forEach((questionario) {
      if (questionario.situacao == 'Sim' || questionario.situacao == 'N/A') {
        valorTotal = valorTotal + questionario.q;
      }
    });
    return valorTotal;
  }

  PdfImage _logo;

  Future<Uint8List> buildPdf(PdfPageFormat pageFormat) async {
    // Create a PDF document.
    final doc = pw.Document();

    final font1 = await rootBundle.load('fonts/Roboto-Light.ttf');
    final font2 = await rootBundle.load('fonts/Roboto-Light.ttf');
    final font3 = await rootBundle.load('fonts/Roboto-Light.ttf');

    _logo = PdfImage.file(
      doc.document,
      bytes: (await rootBundle.load('images/logo.png')).buffer.asUint8List(),
    );

    // Add page to the PDF
    doc.addPage(
      pw.MultiPage(
        pageTheme: _buildTheme(
          pageFormat,
          font1 != null ? pw.Font.ttf(font1) : null,
          font2 != null ? pw.Font.ttf(font2) : null,
          font3 != null ? pw.Font.ttf(font3) : null,
        ),
        header: _buildHeader,
        footer: _buildFooter,
        build: (context) => [
          _contentHeaderAcessoAEdificacao(context),
          _contentTableAcessoAEdificacao(context),
          pw.SizedBox(height: 20),
          _contentHeaderAuditorios(context),
          _contentTableAuditorios(context),
          pw.SizedBox(height: 20),
          _contentHeaderBanheiros(context),
          _contentTableBanheiros(context),
          pw.SizedBox(height: 20),
          _contentHeaderBiblioteca(context),
          _contentTableBiblioteca(context),
          pw.SizedBox(height: 20),
          _contentHeaderCalcada(context),
          _contentTableCalcada(context),
          pw.SizedBox(height: 20),
          _contentHeaderCirculacaoInterna(context),
          _contentTableCirculacaoInterna(context),
          pw.SizedBox(height: 20),
          _contentHeaderEsquadrias(context),
          _contentTableEsquadrias(context),
          pw.SizedBox(height: 20),
          _contentHeaderEstacionamento(context),
          _contentTableEstacionamento(context),
          pw.SizedBox(height: 20),
          _contentHeaderMobiliario(context),
          _contentTableMobiliario(context),
          pw.SizedBox(height: 20),
          _contentHeaderRestaurantes(context),
          _contentTableRestaurantes(context),
          pw.SizedBox(height: 20),
          _contentHeaderVestiarios(context),
          _contentTableVestiarios(context),
          pw.SizedBox(height: 20),
          _contentFooter(context),
          pw.SizedBox(height: 20),
          _termsAndConditions(context),
        ],
      ),
    );

    // Return the PDF file content
    return doc.save();
  }

  pw.Widget _buildHeader(pw.Context context) {
    return pw.Column(
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: pw.Column(
                children: [
                  pw.Container(
                    height: 50,
                    width: double.infinity,
                    padding: const pw.EdgeInsets.only(left: 10),
                    alignment: pw.Alignment.topLeft,
                    child: pw.Text(
                      'ACESSIBILIDADE',
                      style: pw.TextStyle(
                        color: baseColor,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                  ),
                  pw.Container(
                    decoration: pw.BoxDecoration(
                      borderRadius: 2,
                      color: accentColor,
                    ),
                    padding: const pw.EdgeInsets.only(
                      left: 10,
                      top: 10,
                      bottom: 10,
                      right: 10,
                    ),
                    alignment: pw.Alignment.centerLeft,
                    height: 70,
                    child: pw.DefaultTextStyle(
                      style: pw.TextStyle(
                        color: _accentTextColor,
                        fontSize: 12,
                      ),
                      child: pw.GridView(
                        crossAxisCount: 2,
                        children: [
                          pw.Text('Encarregado(a):'),
                          pw.Text(User.encarregado),
                          pw.Text('Data:'),
                          pw.Text(_formatDate(DateTime.now())),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pw.Expanded(
              child: pw.Column(
                mainAxisSize: pw.MainAxisSize.min,
                children: [
                  pw.Container(
                    alignment: pw.Alignment.topRight,
                    padding: const pw.EdgeInsets.only(bottom: 8, left: 30),
                    height: 72,
                    child: _logo != null ? pw.Image(_logo) : pw.PdfLogo(),
                  ),
                  // pw.Container(
                  //   color: baseColor,
                  //   padding: pw.EdgeInsets.only(top: 3),
                  // ),
                ],
              ),
            ),
          ],
        ),
        if (context.pageNumber > 1) pw.SizedBox(height: 20)
      ],
    );
  }

  pw.Widget _buildFooter(pw.Context context) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Text(
          'Página ${context.pageNumber}/${context.pagesCount}',
          style: const pw.TextStyle(
            fontSize: 12,
            color: PdfColors.grey,
          ),
        ),
      ],
    );
  }

  pw.PageTheme _buildTheme(
      PdfPageFormat pageFormat, pw.Font base, pw.Font bold, pw.Font italic) {
    return pw.PageTheme(
      pageFormat: pageFormat,
      theme: pw.ThemeData.withFont(
        base: base,
        bold: bold,
        italic: italic,
      ),
      buildBackground: (context) => pw.FullPage(
        ignoreMargins: true,
        child: pw.Stack(
          children: [
            pw.Positioned(
              bottom: 0,
              left: 0,
              child: pw.Container(
                height: 20,
                width: pageFormat.width / 2,
                decoration: pw.BoxDecoration(
                  gradient: pw.LinearGradient(
                    colors: [baseColor, PdfColors.white],
                  ),
                ),
              ),
            ),
            pw.Positioned(
              bottom: 20,
              left: 0,
              child: pw.Container(
                height: 20,
                width: pageFormat.width / 4,
                decoration: pw.BoxDecoration(
                  gradient: pw.LinearGradient(
                    colors: [accentColor, PdfColors.white],
                  ),
                ),
              ),
            ),
            pw.Positioned(
              top: pageFormat.marginTop + 72,
              left: 0,
              right: 0,
              child: pw.Container(
                height: 3,
                color: baseColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  pw.Widget _contentHeaderCalcada(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        pw.Container(
          padding: pw.EdgeInsets.all(20),
          child: pw.Text(
            "Calçada",
            style: pw.TextStyle(
              color: baseColor,
              fontWeight: pw.FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
      ],
    );
  }

  pw.Widget _contentTableCalcada(pw.Context context) {
    const tableHeaders = [
      ' ID          ',
      'Texto',
      'Q                               ',
      'Situação                                       ',
    ];

    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(
        borderRadius: 2,
        color: baseColor,
      ),
      headerHeight: 25,
      cellHeight: 50,
      cellAlignments: {
        0: pw.Alignment.center,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
        4: pw.Alignment.centerLeft,
      },
      headerStyle: pw.TextStyle(
        color: _baseTextColor,
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: const pw.TextStyle(
        color: _darkColor,
        fontSize: 10,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.BoxBorder(
          bottom: true,
          color: accentColor,
          width: .5,
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        calcadaList.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => calcadaList[row].getIndex(col),
        ),
      ),
    );
  }

  pw.Widget _contentHeaderAcessoAEdificacao(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        pw.Container(
          padding: pw.EdgeInsets.all(20),
          child: pw.Text(
            "Acesso à Edificação",
            style: pw.TextStyle(
              color: baseColor,
              fontWeight: pw.FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
      ],
    );
  }

  pw.Widget _contentTableAcessoAEdificacao(pw.Context context) {
    const tableHeaders = [
      ' ID          ',
      'Texto',
      'Q                               ',
      'Situação                                       ',
    ];

    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(
        borderRadius: 2,
        color: baseColor,
      ),
      headerHeight: 25,
      cellHeight: 50,
      cellAlignments: {
        0: pw.Alignment.center,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
        4: pw.Alignment.centerLeft,
      },
      headerStyle: pw.TextStyle(
        color: _baseTextColor,
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: const pw.TextStyle(
        color: _darkColor,
        fontSize: 10,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.BoxBorder(
          bottom: true,
          color: accentColor,
          width: .5,
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        acessoAEdificacaoList.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => acessoAEdificacaoList[row].getIndex(col),
        ),
      ),
    );
  }

  pw.Widget _contentHeaderAuditorios(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        pw.Container(
          padding: pw.EdgeInsets.all(20),
          child: pw.Text(
            "Auditórios e Similares",
            style: pw.TextStyle(
              color: baseColor,
              fontWeight: pw.FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
      ],
    );
  }

  pw.Widget _contentTableAuditorios(pw.Context context) {
    const tableHeaders = [
      ' ID          ',
      'Texto',
      'Q                               ',
      'Situação                                       ',
    ];

    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(
        borderRadius: 2,
        color: baseColor,
      ),
      headerHeight: 25,
      cellHeight: 50,
      cellAlignments: {
        0: pw.Alignment.center,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
        4: pw.Alignment.centerLeft,
      },
      headerStyle: pw.TextStyle(
        color: _baseTextColor,
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: const pw.TextStyle(
        color: _darkColor,
        fontSize: 10,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.BoxBorder(
          bottom: true,
          color: accentColor,
          width: .5,
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        auditoriosList.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => auditoriosList[row].getIndex(col),
        ),
      ),
    );
  }

  pw.Widget _contentHeaderBanheiros(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        pw.Container(
          padding: pw.EdgeInsets.all(20),
          child: pw.Text(
            "Banheiros",
            style: pw.TextStyle(
              color: baseColor,
              fontWeight: pw.FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
      ],
    );
  }

  pw.Widget _contentTableBanheiros(pw.Context context) {
    const tableHeaders = [
      ' ID          ',
      'Texto',
      'Q                               ',
      'Situação                                       ',
    ];

    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(
        borderRadius: 2,
        color: baseColor,
      ),
      headerHeight: 25,
      cellHeight: 50,
      cellAlignments: {
        0: pw.Alignment.center,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
        4: pw.Alignment.centerLeft,
      },
      headerStyle: pw.TextStyle(
        color: _baseTextColor,
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: const pw.TextStyle(
        color: _darkColor,
        fontSize: 10,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.BoxBorder(
          bottom: true,
          color: accentColor,
          width: .5,
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        banheirosList.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => banheirosList[row].getIndex(col),
        ),
      ),
    );
  }

  pw.Widget _contentHeaderBiblioteca(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        pw.Container(
          padding: pw.EdgeInsets.all(20),
          child: pw.Text(
            "Biblioteca",
            style: pw.TextStyle(
              color: baseColor,
              fontWeight: pw.FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
      ],
    );
  }

  pw.Widget _contentTableBiblioteca(pw.Context context) {
    const tableHeaders = [
      ' ID          ',
      'Texto',
      'Q                               ',
      'Situação                                       ',
    ];

    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(
        borderRadius: 2,
        color: baseColor,
      ),
      headerHeight: 25,
      cellHeight: 50,
      cellAlignments: {
        0: pw.Alignment.center,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
        4: pw.Alignment.centerLeft,
      },
      headerStyle: pw.TextStyle(
        color: _baseTextColor,
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: const pw.TextStyle(
        color: _darkColor,
        fontSize: 10,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.BoxBorder(
          bottom: true,
          color: accentColor,
          width: .5,
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        bibliotecaList.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => bibliotecaList[row].getIndex(col),
        ),
      ),
    );
  }

  pw.Widget _contentHeaderCirculacaoInterna(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        pw.Container(
          padding: pw.EdgeInsets.all(20),
          child: pw.Text(
            "Circulação Interna",
            style: pw.TextStyle(
              color: baseColor,
              fontWeight: pw.FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
      ],
    );
  }

  pw.Widget _contentTableCirculacaoInterna(pw.Context context) {
    const tableHeaders = [
      ' ID          ',
      'Texto',
      'Q                               ',
      'Situação                                       ',
    ];

    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(
        borderRadius: 2,
        color: baseColor,
      ),
      headerHeight: 25,
      cellHeight: 50,
      cellAlignments: {
        0: pw.Alignment.center,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
        4: pw.Alignment.centerLeft,
      },
      headerStyle: pw.TextStyle(
        color: _baseTextColor,
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: const pw.TextStyle(
        color: _darkColor,
        fontSize: 10,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.BoxBorder(
          bottom: true,
          color: accentColor,
          width: .5,
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        circulacaoInternaList.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => circulacaoInternaList[row].getIndex(col),
        ),
      ),
    );
  }

  pw.Widget _contentHeaderEsquadrias(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        pw.Container(
          padding: pw.EdgeInsets.all(20),
          child: pw.Text(
            "Esquadrias",
            style: pw.TextStyle(
              color: baseColor,
              fontWeight: pw.FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
      ],
    );
  }

  pw.Widget _contentTableEsquadrias(pw.Context context) {
    const tableHeaders = [
      ' ID          ',
      'Texto',
      'Q                               ',
      'Situação                                       ',
    ];

    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(
        borderRadius: 2,
        color: baseColor,
      ),
      headerHeight: 25,
      cellHeight: 50,
      cellAlignments: {
        0: pw.Alignment.center,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
        4: pw.Alignment.centerLeft,
      },
      headerStyle: pw.TextStyle(
        color: _baseTextColor,
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: const pw.TextStyle(
        color: _darkColor,
        fontSize: 10,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.BoxBorder(
          bottom: true,
          color: accentColor,
          width: .5,
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        esquadriasList.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => esquadriasList[row].getIndex(col),
        ),
      ),
    );
  }

  pw.Widget _contentHeaderEstacionamento(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        pw.Container(
          padding: pw.EdgeInsets.all(20),
          child: pw.Text(
            "Estacionamento",
            style: pw.TextStyle(
              color: baseColor,
              fontWeight: pw.FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
      ],
    );
  }

  pw.Widget _contentTableEstacionamento(pw.Context context) {
    const tableHeaders = [
      ' ID          ',
      'Texto',
      'Q                               ',
      'Situação                                       ',
    ];

    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(
        borderRadius: 2,
        color: baseColor,
      ),
      headerHeight: 25,
      cellHeight: 50,
      cellAlignments: {
        0: pw.Alignment.center,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
        4: pw.Alignment.centerLeft,
      },
      headerStyle: pw.TextStyle(
        color: _baseTextColor,
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: const pw.TextStyle(
        color: _darkColor,
        fontSize: 10,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.BoxBorder(
          bottom: true,
          color: accentColor,
          width: .5,
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        estacionamentoList.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => estacionamentoList[row].getIndex(col),
        ),
      ),
    );
  }

  pw.Widget _contentHeaderMobiliario(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        pw.Container(
          padding: pw.EdgeInsets.all(20),
          child: pw.Text(
            "Mobiliários",
            style: pw.TextStyle(
              color: baseColor,
              fontWeight: pw.FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
      ],
    );
  }

  pw.Widget _contentTableMobiliario(pw.Context context) {
    const tableHeaders = [
      ' ID          ',
      'Texto',
      'Q                               ',
      'Situação                                       ',
    ];

    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(
        borderRadius: 2,
        color: baseColor,
      ),
      headerHeight: 25,
      cellHeight: 50,
      cellAlignments: {
        0: pw.Alignment.center,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
        4: pw.Alignment.centerLeft,
      },
      headerStyle: pw.TextStyle(
        color: _baseTextColor,
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: const pw.TextStyle(
        color: _darkColor,
        fontSize: 10,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.BoxBorder(
          bottom: true,
          color: accentColor,
          width: .5,
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        mobiliarioList.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => mobiliarioList[row].getIndex(col),
        ),
      ),
    );
  }

  pw.Widget _contentHeaderRestaurantes(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        pw.Container(
          padding: pw.EdgeInsets.all(20),
          child: pw.Text(
            "Restaurantes e Similares",
            style: pw.TextStyle(
              color: baseColor,
              fontWeight: pw.FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
      ],
    );
  }

  pw.Widget _contentTableRestaurantes(pw.Context context) {
    const tableHeaders = [
      ' ID          ',
      'Texto',
      'Q                               ',
      'Situação                                       ',
    ];

    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(
        borderRadius: 2,
        color: baseColor,
      ),
      headerHeight: 25,
      cellHeight: 50,
      cellAlignments: {
        0: pw.Alignment.center,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
        4: pw.Alignment.centerLeft,
      },
      headerStyle: pw.TextStyle(
        color: _baseTextColor,
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: const pw.TextStyle(
        color: _darkColor,
        fontSize: 10,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.BoxBorder(
          bottom: true,
          color: accentColor,
          width: .5,
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        restaurantesList.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => restaurantesList[row].getIndex(col),
        ),
      ),
    );
  }

  pw.Widget _contentHeaderVestiarios(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        pw.Container(
          padding: pw.EdgeInsets.all(20),
          child: pw.Text(
            "Vestiários",
            style: pw.TextStyle(
              color: baseColor,
              fontWeight: pw.FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
      ],
    );
  }

  pw.Widget _contentTableVestiarios(pw.Context context) {
    const tableHeaders = [
      ' ID          ',
      'Texto',
      'Q                               ',
      'Situação                                       ',
    ];

    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(
        borderRadius: 2,
        color: baseColor,
      ),
      headerHeight: 25,
      cellHeight: 50,
      cellAlignments: {
        0: pw.Alignment.center,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
        4: pw.Alignment.centerLeft,
      },
      headerStyle: pw.TextStyle(
        color: _baseTextColor,
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: const pw.TextStyle(
        color: _darkColor,
        fontSize: 10,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.BoxBorder(
          bottom: true,
          color: accentColor,
          width: .5,
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        vestiariosList.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => vestiariosList[row].getIndex(col),
        ),
      ),
    );
  }

  pw.Widget _contentFooter(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 2,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                margin: const pw.EdgeInsets.only(top: 20, bottom: 8),
                child: pw.Text(
                  'Endereço',
                  style: pw.TextStyle(
                    color: baseColor,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Text(
                User.endereco,
                style: const pw.TextStyle(
                  fontSize: 8,
                  lineSpacing: 5,
                  color: _darkColor,
                ),
              ),
            ],
          ),
        ),
        pw.Expanded(
          flex: 1,
          child: pw.DefaultTextStyle(
            style: const pw.TextStyle(
              fontSize: 10,
              color: _darkColor,
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.SizedBox(height: 5),
                pw.Divider(color: accentColor),
                pw.DefaultTextStyle(
                  style: pw.TextStyle(
                    color: baseColor,
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  child: pw.Column(
                    children: [
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('Total:'),
                          pw.Text(_formatCurrency(valorAcessibilidade())),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('Máximo Total:'),
                          pw.Text(_formatCurrency(_maximoTotal())),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('Estado: '),
                          pw.Text(_requisitoDeAcessibilidade()),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  pw.Widget _termsAndConditions(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.BoxBorder(
                    top: true,
                    color: accentColor,
                  ),
                ),
                padding: const pw.EdgeInsets.only(top: 10, bottom: 4),
                child: pw.Text(
                  'Telefone',
                  style: pw.TextStyle(
                    fontSize: 12,
                    color: baseColor,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Text(
                User.telefone,
                textAlign: pw.TextAlign.justify,
                style: const pw.TextStyle(
                  fontSize: 6,
                  lineSpacing: 2,
                  color: _darkColor,
                ),
              ),
            ],
          ),
        ),
        pw.Expanded(
          child: pw.SizedBox(),
        ),
      ],
    );
  }
}

String _formatCurrency(double amount) {
  return '${amount.toStringAsFixed(2)}' + '%';
}

String _formatDate(DateTime date) {
  initializeDateFormatting('pt_BR');
  final format = DateFormat.yMMMMd('pt_BR');
  return format.format(date);
}
