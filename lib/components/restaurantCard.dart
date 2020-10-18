import 'package:flutter/material.dart';
import 'restaurantView.dart';
import 'package:menui_mobile/services.dart';

class RestaurantCard extends StatelessWidget {
  RestaurantCard({@required this.restaurant});

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RestaurantView(restaurant: restaurant))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: <Widget>[
            Container(
              child: ClipRRect(
                child: Image.network(
                  restaurant.imgUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              padding: EdgeInsets.all(8),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  restaurant.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.orange[600], fontSize: 16, height: 1.6),
                ),
                Container(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Miasto: ${restaurant.city}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    Text(
                      restaurant.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                )),
              ],
            )),
            Container(
              child: Icon(
                Icons.arrow_right,
                color: Colors.orange,
              ),
            )
          ],
        ),
      ),
      color: Color.fromRGBO(50, 50, 50, 0.8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(horizontal: 12),
    );
  }
}
