import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:menui_mobile/components/filters.dart';
import 'package:menui_mobile/settings.dart';
import '../services.dart';
import 'package:geolocator/geolocator.dart';
import 'restaurantView.dart';
import 'menuiButton.dart';
import 'orderView.dart';
import 'favoritesView.dart';

class MapView extends StatefulWidget {
  @override
  State<MapView> createState() => MapViewState();
}

class MapViewState extends State<MapView> with SingleTickerProviderStateMixin {
  Filters filters = new Filters();
  Completer<GoogleMapController> _controller = Completer();
  bool expand;
  AnimationController animationController;
  Animation<double> animation;
  MenuiServices services = new MenuiServices();
  final MenuiSettings settings = new MenuiSettings();
  Position position;

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

  Future<MarkersAndLocation> createMarkers() async {
    Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    LatLng location = new LatLng(position.latitude, position.longitude);
    List<Restaurant> fetchedRestaurants = await services
        .fetchRestaurantsByLocation(position.latitude, position.longitude);
    List<Restaurant> restaurants =
        filters.filterRestaurants(fetchedRestaurants, filters);
    if (restaurants.isNotEmpty) {
      for (Restaurant thisRestaurant in restaurants) {
        final MarkerId markerId = MarkerId(thisRestaurant.name);
        print(thisRestaurant.name);
        final Marker marker = Marker(
            markerId: markerId,
            position: LatLng(
                thisRestaurant.coordinates[0], thisRestaurant.coordinates[1]),
            infoWindow: InfoWindow(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            RestaurantView(id: thisRestaurant.id))),
                title: '${thisRestaurant.name}',
                snippet: 'Kuchnia: ${thisRestaurant.type}'));
        markers[markerId] = marker;
      }
    }
    return new MarkersAndLocation(markers: markers, coordinates: location);
  }

  @override
  Widget build(BuildContext context) {
    checkExpand();
    return Scaffold(
      body: FutureBuilder<MarkersAndLocation>(
        future: createMarkers(),
        builder:
            (BuildContext context, AsyncSnapshot<MarkersAndLocation> snapshot) {
          MarkersAndLocation data = snapshot.data;
          Widget child;
          if (snapshot.hasData) {
            final CameraPosition _initialPosition = CameraPosition(
              target: data.coordinates,
              zoom: 14,
            );
            child = Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(color: Colors.grey[850]),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(color: Colors.grey[900]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  RaisedButton(
                                    color: Colors.grey[900],
                                    elevation: 0,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 4),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Icon(
                                          Icons.arrow_back_ios_rounded,
                                          color: Colors.orange,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            RaisedButton(
                              color: Colors.grey[900],
                              elevation: 0,
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 4),
                              onPressed: () {
                                showRadiusSelectionDialog(context, settings,
                                    () {
                                  setState(() {});
                                });
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(
                                    Icons.location_pin,
                                    color: Colors.orange,
                                  ),
                                  Text(
                                    'Promień',
                                    style: TextStyle(
                                        color: Colors.grey[200],
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  FutureBuilder(
                                    future: settings.getRadius(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          '${snapshot.data}m',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 10),
                                        );
                                      } else {
                                        return null;
                                      }
                                    },
                                  )
                                ],
                              ),
                            ),
                            RaisedButton(
                              color: Colors.grey[900],
                              elevation: 0,
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 4),
                              onPressed: () {
                                setState(() {
                                  expand = !expand;
                                });
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(
                                    Icons.filter_list_alt,
                                    color: Colors.orange,
                                  ),
                                  Text(
                                    'Filtry',
                                    style: TextStyle(
                                        color: Colors.grey[200],
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(color: Colors.grey[800]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_rounded,
                              color: Colors.orange,
                            ),
                            Text(
                              'Znaleziono: ${data.markers.length}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: _initialPosition,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    markers: Set<Marker>.of(data.markers.values),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.grey[900]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      MenuiButton(
                        color: Colors.orange,
                        icon: Icons.home_rounded,
                        text: "Szukaj",
                        onPressed: () => Navigator.pop(context),
                      ),
                      MenuiButton(
                        color: Colors.orange,
                        icon: Icons.note_rounded,
                        text: "Zamównienie",
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrderView())),
                      ),
                      MenuiButton(
                        color: Colors.orange,
                        icon: Icons.favorite_rounded,
                        text: "Ulubione",
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FavoritesView())),
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
              ],
            );
          } else if (snapshot.hasError) {
            child = Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Text("Błąd...")],
              ),
            );
          } else {
            child = Container(
                decoration: BoxDecoration(color: Colors.grey[850]),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                        width: 60,
                        height: 60,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text(
                          'Szukam restauracji...',
                          style: TextStyle(color: Colors.grey[200]),
                        ),
                      )
                    ],
                  ),
                ));
          }
          return child;
        },
      ),
    );
  }
}
