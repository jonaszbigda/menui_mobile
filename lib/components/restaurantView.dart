import 'package:flutter/material.dart';
import '../services.dart';
import 'lineOfIcons.dart';

class RestaurantView extends StatelessWidget {
  final Restaurant restaurant;

  RestaurantView({@required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("img/bg_tile.jpg"), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        restaurant.imgUrl,
                      ),
                      fit: BoxFit.cover)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 160,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.grey[850],
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              restaurant.name,
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              restaurant.city,
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                        margin: EdgeInsets.all(12),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                            color: Colors.grey[850],
                            borderRadius: BorderRadius.circular(30)),
                        child: IconButton(
                            icon: Icon(
                              Icons.map,
                              color: Colors.orange,
                            ),
                            onPressed: () {}),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.grey[850]),
              child: Column(
                children: <Widget>[
                  LineOfIcons(
                    tags: restaurant.tags,
                  ),
                  Text('1234')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
