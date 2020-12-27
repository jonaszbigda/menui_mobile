import 'package:flutter/material.dart';
import '../services.dart';

class LineOfIcons extends StatelessWidget {
  final MenuiTags tags;
  final double edgeInsets = 4;
  final double imagesWidth = 16;
  final double fontSize = 9;
  final double maxWidth = 50;

  LineOfIcons({@required this.tags});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4.0,
      alignment: WrapAlignment.center,
      direction: Axis.horizontal,
      children: <Widget>[
        if (tags.alcohol == true)
          Container(
              margin: EdgeInsets.all(edgeInsets),
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_alcohol.png',
                      width: imagesWidth,
                    ),
                    height: 26,
                  ),
                  Text(
                    'Alkohol',
                    style:
                        TextStyle(fontSize: fontSize, color: Colors.grey[300]),
                  )
                ],
              )),
        if (tags.cardPayments == true)
          Container(
              margin: EdgeInsets.all(edgeInsets),
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    width: maxWidth,
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_card.png',
                      width: imagesWidth,
                    ),
                    height: 26,
                  ),
                  Text(
                    'Płatność',
                    style:
                        TextStyle(fontSize: fontSize, color: Colors.grey[300]),
                  ),
                  Text(
                    'kartą',
                    style:
                        TextStyle(fontSize: fontSize, color: Colors.grey[300]),
                  )
                ],
              )),
        if (tags.delivery == true)
          Container(
              margin: EdgeInsets.all(edgeInsets),
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_delivery.png',
                      width: imagesWidth,
                    ),
                    height: 26,
                  ),
                  Text(
                    'Dowozimy',
                    style:
                        TextStyle(fontSize: fontSize, color: Colors.grey[300]),
                  )
                ],
              )),
        if (tags.glutenFree == true)
          Container(
              margin: EdgeInsets.all(edgeInsets),
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_glutenFree.png',
                      width: imagesWidth,
                    ),
                    height: 26,
                  ),
                  Text(
                    'Bezglutenowe',
                    style:
                        TextStyle(fontSize: fontSize, color: Colors.grey[300]),
                  )
                ],
              )),
        if (tags.petFriendly == true)
          Container(
              margin: EdgeInsets.all(edgeInsets),
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_pets.png',
                      width: imagesWidth,
                    ),
                    height: 26,
                  ),
                  Text(
                    'Lubimy',
                    style:
                        TextStyle(fontSize: fontSize, color: Colors.grey[300]),
                  ),
                  Text(
                    'zwierzaczki',
                    style:
                        TextStyle(fontSize: fontSize, color: Colors.grey[300]),
                  )
                ],
              )),
        if (tags.vegan == true)
          Container(
              margin: EdgeInsets.all(edgeInsets),
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_vegan.png',
                      width: imagesWidth,
                    ),
                    height: 26,
                  ),
                  Text(
                    'Wegańskie',
                    style:
                        TextStyle(fontSize: fontSize, color: Colors.grey[300]),
                  )
                ],
              )),
        if (tags.vegetarian == true)
          Container(
              margin: EdgeInsets.all(edgeInsets),
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_vegetarian.png',
                      width: imagesWidth,
                    ),
                    height: 26,
                  ),
                  Text(
                    'Wegetariańskie',
                    style:
                        TextStyle(fontSize: fontSize, color: Colors.grey[300]),
                  )
                ],
              )),
      ],
    );
  }
}
