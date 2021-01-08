import 'package:flutter/material.dart';
import '../settings.dart';
import 'homeScreen.dart';
import 'favoritesView.dart';
import 'menuiButton.dart';

class OrderView extends StatelessWidget {
  final settings = new MenuiSettings();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("img/bg_tile.jpg"), fit: BoxFit.cover)),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(color: Colors.grey[800]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.attach_money_rounded,
                      color: Colors.orange,
                    ),
                    Text(
                      'Suma: 0zł',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              )
            ],
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
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage())),
              ),
              MenuiButton(
                color: Colors.orange,
                icon: Icons.note_rounded,
                text: "Zamównienie",
                onPressed: () {},
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
          title: Text(
            'Zamówienie',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w400, fontSize: 14),
          ),
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
              color: Colors.orange,
              onPressed: () {
                settings.clearOrder();
              },
              text: "Wyczyść",
              icon: Icons.delete_forever_rounded,
            ),
          ],
        ));
  }
}
