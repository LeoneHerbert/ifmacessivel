import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardChecklist extends StatelessWidget {
  final String idDocument;
  final String id;
  final String text;
  final String situation;
  final double q;
  final String sector;

  CardChecklist(
      this.idDocument, this.id, this.text, this.situation, this.q, this.sector) {
    _selectedRadio = situation;
    _streamController.sink.add(_selectedRadio);
  }

  String _selectedRadio;
  final StreamController<String> _streamController = StreamController<String>();

  void _setSelectedRadio(String val) {
    _selectedRadio = val;
    _streamController.sink.add(_selectedRadio);
    Firestore.instance
        .collection("criterios_de_acessibilidade")
        .document(sector)
        .collection("itens")
        .document(idDocument)
        .setData(<String, dynamic>{
      "id": id,
      "texto": text,
      "situacao": _selectedRadio,
      "q": q
    });
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<String>(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          if (text == null) Text('Loading...');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            default:
              return Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 2.0,
                    )
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            id + ' - ' + text,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Radio(
                              value: "Sim",
                              groupValue: _selectedRadio,
                              activeColor: Colors.black,
                              onChanged: _setSelectedRadio,
                            ),
                            Text(
                              "Sim",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Radio(
                              value: "Não",
                              groupValue: _selectedRadio,
                              activeColor: Colors.black,
                              onChanged: _setSelectedRadio,
                            ),
                            Text(
                              "Não",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Radio(
                              value: "N/A",
                              groupValue: _selectedRadio,
                              activeColor: Colors.black,
                              onChanged: _setSelectedRadio,
                            ),
                            Text(
                              "N/A",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              );
          }
        });
  }
  void dispose(){
    _streamController.close();
  }
}
