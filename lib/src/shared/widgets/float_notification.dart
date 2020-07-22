import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FloatNotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Notifição",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text("Novo E-mail!")
            ],
          ),
        ),
      ),
    );
  }
}
