import 'package:flutter/material.dart';
import '../services.dart';

class DishCard extends StatelessWidget {
  final Dish dish;

  DishCard({@required this.dish});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[800],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: InkWell(
        onTap: () {},
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: ClipRRect(
                child: Image.network(
                  dish.imgUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    topLeft: Radius.circular(12)),
              ),
              padding: EdgeInsets.only(right: 8),
            ),
            Expanded(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  dish.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(color: Colors.orange[600], fontSize: 16),
                ),
                Text(
                  '${dish.price} zł',
                  style: TextStyle(color: Colors.grey[300], fontSize: 14),
                ),
              ],
            )),
            Container(
              child: Icon(
                Icons.arrow_right,
                color: Colors.white,
                size: 24,
              ),
            )
          ],
        ),
      ),
    );
  }
}
