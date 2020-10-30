import 'package:flutter/material.dart';
import '../services.dart';

class LineOfIcons extends StatelessWidget {
  final MenuiTags tags;
  final double edgeInsets = 6;

  LineOfIcons({@required this.tags});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (tags.alcohol == true)
          Container(
              margin: EdgeInsets.all(edgeInsets),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_alcohol.png',
                      width: 18,
                    ),
                    height: 26,
                  ),
                  Text(
                    'Alkohol',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  )
                ],
              )),
        if (tags.cardPayments == true)
          Container(
              margin: EdgeInsets.all(edgeInsets),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_card.png',
                      width: 18,
                    ),
                    height: 26,
                  ),
                  Text(
                    'Płatność',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  Text(
                    'kartą',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  )
                ],
              )),
        if (tags.delivery == true)
          Container(
              margin: EdgeInsets.all(edgeInsets),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_delivery.png',
                      width: 18,
                    ),
                    height: 26,
                  ),
                  Text(
                    'Dowozimy',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  )
                ],
              )),
        if (tags.glutenFree == true)
          Container(
              margin: EdgeInsets.all(edgeInsets),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_glutenFree.png',
                      width: 18,
                    ),
                    height: 26,
                  ),
                  Text(
                    'Bezglutenowe',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  )
                ],
              )),
        if (tags.petFriendly == true)
          Container(
              margin: EdgeInsets.all(edgeInsets),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_pets.png',
                      width: 18,
                    ),
                    height: 26,
                  ),
                  Text(
                    'Lubimy',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  Text(
                    'zwierzaczki',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  )
                ],
              )),
        if (tags.vegan == true)
          Container(
              margin: EdgeInsets.all(edgeInsets),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_vegan.png',
                      width: 18,
                    ),
                    height: 26,
                  ),
                  Text(
                    'Wegańskie',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  )
                ],
              )),
        if (tags.vegetarian == true)
          Container(
              margin: EdgeInsets.all(edgeInsets),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_vegetarian.png',
                      width: 18,
                    ),
                    height: 26,
                  ),
                  Text(
                    'Wegetariańskie',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  )
                ],
              )),
      ],
    );
  }
}
