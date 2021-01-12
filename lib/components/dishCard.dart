import 'package:flutter/material.dart';
import '../services.dart';
import 'dishView.dart';

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
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => DishView(dish: dish))),
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
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace stackTrace) {
                    return Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(color: Colors.grey[900]),
                    );
                  },
                ),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    topLeft: Radius.circular(12)),
              ),
              padding: EdgeInsets.only(right: 8),
            ),
            Expanded(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 0,
                      child: Text(
                        dish.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style:
                            TextStyle(color: Colors.orange[600], fontSize: 15),
                      ),
                    ),
                    Text(
                      dish.weight,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
                Expanded(
                  child: Prices(prices: dish.prices),
                )
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

class Prices extends StatelessWidget {
  final MenuiPrices prices;

  Prices({@required this.prices});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        if (prices.price1.priceName == "")
          Text(
            '${prices.price1.price} zł',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        if (prices.price1.priceName != "")
          Text(
            '${prices.price1.priceName}: ${prices.price1.price} zł',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        if (prices.price2.priceName != "")
          Text(
            '${prices.price2.priceName}: ${prices.price2.price} zł',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        if (prices.price3.priceName != "")
          Text(
            '${prices.price3.priceName}: ${prices.price3.price} zł',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
      ],
    );
  }
}
