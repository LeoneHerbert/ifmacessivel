import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChecklistCard extends StatelessWidget {
  final String idDocument;
  final String id;
  final String texto;
  final String situacao;
  final double q;
  final String setor;

  ChecklistCard(
    this.idDocument, this.id, this.texto, this.situacao, this.q, this.setor
  ){
    _selectedRadio = situacao;
    _streamController.sink.add(_selectedRadio);
  }
   String _selectedRadio;
   final StreamController<String> _streamController = StreamController<String>();



  void _setSelectedRadio(String val) {
    _selectedRadio = val;
    _streamController.sink.add(_selectedRadio);
    Firestore.instance
        .collection("criterios_de_acessibilidade")
        .document(setor)
        .collection("itens").document(idDocument).setData(<String, dynamic>{
          "id": id,
          "texto": texto,
          "situacao": _selectedRadio,
           "q": q
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: _streamController.stream,
      builder: (context, snapshot) {
        if (texto == null) ;
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
                          id + ' - ' + texto,
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
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
                            style: TextStyle(color: Colors.black, fontSize: 18),
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
                            style: TextStyle(color: Colors.black, fontSize: 18),
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
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            );
        }
      }
    );
  }
}
