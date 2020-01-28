import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:ifmaacessivel/src/shared/widgets/checklist_card.dart';
import 'package:ifmaacessivel/src/shared/widgets/default_button.dart';
import 'package:ifmaacessivel/src/shared/widgets/pdf_viewer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pdfLib;

class ChecklistPage extends StatefulWidget {
  @override
  _ChecklistPageState createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  //final _CheckclistBloc = ChecklistModule.to.getBloc<ChecklistBloc>();
  int _selectedRadio;
  String _path = '...';
  String _extension;
  bool _hasValidMime = false;
  final pdfLib.Document pdf = pdfLib.Document(deflate: zlib.encode);
  var lista = ["11", "22", "33", "Oi"];

  @override
  void initState() {
    _selectedRadio = 0;
    super.initState();
  }

  void _setSelectedRadio(int val) {
    setState(() {
      _selectedRadio = val;
    });
  }

  _generatePdfAndView() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    final File file = File(appDocPath + "teste.pdf");
    file.writeAsBytes(pdf.save());

    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (_) => new PdfViewerPage(
          path: appDocPath + "teste.pdf",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CheckList"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection("criterios_de_acessibilidade")
            .document("calcada")
            .collection("geral")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');
            default:
              pdf.addPage(
                pdfLib.MultiPage(
                  build: (context) => [
                    pdfLib.Table.fromTextArray(
                      context: context,
                      data: <List<String>>[
                        <String>[
                          'DESCRIÇÃO  DE  ACORDO  COM  A NORMA  TÉCNICA/LEGISLAÇÃO',
                          'Q',
                          'SITUAÇÃO'
                        ],
                        ...snapshot.data.documents.map((item) =>
                            [item.data['texto'], item.data['q'], item.data['situacao']])
                      ],
                    ),
                  ],
                ),
              );

              return ListView(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Column(
                      children: snapshot.data.documents
                          .map(
                            (document) => ChecklistCard(
                              document.data['texto'],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: DefaultButton(
                      child: Text(
                        "Enviar",
                        style: TextStyle(
                          color: Theme.of(context).highlightColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: _generatePdfAndView,
                    ),
                  )
                ],
              );
          }
        },
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.view_list,
        backgroundColor: Theme.of(context).primaryColor,
        children: [
          SpeedDialChild(
            child: Icon(
              Icons.photo_camera,
            ),
            label: "Câmera",
            onTap: () async {
              final File image =
                  await ImagePicker.pickImage(source: ImageSource.camera);
            },
          ),
          SpeedDialChild(
            child: Icon(
              Icons.photo_library,
            ),
            label: "Galeria",
            onTap: () async {
              final File image =
                  await ImagePicker.pickImage(source: ImageSource.gallery);
            },
          )
        ],
      ),
    );
  }
}
