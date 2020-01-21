import 'package:flutter/material.dart';

class ChecklistCard extends StatelessWidget {
  final String text;
  final int selectedRadio;
  final Function setSelectedRadio;

  const ChecklistCard(
    this.text,
    this.selectedRadio,
    this.setSelectedRadio,
  );

  @override
  Widget build(BuildContext context) {
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
                    value: 1,
                    groupValue: selectedRadio,
                    activeColor: Colors.black,
                    onChanged: setSelectedRadio,
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
                    value: 2,
                    groupValue: selectedRadio,
                    activeColor: Colors.black,
                    onChanged: setSelectedRadio,
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
                    value: 3,
                    groupValue: selectedRadio,
                    activeColor: Colors.black,
                    onChanged: setSelectedRadio,
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
