import 'package:flutter/material.dart';
import '../services.dart';

class LineOfIcons extends StatelessWidget {
  final MenuiTags tags;

  LineOfIcons({@required this.tags});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (tags.alcohol == true)
          Container(
              margin: EdgeInsets.all(8),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_alcohol.png',
                      width: 20,
                    ),
                    height: 30,
                  ),
                  Text(
                    'Alkohol',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  )
                ],
              )),
        if (tags.cardPayments == true)
          Container(
              margin: EdgeInsets.all(8),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_card.png',
                      width: 20,
                    ),
                    height: 30,
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
              margin: EdgeInsets.all(8),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_delivery.png',
                      width: 20,
                    ),
                    height: 30,
                  ),
                  Text(
                    'Dowozimy',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  )
                ],
              )),
        if (tags.glutenFree == true)
          Container(
              margin: EdgeInsets.all(8),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_glutenFree.png',
                      width: 20,
                    ),
                    height: 30,
                  ),
                  Text(
                    'Bezglutenowe',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  )
                ],
              )),
        if (tags.petFriendly == true)
          Container(
              margin: EdgeInsets.all(8),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_pets.png',
                      width: 20,
                    ),
                    height: 30,
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
              margin: EdgeInsets.all(8),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_vegan.png',
                      width: 20,
                    ),
                    height: 30,
                  ),
                  Text(
                    'Wegańskie',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  )
                ],
              )),
        if (tags.vegetarian == true)
          Container(
              margin: EdgeInsets.all(8),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_vegetarian.png',
                      width: 20,
                    ),
                    height: 30,
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
