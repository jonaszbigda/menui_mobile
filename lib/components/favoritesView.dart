import 'package:flutter/material.dart';
import 'package:menui_mobile/components/restaurantCardAsync.dart';
import 'package:menui_mobile/localizations.dart';
import '../settings.dart';
import 'homeScreen.dart';
import 'orderView.dart';
import 'menuiButton.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({Key key}) : super(key: key);

  @override
  _FavoritesViewState createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  final MenuiSettings settings = new MenuiSettings();
  Future<List<String>> favorites;

  @override
  void initState() {
    super.initState();
    favorites = settings.getFavs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("img/bg.png"), fit: BoxFit.cover)),
            child: FutureBuilder(
              future: favorites,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<String> result = snapshot.data;
                  return ListView.builder(
                    itemCount: result.length,
                    itemBuilder: (context, index) {
                      return RestaurantCardAsync(
                        id: result[index],
                      );
                    },
                  );
                } else {
                  return Container(
                    width: 0,
                    height: 0,
                  );
                }
              },
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
                text: AppLocalizations.instance.text('search'),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage())),
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
                onPressed: () {},
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
        appBar: AppBar(
          title: Text(
            AppLocalizations.instance.text('favorites'),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
          ),
          backgroundColor: Colors.grey[900],
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.orange,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ));
  }
}
