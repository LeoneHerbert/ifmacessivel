import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;

  const DefaultButton({Key key, this.onPressed, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: FlatButton(
        child: this.child,
        onPressed: this.onPressed,
        disabledColor: Colors.grey,
      ),
    );
  }
}
