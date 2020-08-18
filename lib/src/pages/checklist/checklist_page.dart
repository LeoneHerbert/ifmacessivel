import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:ifmaacessivel/src/models/questionario.dart';
import 'package:ifmaacessivel/src/pages/pdf/relatorio_setor/setor_pdf.dart';
import 'package:ifmaacessivel/src/pages/pdf/relatorio_setor/main_pdf.dart';
import 'package:ifmaacessivel/src/shared/widgets/checklist_card.dart';
import 'package:ifmaacessivel/src/shared/widgets/default_button.dart';
import 'package:ifmaacessivel/src/shared/widgets/float_notification.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class ChecklistPage extends StatefulWidget {
  String setor;

  ChecklistPage(String setor) {
    this.setor = setor;
  }

  @override
  _ChecklistPageState createState() => _ChecklistPageState(setor);
}

class _ChecklistPageState extends State<ChecklistPage> {
  final String setor;
  File image;
  List<Questionario> questionarios = [];
  List<DocumentSnapshot> documents;

  _ChecklistPageState(this.setor);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Questionário"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection("criterios_de_acessibilidade")
            .document(setor)
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
                            (document) => ChecklistCard(
                                document.documentID,
                                document.data['id'],
                                document.data['texto'],
                                document.data['situacao'],
                                document.data['q'],
                                setor),
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
                        montaQuestionarios();
                        SetorConfiguracoes.questionarios = questionarios;
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => MainPDF(),
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

  void montaQuestionarios() {
    questionarios = documents
        .map(
          (document) => Questionario(
            document.data['id'],
            document.data['texto'],
            document.data['q'],
            document.data['situacao'],
            setor,
            image,
          ),
        )
        .toList(growable: true);
  }
}
