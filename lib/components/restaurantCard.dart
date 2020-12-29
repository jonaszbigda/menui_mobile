import 'package:flutter/material.dart';
import 'restaurantView.dart';
import 'package:menui_mobile/services.dart';
import 'lineOfIconsSmall.dart';

class RestaurantCard extends StatelessWidget {
  RestaurantCard({@required this.restaurant});
  final _services = new MenuiServices();
  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    String _openHours = _services.getTodayHours(restaurant.workingHours);
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Card(
        child: InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RestaurantView(id: restaurant.id))),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    restaurant.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(color: Colors.orange[600], fontSize: 16),
                  ),
                  Container(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
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
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
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
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
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
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            ),
                          ]),
                      Padding(
                        child: LineOfIconsSmall(tags: restaurant.tags),
                        padding: EdgeInsets.only(top: 4),
                      )
                    ],
                  )),
                ],
              )),
              Container(
                child: Icon(
                  Icons.arrow_right,
                  color: Colors.white,
                  size: 28,
                ),
              )
            ],
          ),
        ),
        color: Color.fromRGBO(50, 50, 50, 0.8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.symmetric(horizontal: 12),
      ),
    );
  }
}
