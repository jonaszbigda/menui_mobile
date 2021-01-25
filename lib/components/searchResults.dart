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
import 'package:menui_mobile/localizations.dart';

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
    List<Restaurant> filteredRestaurants =
        filters.filterRestaurants(widget.restaurants, filters);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("img/bg.png"), fit: BoxFit.cover)),
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
                    List<Tags> result = List<Tags>.from(filters.tags);
                    if (filters.tags.contains(tag)) {
                      result.remove(tag);
                    } else {
                      result.add(tag);
                    }
                    setState(() {
                      filters.tags = result;
                    });
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
              itemCount: filteredRestaurants.length,
              itemBuilder: (context, index) {
                return RestaurantCard(
                  restaurant: filteredRestaurants[index],
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
              text: AppLocalizations.instance.text('search'),
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage())),
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
                showSettings(context, widget.settings);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          '${AppLocalizations.instance.text('foundCounter')} ${filteredRestaurants.length}',
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
            text: AppLocalizations.instance.text('filter'),
            onPressed: () {
              setState(() {
                expand = !expand;
              });
            },
          ),
        ],
      ),
    );
  }
}
