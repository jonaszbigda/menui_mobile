import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services.dart';
import 'package:geolocator/geolocator.dart';

class MapView extends StatefulWidget {
  @override
  State<MapView> createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  Completer<GoogleMapController> _controller = Completer();
  MenuiServices services = new MenuiServices();
  Position position;

  Future<Map<MarkerId, Marker>> createMarkers() async {
    Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      position = position;
    });
    print('position is set');
    /* List<Restaurant> restaurants = await services.fetchRestaurantsByLocation(
        position.latitude, position.longitude, 1000); */
    List<Restaurant> restaurants =
        await services.fetchRestaurantsByLocation(20.60912, 52.87728);
    if (restaurants.isNotEmpty) {
      for (Restaurant thisRestaurant in restaurants) {
        final MarkerId markerId = MarkerId(thisRestaurant.name);
        print(thisRestaurant.name);
        final Marker marker = Marker(
            markerId: markerId,
            position: LatLng(
                thisRestaurant.coordinates[0], thisRestaurant.coordinates[1]),
            infoWindow: InfoWindow(
                title: '${thisRestaurant.name}',
                snippet: 'Kuchnia: ${thisRestaurant.type}'));
        markers[markerId] = marker;
      }
    }
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<MarkerId, Marker>>(
        future: createMarkers(),
        builder: (BuildContext context,
            AsyncSnapshot<Map<MarkerId, Marker>> snapshot) {
          Map<MarkerId, Marker> markers = snapshot.data;
          List<Widget> children;
          if (snapshot.hasData) {
            final CameraPosition _initialPosition = CameraPosition(
              target: LatLng(20, 58),
              zoom: 16,
            );
            children = <Widget>[
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _initialPosition,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: Set<Marker>.of(markers.values),
              ),
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[Text('error')];
          } else {
            children = <Widget>[
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              )
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          );
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
