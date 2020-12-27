import 'package:flutter/material.dart';

class IconChip extends StatelessWidget {
  final IconData icon;
  final String leading;
  final String value;

  IconChip({@required this.icon, @required this.leading, @required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.orange,
            ),
            SizedBox(height: 8),
            Text(
              '$leading',
              style: TextStyle(color: Colors.grey[300], fontSize: 11),
            ),
            SizedBox(height: 4),
            if (value == "")
              Text(
                '-',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            if (value != "")
              Text(
                '$value',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
          ]),
    );
  }
}
