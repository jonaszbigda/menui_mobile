import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:menui_mobile/settings.dart';
import 'orderView.dart';
import 'favoritesView.dart';
import 'homeScreen.dart';
import 'menuiButton.dart';
import 'package:menui_mobile/localizations.dart';

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
  final MenuiSettings settings = new MenuiSettings();
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
            title: '${widget.name}',
            snippet:
                '${AppLocalizations.instance.text('type')} ${widget.type}'));
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
                showSettings(context, settings);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.orange,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
