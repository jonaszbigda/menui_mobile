import 'package:flutter/material.dart';
import 'package:menui_mobile/services.dart';
import 'lineOfAllergens.dart';
import 'iconChip.dart';
import 'orderView.dart';
import 'favoritesView.dart';
import '../settings.dart';
import 'homeScreen.dart';
import 'package:share/share.dart';
import 'menuiButton.dart';

class DishView extends StatelessWidget {
  final Dish dish;
  DishView({@required this.dish});
  final MenuiSettings settings = new MenuiSettings();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(color: Colors.grey[850]),
          child: ListView(
            children: <Widget>[
              Column(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 160,
                          width: double.infinity,
                        ),
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.restaurant,
                                color: Colors.orange,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                dish.name,
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                          margin: EdgeInsets.all(12),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  if (dish.allergens.hasAllergens()) SizedBox(height: 8),
                  if (dish.allergens.hasAllergens())
                    Text(
                      'Może zawierać',
                      style: TextStyle(color: Colors.orange, fontSize: 14),
                    ),
                  Allergens(allergens: dish.allergens),
                  if (dish.allergens.hasAllergens())
                    Divider(
                      height: 14,
                      thickness: 4,
                    ),
                  SizedBox(
                    height: 8,
                  ),
                  Prices(prices: dish.prices),
                  SizedBox(
                    height: 8,
                  ),
                  Divider(
                    height: 14,
                    thickness: 4,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    'Składniki',
                    style: TextStyle(color: Colors.orange, fontSize: 14),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      '${dish.ingredients}',
                      style: TextStyle(color: Colors.grey[200], fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Divider(
                    height: 14,
                    thickness: 4,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Wrap(
                    spacing: 10,
                    children: <Widget>[
                      IconChip(
                          icon: Icons.battery_charging_full,
                          leading: "Wartość energetyczna",
                          value: (() {
                            if (dish.kCal != "") {
                              return dish.kCal + " kcal";
                            } else {
                              return "";
                            }
                          }())),
                      IconChip(
                          icon: Icons.cake,
                          leading: "Indeks glikemiczny",
                          value: dish.glicemicIndex),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  if (dish.notes != "")
                    Text(
                      'Uwagi',
                      style: TextStyle(color: Colors.orange, fontSize: 14),
                    ),
                  SizedBox(
                    height: 12,
                  ),
                  if (dish.notes != "")
                    Text(
                      '${dish.notes}',
                      style: TextStyle(color: Colors.grey[200], fontSize: 12),
                    ),
                  if (dish.vegan)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.info_rounded,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          'Danie wegańskie',
                          style:
                              TextStyle(color: Colors.grey[200], fontSize: 12),
                        ),
                      ],
                    ),
                  if (dish.vegetarian)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.info_rounded,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          'Danie wegetariańskie',
                          style:
                              TextStyle(color: Colors.grey[200], fontSize: 12),
                        ),
                      ],
                    ),
                ],
              ),
              SizedBox(
                height: 28,
              )
            ],
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        decoration: BoxDecoration(color: Colors.grey[900]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MenuiButton(
              color: Colors.orange,
              icon: Icons.home_rounded,
              text: "Szukaj",
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage())),
            ),
            MenuiButton(
              color: Colors.orange,
              icon: Icons.note_rounded,
              text: "Zamównienie",
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OrderView())),
            ),
            MenuiButton(
              color: Colors.orange,
              icon: Icons.favorite_rounded,
              text: "Ulubione",
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FavoritesView())),
            ),
            MenuiButton(
              color: Colors.orange,
              icon: Icons.settings,
              text: "Ustawienia",
              onPressed: () {
                showSettings(context, settings);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.orange,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          MenuiButton(
            color: Colors.grey,
            icon: Icons.share_rounded,
            text: "Udostępnij",
            onPressed: () => Share.share('https://www.menui.pl/dish/${dish.id}',
                subject: '${dish.name}'),
          ),
          MenuiButton(
            color: Colors.grey,
            icon: Icons.note_add_rounded,
            text: "Do zamówienia",
            onPressed: () {
              settings.addToOrder(dish.id);
            },
          ),
        ],
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
      mainAxisAlignment: MainAxisAlignment.center,
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
            margin: EdgeInsets.all(10),
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
            margin: EdgeInsets.all(10),
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
            margin: EdgeInsets.all(10),
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
