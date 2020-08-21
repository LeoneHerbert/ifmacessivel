import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FloatNotification extends StatelessWidget {
  final String texto;

  const FloatNotification(this.texto);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10),
              Text(texto),
            ],
          ),
        ),
      ),
    );
  }
}
