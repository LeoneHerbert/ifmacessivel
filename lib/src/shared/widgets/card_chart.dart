import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardChart extends StatelessWidget {
  final String image;
  final String sector;
  final String subtitle;

  const CardChart(
      this.image,
      this.sector,
      this.subtitle
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: FlatButton(
          child: Row(
            children: <Widget>[
              Container(
                width: 100,
                height: 100,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    sector,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )
            ],
          ),
          onPressed: null
        ),
      ),
    );
  }
}
