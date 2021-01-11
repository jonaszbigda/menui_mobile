import '../services.dart';
import 'package:flutter/material.dart';
import 'package:menui_mobile/components/restaurantCard.dart';
import 'searchBar.dart';
import 'menuiButton.dart';
import 'homeScreen.dart';
import 'orderView.dart';
import 'favoritesView.dart';
import '../settings.dart';
import 'filters.dart';

class SearchResults extends StatefulWidget {
  SearchResults(
      {Key key, @required this.initialText, @required this.restaurants})
      : super(key: key);

  final String initialText;
  final List<Restaurant> restaurants;
  final MenuiSettings settings = new MenuiSettings();

  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  bool expand;
  AnimationController animationController;
  Animation<double> animation;
  Filters filters = new Filters();

  void prepareAnimations() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn);
  }

  void checkExpand() {
    if (expand) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  @override
  void initState() {
    super.initState();
    expand = false;
    prepareAnimations();
    checkExpand();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    checkExpand();
    return Scaffold(
      key: _drawerKey,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("img/bg_tile.jpg"), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizeTransition(
                sizeFactor: animation,
                child: RestaurantFilters(
                  filters: filters,
                  onSelectType: (value) {
                    if (filters.selectedTypes.contains(value)) {
                      final List<String> result =
                          List.from(filters.selectedTypes);
                      result.remove(value);
                      setState(() {
                        filters.selectedTypes = result;
                      });
                    } else {
                      final List<String> result =
                          List.from(filters.selectedTypes);
                      result.add(value);
                      setState(() {
                        filters.selectedTypes = result;
                      });
                    }
                  },
                  onSelectTag: (tag) {
                    switch (tag) {
                      case Tags.alcohol:
                        {
                          setState(() {
                            filters.alcohol = !filters.alcohol;
                          });
                        }
                        break;
                      case Tags.cardPayments:
                        {
                          setState(() {
                            filters.cardPayments = !filters.cardPayments;
                          });
                        }
                        break;
                      case Tags.delivery:
                        {
                          setState(() {
                            filters.delivery = !filters.delivery;
                          });
                        }
                        break;
                      case Tags.glutenFree:
                        {
                          setState(() {
                            filters.glutenFree = !filters.glutenFree;
                          });
                        }
                        break;
                      case Tags.petFriendly:
                        {
                          setState(() {
                            filters.petFriendly = !filters.petFriendly;
                          });
                        }
                        break;
                      case Tags.vegan:
                        {
                          setState(() {
                            filters.vegan = !filters.vegan;
                          });
                        }
                        break;
                      case Tags.vegetarian:
                        {
                          setState(() {
                            filters.vegetarian = !filters.vegetarian;
                          });
                        }
                        break;
                    }
                  },
                )),
            Container(
              decoration: BoxDecoration(color: Colors.grey[850]),
              child: Column(
                children: [
                  Container(
                      decoration: BoxDecoration(color: Colors.grey[900]),
                      child: MenuiSearchBar(widget.initialText)),
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: widget.restaurants.length,
              itemBuilder: (context, index) {
                return RestaurantCard(
                  restaurant: widget.restaurants[index],
                );
              },
            ))
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
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage())),
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
                showSettings(context, widget.settings);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Znaleziono: ${widget.restaurants.length}',
          style: TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
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
            color: Colors.grey,
            icon: Icons.filter_alt_rounded,
            text: "Filtruj",
            onPressed: () {
              setState(() {
                expand = !expand;
              });
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.grey[850]),
              child: Text(
                'Filtry',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.orange),
              ),
            )
          ],
        ),
      ),
    );
  }
}
