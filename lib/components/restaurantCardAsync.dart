import 'package:flutter/material.dart';
import 'restaurantView.dart';
import 'package:menui_mobile/services.dart';
import 'lineOfIconsSmall.dart';

class RestaurantCardAsync extends StatelessWidget {
  RestaurantCardAsync({@required this.id});
  final _services = new MenuiServices();
  final String id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Card(
        child: FutureBuilder(
          future: _services.fetchRestaurant(id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Restaurant restaurant = snapshot.data;
              String _openHours =
                  _services.getTodayHours(restaurant.workingHours);
              return InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              RestaurantView(id: restaurant.id))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: ClipRRect(
                          child: Image.network(
                            restaurant.imgUrl,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              topLeft: Radius.circular(12)),
                        ),
                        padding: EdgeInsets.only(right: 8),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 4),
                              child: Text(
                                restaurant.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.orange[600], fontSize: 14),
                              ),
                            ),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.location_city,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 4),
                                    child: Text(
                                      '${restaurant.city}, ${restaurant.adress}',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 11),
                                    ),
                                  ),
                                ]),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.restaurant,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 4),
                                    child: Text(
                                      '${restaurant.type}',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 11),
                                    ),
                                  ),
                                ]),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.timer,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 4),
                                    child: Text(
                                      '$_openHours',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 11),
                                    ),
                                  ),
                                ]),
                            Padding(
                              padding: EdgeInsets.only(top: 2),
                              child: LineOfIconsSmall(tags: restaurant.tags),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Icon(
                          Icons.arrow_right,
                          color: Colors.white,
                          size: 28,
                        ),
                      )
                    ],
                  ));
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        color: Colors.grey[900],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
        margin: EdgeInsets.symmetric(horizontal: 12),
      ),
    );
  }
}
