import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RestaurantMapView extends StatefulWidget {
  final List coordinates;
  final String name;
  final String type;

  RestaurantMapView(
      {@required this.coordinates, @required this.name, @required this.type});

  @override
  State<RestaurantMapView> createState() => RestaurantMapViewState();
}

class RestaurantMapViewState extends State<RestaurantMapView> {
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  Widget build(BuildContext context) {
    final CameraPosition _initialPosition = CameraPosition(
      target: LatLng(widget.coordinates[0], widget.coordinates[1]),
      zoom: 17,
    );
    final MarkerId markerId = MarkerId("restaurant-marker");
    final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(widget.coordinates[0], widget.coordinates[1]),
        infoWindow: InfoWindow(
            title: '${widget.name}', snippet: 'Kuchnia: ${widget.type}'));
    setState(() {
      markers[MarkerId("restaurant-marker")] = marker;
    });

    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _initialPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(markers.values),
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
