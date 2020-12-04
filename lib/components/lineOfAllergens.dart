import 'package:flutter/material.dart';
import '../services.dart';

class Allergens extends StatelessWidget {
  final MenuiAllergens allergens;
  final double edgeInsets = 6;

  Allergens({@required this.allergens});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (allergens.eggs == true)
          Container(
              margin: EdgeInsets.all(edgeInsets),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_eggs.png',
                      width: 18,
                    ),
                    height: 26,
                  ),
                  Text(
                    'Jaja',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  )
                ],
              )),
        if (allergens.gluten == true)
          Container(
              margin: EdgeInsets.all(edgeInsets),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_gluten.png',
                      width: 18,
                    ),
                    height: 26,
                  ),
                  Text(
                    'Gluten',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  )
                ],
              )),
        if (allergens.lactose == true)
          Container(
              margin: EdgeInsets.all(edgeInsets),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_lactose.png',
                      width: 18,
                    ),
                    height: 26,
                  ),
                  Text(
                    'Laktoza',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  )
                ],
              )),
        if (allergens.peanuts == true)
          Container(
              margin: EdgeInsets.all(edgeInsets),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_peanuts.png',
                      width: 18,
                    ),
                    height: 26,
                  ),
                  Text(
                    'Orzechy',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  )
                ],
              )),
        if (allergens.seaFood == true)
          Container(
              margin: EdgeInsets.all(edgeInsets),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_seaFood.png',
                      width: 18,
                    ),
                    height: 26,
                  ),
                  Text(
                    'Owoce morza',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  )
                ],
              )),
        if (allergens.sesame == true)
          Container(
              margin: EdgeInsets.all(edgeInsets),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_sesame.png',
                      width: 18,
                    ),
                    height: 26,
                  ),
                  Text(
                    'Sezam',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  )
                ],
              )),
        if (allergens.soy == true)
          Container(
              margin: EdgeInsets.all(edgeInsets),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'img/i_soy.png',
                      width: 18,
                    ),
                    height: 26,
                  ),
                  Text(
                    'Soja',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  )
                ],
              )),
      ],
    );
  }
}
