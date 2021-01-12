import 'package:flutter/material.dart';
import 'package:menui_mobile/settings.dart';
import '../services.dart';
import 'dishView.dart';

class DishCardAsync extends StatelessWidget {
  final OrderItem item;
  final Function onRemoved;
  final services = new MenuiServices();
  final settings = new MenuiSettings();
  final int index;

  DishCardAsync({@required this.item, this.onRemoved, this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
              color: Colors.grey[850],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              margin: EdgeInsets.only(left: 12, top: 5, bottom: 5),
              child: FutureBuilder(
                future: services.fetchDish(item.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Dish dish = snapshot.data;
                    return InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DishView(dish: dish))),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                '${item.quantity}x',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
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
                                      style: TextStyle(
                                          color: Colors.orange[600],
                                          fontSize: 15),
                                    ),
                                  ),
                                  if (item.priceName.isNotEmpty)
                                    Text(
                                      item.priceName,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 12),
                                child: Text(
                                  '${item.price} zł',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                              )
                            ],
                          )),
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              )),
        ),
        Expanded(
          flex: 0,
          child: IconButton(
            icon: Icon(
              Icons.delete_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              settings.removeFromOrder(index);
              onRemoved();
            },
          ),
        )
      ],
    );
  }
}
