import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'searchBar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void getLocation() async {
    Position currentLocation = await Geolocator.getCurrentPosition();
    print(currentLocation);
  }

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
                onPressed: getLocation,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSettings();
        },
        child: Icon(
          Icons.settings,
          color: Colors.orange,
        ),
        backgroundColor: Colors.grey[850],
      ),
    );
  }

  showSettings() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            child: Container(
              height: 260,
              decoration: BoxDecoration(color: Colors.grey[850]),
              child: ListView(
                children: <Widget>[
                  ListTile(
                      title: Text(
                        'Język',
                        style: TextStyle(color: Colors.grey),
                      ),
                      leading: Icon(
                        Icons.language,
                        color: Colors.orange,
                      ),
                      onTap: () {}),
                  ListTile(
                      title: Text(
                        'Promień lokalizacji',
                        style: TextStyle(color: Colors.grey),
                      ),
                      leading: Icon(
                        Icons.location_searching_rounded,
                        color: Colors.orange,
                      ),
                      onTap: () {}),
                  ListTile(
                      title: Text(
                        'Proponuj restauracje',
                        style: TextStyle(color: Colors.grey),
                      ),
                      leading: Icon(
                        Icons.restaurant,
                        color: Colors.orange,
                      ),
                      onTap: () {}),
                  ListTile(
                      title: Text(
                        'O aplikacji',
                        style: TextStyle(color: Colors.grey),
                      ),
                      leading: Icon(
                        Icons.info,
                        color: Colors.grey,
                      ),
                      onTap: () {}),
                ],
              ),
            ),
          );
        });
  }
}
