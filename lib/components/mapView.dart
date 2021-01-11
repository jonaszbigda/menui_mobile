import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

class MapViewState extends State<MapView> {
  Completer<GoogleMapController> _controller = Completer();
  MenuiServices services = new MenuiServices();
  final MenuiSettings settings = new MenuiSettings();
  Position position;

  Future<MarkersAndLocation> createMarkers() async {
    Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    LatLng location = new LatLng(position.latitude, position.longitude);
    List<Restaurant> restaurants = await services.fetchRestaurantsByLocation(
        position.latitude, position.longitude);
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
                                Navigator.pop(context);
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
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    '600m',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 10),
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
                                Navigator.pop(context);
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(
                                    Icons.map_rounded,
                                    color: Colors.orange,
                                  ),
                                  Text(
                                    'Kuchnia',
                                    style: TextStyle(
                                        color: Colors.grey[200],
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    'Wszystkie',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 10),
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
                                Navigator.pop(context);
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
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    'Brak',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 10),
                                  )
                                ],
                              ),
                            ),
                          ],
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
