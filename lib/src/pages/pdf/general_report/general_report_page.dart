import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'general_report_pdf.dart';

class GeneralReportPage extends StatefulWidget {

  @override
  GeneralReportPageState createState() {
    return GeneralReportPageState();
  }
}

class GeneralReportPageState extends State<GeneralReportPage> with SingleTickerProviderStateMixin {
  List<Tab> _myTabs;
  List<LayoutCallback> _tabGen;
  int _tab = 0;
  TabController _tabController;

  PrintingInfo printingInfo;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final PrintingInfo info = await Printing.info();

    _myTabs = const <Tab>[
      Tab(text: 'RELATÓRIO GERAL'),
    ];
    _tabGen = const <LayoutCallback>[
      generateGeneralReport,
    ];

    _tabController = TabController(
      vsync: this,
      length: _myTabs.length,
      initialIndex: _tab,
    );
    _tabController.addListener(() {
      setState(() {
        _tab = _tabController.index;
      });
    });

    setState(() {
      printingInfo = info;
    });
  }

  void _showPrintedToast(BuildContext context) {
    final ScaffoldState scaffold = Scaffold.of(context);

    scaffold.showSnackBar(
      const SnackBar(
        content: Text('Documento impresso com sucesso!'),
      ),
    );
  }

  void _showSharedToast(BuildContext context) {
    final ScaffoldState scaffold = Scaffold.of(context);

    scaffold.showSnackBar(
      const SnackBar(
        content: Text('Documento compartilhado com sucesso!'),
      ),
    );
  }

  Future<void> _saveAsFile(
      BuildContext context,
      LayoutCallback build,
      PdfPageFormat pageFormat,
      ) async {
    final Uint8List bytes = await build(pageFormat);

    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String appDocPath = appDocDir.path;
    final File file = File(appDocPath + '/' + 'questionario_de_acessibilidade.pdf');
    print('Save as file ${file.path} ...');
    await file.writeAsBytes(bytes);
    OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    pw.RichText.debug = true;

    if (_tabController == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final actions = <PdfPreviewAction>[
      if (!kIsWeb)
        PdfPreviewAction(
          icon: const Icon(Icons.save),
          onPressed: _saveAsFile,
        )
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Critérios de Acessibilidade'),
        centerTitle: true,
        leading: IconButton(icon:Icon(Icons.arrow_back),
          //onPressed:() => Navigator.pop(context, false),
          onPressed:() => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: _myTabs,
        ),
      ),
      body: PdfPreview(
        maxPageWidth: 700,
        build: _tabGen[_tab],
        actions: actions,
        onPrinted: _showPrintedToast,
        onShared: _showSharedToast,
      ),
    );
  }
}