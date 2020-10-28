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
                "img/logo_mint.png",
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
    );
  }
}
