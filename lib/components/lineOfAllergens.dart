import 'package:flutter/material.dart';
import '../services.dart';

class Allergens extends StatelessWidget {
  final MenuiAllergens allergens;
  final double edgeInsets = 4;
  final double imagesWidth = 16;
  final double fontSize = 9;
  final double maxWidth = 50;

  Allergens({@required this.allergens});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4.0,
      alignment: WrapAlignment.center,
      direction: Axis.horizontal,
      children: <Widget>[
        if (allergens.eggs == true)
          Container(
              margin: EdgeInsets.all(edgeInsets),
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_eggs.png',
                      width: imagesWidth,
                    ),
                    height: 26,
                  ),
                  Text(
                    'Jaja',
                    style:
                        TextStyle(fontSize: fontSize, color: Colors.grey[300]),
                  )
                ],
              )),
        if (allergens.gluten == true)
          Container(
              margin: EdgeInsets.all(edgeInsets),
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_gluten.png',
                      width: imagesWidth,
                    ),
                    height: 26,
                  ),
                  Text(
                    'Gluten',
                    style:
                        TextStyle(fontSize: fontSize, color: Colors.grey[300]),
                  )
                ],
              )),
        if (allergens.lactose == true)
          Container(
              margin: EdgeInsets.all(edgeInsets),
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_lactose.png',
                      width: imagesWidth,
                    ),
                    height: 26,
                  ),
                  Text(
                    'Laktoza',
                    style:
                        TextStyle(fontSize: fontSize, color: Colors.grey[300]),
                  )
                ],
              )),
        if (allergens.peanuts == true)
          Container(
              margin: EdgeInsets.all(edgeInsets),
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_peanuts.png',
                      width: imagesWidth,
                    ),
                    height: 26,
                  ),
                  Text(
                    'Orzechy',
                    style:
                        TextStyle(fontSize: fontSize, color: Colors.grey[300]),
                  )
                ],
              )),
        if (allergens.seaFood == true)
          Container(
              margin: EdgeInsets.all(edgeInsets),
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_seaFood.png',
                      width: imagesWidth,
                    ),
                    height: 26,
                  ),
                  Text(
                    'Owoce morza',
                    style:
                        TextStyle(fontSize: fontSize, color: Colors.grey[300]),
                  )
                ],
              )),
        if (allergens.sesame == true)
          Container(
              margin: EdgeInsets.all(edgeInsets),
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_sesame.png',
                      width: imagesWidth,
                    ),
                    height: 26,
                  ),
                  Text(
                    'Sezam',
                    style:
                        TextStyle(fontSize: fontSize, color: Colors.grey[300]),
                  )
                ],
              )),
        if (allergens.soy == true)
          Container(
              margin: EdgeInsets.all(edgeInsets),
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_soy.png',
                      width: imagesWidth,
                    ),
                    height: 26,
                  ),
                  Text(
                    'Soja',
                    style:
                        TextStyle(fontSize: fontSize, color: Colors.grey[300]),
                  )
                ],
              )),
      ],
    );
  }
}
