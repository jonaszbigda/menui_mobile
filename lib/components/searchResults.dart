import '../services.dart';
import 'package:flutter/material.dart';
import 'package:menui_mobile/components/restaurantCard.dart';
import 'searchBar.dart';

class SearchResults extends StatelessWidget {
  final List<Restaurant> restaurants;

  SearchResults({@required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("img/bg_tile.jpg"), fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Image.asset(
                "img/logo_orange.png",
                width: 60,
              ),
              MenuiSearchBar(),
              Row(children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 12),
                  child: Text(
                    'Znaleziono: ${restaurants.length}',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              ]),
              Expanded(
                  child: ListView.builder(
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  return RestaurantCard(
                    restaurant: restaurants[index],
                  );
                },
              ))
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        decoration: BoxDecoration(color: Colors.grey[850]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              color: Colors.grey[850],
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.home_rounded,
                    color: Colors.orange,
                  ),
                  Text(
                    'Szukaj',
                    style: TextStyle(color: Colors.grey[200], fontSize: 12),
                  )
                ],
              ),
            ),
            RaisedButton(
              color: Colors.grey[850],
              elevation: 0,
              padding: EdgeInsets.all(8),
              onPressed: () {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.note_rounded,
                    color: Colors.orange,
                  ),
                  Text(
                    'Zamówienie',
                    style: TextStyle(color: Colors.grey[200], fontSize: 12),
                  )
                ],
              ),
            ),
            RaisedButton(
              color: Colors.grey[850],
              elevation: 0,
              padding: EdgeInsets.all(8),
              onPressed: () {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.favorite_rounded,
                    color: Colors.orange,
                  ),
                  Text(
                    'Ulubione',
                    style: TextStyle(color: Colors.grey[200], fontSize: 12),
                  )
                ],
              ),
            ),
            RaisedButton(
              color: Colors.grey[850],
              elevation: 0,
              padding: EdgeInsets.all(8),
              onPressed: () {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.settings,
                    color: Colors.orange,
                  ),
                  Text(
                    'Ustawienia',
                    style: TextStyle(color: Colors.grey[200], fontSize: 12),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
