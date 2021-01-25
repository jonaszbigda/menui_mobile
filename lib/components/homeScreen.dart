import 'package:flutter/material.dart';
import 'package:menui_mobile/localizations.dart';
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
    settings.initLanguage(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("img/bg.png"), fit: BoxFit.cover)),
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
                AppLocalizations.instance.text('or'),
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
                  AppLocalizations.instance.text('geosearch'),
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
              text: AppLocalizations.instance.text('search'),
              onPressed: () {},
            ),
            MenuiButton(
              color: Colors.orange,
              icon: Icons.note_rounded,
              text: AppLocalizations.instance.text('order'),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OrderView())),
            ),
            MenuiButton(
              color: Colors.orange,
              icon: Icons.favorite_rounded,
              text: AppLocalizations.instance.text('favorites'),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FavoritesView())),
            ),
            MenuiButton(
              color: Colors.orange,
              icon: Icons.settings,
              text: AppLocalizations.instance.text('settings'),
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
