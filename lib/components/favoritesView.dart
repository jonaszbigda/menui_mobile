import 'package:flutter/material.dart';
import '../settings.dart';
import 'homeScreen.dart';
import 'orderView.dart';

class FavoritesView extends StatelessWidget {
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
              decoration: BoxDecoration(color: Colors.grey[850]),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.grey[850]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RaisedButton(
                          color: Colors.grey[850],
                          elevation: 0,
                          padding:
                              EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.arrow_back_rounded,
                                color: Colors.orange,
                              ),
                              Text(
                                'Cofnij',
                                style: TextStyle(
                                    color: Colors.grey[200], fontSize: 12),
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
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
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage())),
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
