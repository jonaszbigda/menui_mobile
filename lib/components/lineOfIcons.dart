import 'package:flutter/material.dart';
import 'filters.dart';

class LineOfIcons extends StatelessWidget {
  final List<Tags> tags;
  final double edgeInsets = 3;
  final double imagesWidth = 14;
  final double fontSize = 8;
  final double maxWidth = 40;

  LineOfIcons({@required this.tags});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 2.0,
      alignment: WrapAlignment.center,
      direction: Axis.horizontal,
      children: <Widget>[
        if (tags.contains(Tags.alcohol))
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
        if (tags.contains(Tags.cardPayments))
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
        if (tags.contains(Tags.delivery))
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
        if (tags.contains(Tags.glutenFree))
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
        if (tags.contains(Tags.petFriendly))
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
        if (tags.contains(Tags.vegan))
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
        if (tags.contains(Tags.vegetarian))
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
