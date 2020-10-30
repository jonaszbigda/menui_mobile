import 'package:flutter/material.dart';
import '../services.dart';

class LineOfIconsSmall extends StatelessWidget {
  final MenuiTags tags;

  LineOfIconsSmall({@required this.tags});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (tags.alcohol == true)
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
        if (tags.cardPayments == true)
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
        if (tags.delivery == true)
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
        if (tags.glutenFree == true)
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
        if (tags.petFriendly == true)
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
        if (tags.vegan == true)
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
        if (tags.vegetarian == true)
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
