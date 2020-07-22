import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> generateEscada(PdfPageFormat pageFormat) async {
  final lorem = pw.LoremText();

  final questionarios = <Questionario>[
    Questionario('1', 'Possui faixa livre para pedestre com largura mínima de 1,50m, sendo admissível 1,20m?', 0.4,'Não'),
    Questionario('2', 'A inclinação transversal é de, no máximo, 3%?', 0.4, 'Não'),
    Questionario('3', 'É nivelada com os lotes vizinhos?', 0.4, 'Não'),
    Questionario('4', 'Os desníveis entre o lote e o nível da calçada são vencidos sempre no interior do lote?', 0.4, 'Não'),
    Questionario('5', 'O nível da calçada respeita sempre o meio-fio instalado, sem sobreposição de piso ou descaracterização deste nível?', 0.4, 'Não'),
    Questionario('6', 'A inclinação longitudinal da calçada acompanha sempre o greide da via?', 0.4, 'Não'),
    Questionario('7', 'Os lotes e edificações localizam-se em ruas cuja inclinação da via é menor que 14%?', 0.4, 'Não'),
    Questionario('8', 'Na ausência da linha guia (estacionamento, acessos, etc) existe sinalização com piso tátil (recomendado o direcional) para balizamento das pessoas com deficiência visual?', 0.4, 'Não'),
    Questionario('9', 'Obstáculos aéreos, como marquises, placas, toldos e vegetação estão localizados a uma altura superior a 2.10m?', 0.4, 'Não'),
    Questionario('10', 'É livre de obstáculos no piso que comprometa a rota acessível?', 0.4, 'Não'),
  ];

  final escada = Escada(
    questionarios: questionarios,
    baseColor: PdfColors.blue500,
    accentColor: PdfColors.blue500,
  );

  return await escada.buildPdf(pageFormat);
}

class Escada {
  Escada({
    this.questionarios,
    this.baseColor,
    this.accentColor,
  });

  final List<Questionario> questionarios;
  final PdfColor baseColor;
  final PdfColor accentColor;

  static const _darkColor = PdfColors.blueGrey800;
  static const _lightColor = PdfColors.white;

  PdfColor get _baseTextColor =>
      baseColor.luminance < 0.5 ? _lightColor : _darkColor;

  PdfColor get _accentTextColor =>
      baseColor.luminance < 0.5 ? _lightColor : _darkColor;

  double get _total =>
      questionarios.map<double>((p) => p.q).reduce((a, b) => a + b);

  double get _grandTotal => _total;

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
          _contentHeader(context),
          _contentTable(context),
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
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Text(
                      'ACESSIBILIDADE',
                      style: pw.TextStyle(
                        color: baseColor,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ),
                  pw.Container(
                    decoration: pw.BoxDecoration(
                      borderRadius: 2,
                      color: accentColor,
                    ),
                    padding: const pw.EdgeInsets.only(
                        left: 10, top: 10, bottom: 10, right: 10),
                    alignment: pw.Alignment.centerLeft,
                    height: 50,
                    child: pw.DefaultTextStyle(
                      style: pw.TextStyle(
                        color: _accentTextColor,
                        fontSize: 12,
                      ),
                      child: pw.GridView(
                        crossAxisCount: 2,
                        children: [
                          pw.Text('Campus:'),
                          pw.Text('Monte Castelo'),
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

  pw.Widget _contentHeader(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          child: pw.Container(
            margin: const pw.EdgeInsets.symmetric(horizontal: 100),
            height: 70,
            child: pw.FittedBox(
              child: pw.Text(
                'Questionário Escada',
                style: pw.TextStyle(
                  color: baseColor,
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ],
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
                'Av. Getúlio Vargas, 04 - Monte Castelo, São Luís - MA, 65030-005',
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
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Total:'),
                      pw.Text(_formatCurrency(_grandTotal)),
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
                '(98) 3261-9800',
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

  pw.Widget _contentTable(pw.Context context) {
    const tableHeaders = [
      'ID      ',
      'Texto',
      'Q        ',
      'Situação                     ',
    ];

    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(
        borderRadius: 2,
        color: baseColor,
      ),
      headerHeight: 25,
      cellHeight: 40,
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
        questionarios.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => questionarios[row].getIndex(col),
        ),
      ),
    );
  }
}

String _formatCurrency(double amount) {
  return '${amount.toStringAsFixed(2)}';
}

String _formatDate(DateTime date) {
  initializeDateFormatting('pt_BR');
  final format = DateFormat.yMMMMd('pt_BR');
  return format.format(date);
}

class Questionario {
  const Questionario(
    this.id,
    this.texto,
    this.q,
    this.situacao,
  );

  final String id;
  final String texto;
  final double q;
  final String situacao;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return id;
      case 1:
        return texto;
      case 2:
        return _formatCurrency(q);
      case 3:
        return situacao;
    }
    return '';
  }
}
