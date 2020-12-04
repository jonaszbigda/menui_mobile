import 'package:flutter/material.dart';
import 'package:menui_mobile/services.dart';
import 'lineOfAllergens.dart';

class DishView extends StatelessWidget {
  final Dish dish;
  DishView({@required this.dish});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.grey[850]),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      dish.imgUrl,
                    ),
                    fit: BoxFit.cover),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 160,
                    width: double.infinity,
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          dish.name,
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.orange,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.all(12),
                  )
                ],
              ),
            ),
            SizedBox(height: 8),
            Allergens(allergens: dish.allergens),
            Divider(
              height: 14,
              thickness: 4,
            ),
            Text(
              'Cena',
              style: TextStyle(color: Colors.orange, fontSize: 14),
            ),
            SizedBox(
              height: 12,
            ),
            Prices(prices: dish.prices),
            SizedBox(
              height: 12,
            ),
            Divider(
              height: 14,
              thickness: 4,
            ),
            Text(
              'Składniki',
              style: TextStyle(color: Colors.orange, fontSize: 14),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              '${dish.ingredients}',
              style: TextStyle(color: Colors.grey[200], fontSize: 12),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              'Porcja',
              style: TextStyle(color: Colors.orange, fontSize: 14),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              '${dish.weight}',
              style: TextStyle(color: Colors.grey[200], fontSize: 12),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              'Wartość energetyczna',
              style: TextStyle(color: Colors.orange, fontSize: 14),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              '${dish.kCal}',
              style: TextStyle(color: Colors.grey[200], fontSize: 12),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              'Indeks glikemiczny',
              style: TextStyle(color: Colors.orange, fontSize: 14),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              '${dish.glicemicIndex}',
              style: TextStyle(color: Colors.grey[200], fontSize: 12),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              'Uwagi',
              style: TextStyle(color: Colors.orange, fontSize: 14),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              '${dish.notes}',
              style: TextStyle(color: Colors.grey[200], fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class Prices extends StatelessWidget {
  final MenuiPrices prices;

  Prices({@required this.prices});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        if (prices.price1.priceName == "")
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.attach_money,
                    color: Colors.orange,
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${prices.price1.price} zł',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ]),
          ),
        if (prices.price1.priceName != "")
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.attach_money,
                    color: Colors.orange,
                  ),
                  SizedBox(height: 8),
                  Text(
                    '(${prices.price1.priceName})',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                  Text(
                    '${prices.price1.price} zł',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ]),
          ),
        if (prices.price2.priceName != "")
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.attach_money,
                    color: Colors.orange,
                  ),
                  SizedBox(height: 8),
                  Text(
                    '(${prices.price2.priceName})',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                  Text(
                    '${prices.price2.price} zł',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ]),
          ),
        if (prices.price3.priceName != "")
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.attach_money,
                    color: Colors.orange,
                  ),
                  SizedBox(height: 8),
                  Text(
                    '(${prices.price3.priceName})',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                  Text(
                    '${prices.price3.price} zł',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ]),
          ),
      ],
    );
  }
}
