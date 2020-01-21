import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FloatPage extends StatelessWidget {
  final String titulo;
  final String input1;
  final String input2;
  final String input3;
  final int minLinesThirdInput;
  final int maxLinesThirdInput;

  FloatPage(
    this.titulo,
    this.input1,
    this.input2,
    this.input3,
    this.minLinesThirdInput,
    this.maxLinesThirdInput,
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        height: MediaQuery.of(context).size.height / 2,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                this.titulo,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: this.input1,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 5.0,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: this.input2,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 5.0,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
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
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
