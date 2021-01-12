import 'package:flutter/material.dart';
import 'package:menui_mobile/components/dishCardAsync.dart';
import '../settings.dart';
import 'homeScreen.dart';
import 'favoritesView.dart';
import 'menuiButton.dart';

class OrderView extends StatefulWidget {
  final settings = new MenuiSettings();

  @override
  State<OrderView> createState() => OrderViewState();
}

class OrderViewState extends State<OrderView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("img/bg_tile.jpg"), fit: BoxFit.cover)),
          child: Column(
            children: <Widget>[
              FutureBuilder(
                future: widget.settings.getOrder(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<OrderItem> order = snapshot.data;
                    if (order.isNotEmpty) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: order.length,
                          itemBuilder: (context, index) {
                            return DishCardAsync(
                              item: order[index],
                              index: index,
                              onRemoved: () {
                                setState(() {});
                              },
                            );
                          },
                        ),
                      );
                    } else {
                      return Container(
                        child: Center(
                            child: Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Text(
                            "Zamówienie jest puste.",
                            style: TextStyle(color: Colors.grey),
                          ),
                        )),
                      );
                    }
                  } else {
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              )
            ],
          ),
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
                text: "Szukaj",
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage())),
              ),
              MenuiButton(
                color: Colors.orange,
                icon: Icons.note_rounded,
                text: "Zamównienie",
                onPressed: () {},
              ),
              MenuiButton(
                color: Colors.orange,
                icon: Icons.favorite_rounded,
                text: "Ulubione",
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FavoritesView())),
              ),
              MenuiButton(
                color: Colors.orange,
                icon: Icons.settings,
                text: "Ustawienia",
                onPressed: () {
                  showSettings(context, widget.settings);
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text(
            'Zamówienie',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
          ),
          backgroundColor: Colors.grey[900],
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.orange,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            MenuiButton(
              color: Colors.orange,
              onPressed: () {
                widget.settings.clearOrder();
                setState(() {});
              },
              text: "Wyczyść",
              icon: Icons.delete_forever_rounded,
            ),
          ],
        ));
  }
}
