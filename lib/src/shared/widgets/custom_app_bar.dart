import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifmaacessivel/src/pages/home/home_page.dart';

class CustomAppBar extends StatelessWidget {
  final String name;
  final String url;

  const CustomAppBar(
    this.name,
    this.url,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(url),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    name,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(
                  Icons.home,
                  color: Theme.of(context).highlightColor,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
              )
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          TextField(
            decoration: InputDecoration(
              hintText: "Setores...",
              fillColor: Theme.of(context).highlightColor,
              filled: true,
              suffixIcon: Icon(
                Icons.filter_list,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            ),
          )
        ],
      ),
    );
  }
}
