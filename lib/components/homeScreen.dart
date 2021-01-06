import 'package:flutter/material.dart';
import 'searchBar.dart';
import '../settings.dart';
import 'mapView.dart';
import 'orderView.dart';
import 'favoritesView.dart';

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
              MenuiSearchBar(),
              Text(
                'lub',
                style: TextStyle(color: Colors.grey[500]),
              ),
              RaisedButton.icon(
                color: Colors.grey[850],
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MapView())),
                icon: Icon(
                  Icons.my_location,
                  color: Colors.orange,
                ),
                label: Text(
                  'Pokaż w pobliżu',
                  style: TextStyle(color: Colors.grey[400]),
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
        decoration: BoxDecoration(color: Colors.grey[850]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              color: Colors.grey[850],
              elevation: 0,
              padding: EdgeInsets.all(8),
              onPressed: () {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.home_rounded,
                    color: Colors.orange,
                  ),
                  Text(
                    'Szukaj',
                    style: TextStyle(
                        color: Colors.grey[200],
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
            RaisedButton(
              color: Colors.grey[850],
              elevation: 0,
              padding: EdgeInsets.all(8),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OrderView())),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.note_rounded,
                    color: Colors.orange,
                  ),
                  Text(
                    'Zamówienie',
                    style: TextStyle(
                        color: Colors.grey[200],
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
            RaisedButton(
              color: Colors.grey[850],
              elevation: 0,
              padding: EdgeInsets.all(8),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FavoritesView())),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.favorite_rounded,
                    color: Colors.orange,
                  ),
                  Text(
                    'Ulubione',
                    style: TextStyle(
                        color: Colors.grey[200],
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
            RaisedButton(
              color: Colors.grey[850],
              elevation: 0,
              padding: EdgeInsets.all(8),
              onPressed: () {
                showSettings(context, settings);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.settings,
                    color: Colors.orange,
                  ),
                  Text(
                    'Ustawienia',
                    style: TextStyle(
                        color: Colors.grey[200],
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
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
