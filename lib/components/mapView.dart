import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services.dart';
import 'package:geolocator/geolocator.dart';
import 'restaurantView.dart';

class MapView extends StatefulWidget {
  @override
  State<MapView> createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  Completer<GoogleMapController> _controller = Completer();
  MenuiServices services = new MenuiServices();
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
            child = GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _initialPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: Set<Marker>.of(data.markers.values),
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
            child = Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Szukam restauracji...'),
                  )
                ],
              ),
            );
          }
          return child;
        },
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: FloatingActionButton(
          backgroundColor: Colors.grey[800],
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_outlined,
            color: Colors.orange,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
    );
  }
}
