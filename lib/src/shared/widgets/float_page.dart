import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifmaacessivel/src/pages/checklist/checklist_module.dart';

class FloatPage extends StatelessWidget {
  final StreamController<String> _streamController = StreamController<String>();
  final List<DropdownMenuItem<String>> dropDownMenuItems;
  String _statusSel;

  FloatPage(this.dropDownMenuItems) {
    _statusSel = dropDownMenuItems[0].value;
  }

  void changedDropDownItem(String selectedItem) {
    _statusSel = selectedItem;
    _streamController.sink.add(_statusSel);
    print(_statusSel);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        height: MediaQuery.of(context).size.height / 3,
        child: SingleChildScrollView(
          child: StreamBuilder<String>(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Setor',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  new DropdownButton(
                    style: new TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    value: _statusSel,
                    items: dropDownMenuItems,
                    onChanged: changedDropDownItem,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          left: 30,
                          right: 20,
                        ),
                        child: RaisedButton(
                          child: Text(
                            "Cancelar",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          child: Text(
                            "Confirmar",
                            style: TextStyle(
                              color: Theme.of(context).highlightColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => new ChecklistModule(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
