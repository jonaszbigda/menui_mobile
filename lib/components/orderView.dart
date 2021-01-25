import 'package:flutter/material.dart';
import 'package:menui_mobile/components/dishCardAsync.dart';
import '../settings.dart';
import 'homeScreen.dart';
import 'favoritesView.dart';
import 'menuiButton.dart';
import 'package:menui_mobile/localizations.dart';

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
                  image: AssetImage("img/bg.png"), fit: BoxFit.cover)),
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
                            AppLocalizations.instance.text('orderEmpty'),
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
                text: AppLocalizations.instance.text('search'),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage())),
              ),
              MenuiButton(
                color: Colors.orange,
                icon: Icons.note_rounded,
                text: AppLocalizations.instance.text('order'),
                onPressed: () {},
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
                  showSettings(context, widget.settings);
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text(
            AppLocalizations.instance.text('order'),
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
              text: AppLocalizations.instance.text('clear'),
              icon: Icons.delete_forever_rounded,
            ),
          ],
        ));
  }
}
