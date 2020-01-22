import 'dart:async';

import 'package:flutter/material.dart';

class ChecklistCard extends StatelessWidget {
  final String text;

  ChecklistCard(
    this.text,
  );
   String _selectedRadio;
   final StreamController<String> _streamController = StreamController<String>();

  void _setSelectedRadio(String val) {
    _selectedRadio = val;
    _streamController.sink.add(_selectedRadio);
  }
  

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: _streamController.stream,
      builder: (context, snapshot) {
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
                      text,
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
    );
  }
}
