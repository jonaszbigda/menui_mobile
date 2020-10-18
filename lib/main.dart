import 'package:flutter/material.dart';
import 'package:menui_mobile/components/restaurantCard.dart';
import 'components/searchBar.dart';
import 'services.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.focusedChild.unfocus();
          }
        },
        child: MaterialApp(
          title: 'Menui',
          themeMode: ThemeMode.dark,
          theme: ThemeData(
            platform: TargetPlatform.iOS,
            primarySwatch: Colors.orange,
            primaryColor: Colors.orange,
            accentColor: Colors.grey,
            backgroundColor: Colors.grey,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: HomePage(),
        ));
  }
}

// ROUTE --- HOME

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                "img/logo_mint.png",
                width: 160,
              ),
              MenuiSearchBar()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.settings,
          color: Colors.orange,
        ),
        backgroundColor: Colors.grey[850],
      ),
    );
  }
}

// ROUTE --- SEARCH RESULTS

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
