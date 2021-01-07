import 'package:flutter/material.dart';

class MenuiButton extends StatelessWidget {
  final Color color;
  final String text;
  final IconData icon;
  final Function onPressed;

  MenuiButton(
      {@required this.color,
      @required this.icon,
      @required this.text,
      @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      splashColor: Colors.orange,
      color: Colors.grey[900],
      elevation: 0,
      padding: EdgeInsets.all(8),
      onPressed: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            icon,
            color: color,
          ),
          Text(
            text,
            style: TextStyle(
                color: Colors.grey[200],
                fontSize: 10,
                fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
