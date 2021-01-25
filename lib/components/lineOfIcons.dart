import 'package:flutter/material.dart';
import 'filters.dart';
import 'package:menui_mobile/localizations.dart';

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
                    AppLocalizations.instance.text('alcohol'),
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
                    AppLocalizations.instance.text('cardPayments1'),
                    style:
                        TextStyle(fontSize: fontSize, color: Colors.grey[300]),
                  ),
                  Text(
                    AppLocalizations.instance.text('cardPayments2'),
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
                    AppLocalizations.instance.text('delivery'),
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
                    AppLocalizations.instance.text('glutenFree'),
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
                    AppLocalizations.instance.text('pets1'),
                    style:
                        TextStyle(fontSize: fontSize, color: Colors.grey[300]),
                  ),
                  Text(
                    AppLocalizations.instance.text('pets2'),
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
                    AppLocalizations.instance.text('vegan'),
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
                    AppLocalizations.instance.text('vegetarian'),
                    style:
                        TextStyle(fontSize: fontSize, color: Colors.grey[300]),
                  )
                ],
              )),
      ],
    );
  }
}
