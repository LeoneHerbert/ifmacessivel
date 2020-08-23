import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:ifmaacessivel/src/models/questionnaire.dart';
import 'package:ifmaacessivel/src/pages/pdf/sector_report/sector_report_page.dart';
import 'package:ifmaacessivel/src/pages/pdf/sector_report/sector_report_pdf.dart';

import 'package:ifmaacessivel/src/shared/widgets/card_checklist.dart';
import 'package:ifmaacessivel/src/shared/widgets/default_button.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class ChecklistPage extends StatefulWidget {
  String sector;

  ChecklistPage(String sector) {
    this.sector = sector;
  }

  @override
  _ChecklistPageState createState() => _ChecklistPageState(sector);
}

class _ChecklistPageState extends State<ChecklistPage> {
  final String sector;
  File image;
  List<Questionnaire> questionnaires = [];
  List<DocumentSnapshot> documents;

  _ChecklistPageState(this.sector);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Questionário"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection("criterios_de_acessibilidade")
            .document(sector)
            .collection("itens")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');
            default:
              documents = snapshot.data.documents;
              return ListView(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Column(
                      children: snapshot.data.documents
                          .map(
                            (document) => CardChecklist(
                                document.documentID,
                                document.data['id'],
                                document.data['texto'],
                                document.data['situacao'],
                                document.data['q'],
                                sector),
                          )
                          .toList(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: DefaultButton(
                      child: Text(
                        "Salvar",
                        style: TextStyle(
                          color: Theme.of(context).highlightColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        montaQuestionnaires();
                        SectorConfigurations.questionnaires = questionnaires;
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => SectorReportPage(),
                          ),
                        );
                      },
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
              image = await ImagePicker.pickImage(source: ImageSource.camera);
            },
          ),
          SpeedDialChild(
            child: Icon(
              Icons.photo_library,
            ),
            label: "Galeria",
            onTap: () async {
              image = await ImagePicker.pickImage(source: ImageSource.gallery);
            },
          )
        ],
      ),
    );
  }

  void montaQuestionnaires() {
    questionnaires = documents
        .map(
          (document) => Questionnaire(
            document.data['id'],
            document.data['texto'],
            document.data['q'],
            document.data['situacao'],
            sector,
            image,
          ),
        )
        .toList(growable: true);
  }
}
