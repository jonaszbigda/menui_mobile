import 'package:flutter/material.dart';
import 'package:menui_mobile/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialMedia extends StatelessWidget {
  final MenuiLinks links;
  SocialMedia({@required this.links});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (links.facebook != "")
          IconButton(
              icon: FaIcon(
                FontAwesomeIcons.facebook,
                color: Colors.white,
              ),
              onPressed: () {
                print(links.facebook);
              }),
        if (links.instagram != "")
          IconButton(
              icon: FaIcon(
                FontAwesomeIcons.instagram,
                color: Colors.white,
              ),
              onPressed: () {
                print(links.instagram);
              }),
        if (links.www != "")
          IconButton(
              icon: FaIcon(
                FontAwesomeIcons.globe,
                color: Colors.white,
              ),
              onPressed: () {
                print(links.www);
              })
      ],
    );
  }
}
