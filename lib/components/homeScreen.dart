import 'package:flutter/material.dart';
import 'searchBar.dart';
import '../settings.dart';
import 'mapView.dart';
import 'orderView.dart';
import 'favoritesView.dart';
import 'menuiButton.dart';

class HomePage extends StatelessWidget {
  final MenuiSettings settings = new MenuiSettings();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("img/bg_tile.jpg"), fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "img/logo_orange.png",
                width: 160,
              ),
              MenuiSearchBar(''),
              Text(
                'lub',
                style: TextStyle(color: Colors.grey[500]),
              ),
              RaisedButton.icon(
                color: Colors.grey[900],
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MapView())),
                icon: Icon(
                  Icons.my_location,
                  color: Colors.orange,
                ),
                label: Text(
                  'Pokaż w pobliżu',
                  style: TextStyle(color: Colors.grey[300]),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
              )
            ],
          ),
        ),
      ),
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
              onPressed: () {},
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
    );
  }
}
