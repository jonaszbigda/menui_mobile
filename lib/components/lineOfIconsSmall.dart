import 'package:flutter/material.dart';
import 'filters.dart';

class LineOfIconsSmall extends StatelessWidget {
  final List<Tags> tags;

  LineOfIconsSmall({@required this.tags});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (tags.contains(Tags.alcohol))
          Container(
              margin: EdgeInsets.only(top: 4, bottom: 4, right: 9),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_alcohol.png',
                      width: 14,
                    ),
                    height: 14,
                  ),
                ],
              )),
        if (tags.contains(Tags.cardPayments))
          Container(
              margin: EdgeInsets.only(top: 4, bottom: 4, right: 9),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_card.png',
                      width: 14,
                    ),
                    height: 14,
                  ),
                ],
              )),
        if (tags.contains(Tags.delivery))
          Container(
              margin: EdgeInsets.only(top: 4, bottom: 4, right: 9),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_delivery.png',
                      width: 14,
                    ),
                    height: 14,
                  ),
                ],
              )),
        if (tags.contains(Tags.glutenFree))
          Container(
              margin: EdgeInsets.only(top: 4, bottom: 4, right: 9),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_glutenFree.png',
                      width: 14,
                    ),
                    height: 14,
                  ),
                ],
              )),
        if (tags.contains(Tags.petFriendly))
          Container(
              margin: EdgeInsets.only(top: 4, bottom: 4, right: 9),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_pets.png',
                      width: 14,
                    ),
                    height: 14,
                  ),
                ],
              )),
        if (tags.contains(Tags.vegan))
          Container(
              margin: EdgeInsets.only(top: 4, bottom: 4, right: 9),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_vegan.png',
                      width: 14,
                    ),
                    height: 14,
                  ),
                ],
              )),
        if (tags.contains(Tags.vegetarian))
          Container(
              margin: EdgeInsets.only(top: 4, bottom: 4, right: 9),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_vegetarian.png',
                      width: 14,
                    ),
                    height: 14,
                  ),
                ],
              )),
      ],
    );
  }
}
