import 'package:flutter/material.dart';
import 'package:ifmaacessivel/src/shared/widgets/float_notification.dart';

class GridItem extends StatelessWidget {
  final IconData icon;
  final String categoria;

  const GridItem(
    this.icon,
    this.categoria,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => FloatNotification(),
        );
      },
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 25,
            child: Icon(
              icon,
              size: 20,
              color: Colors.white,
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            categoria,
            style: TextStyle(
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}
