import 'package:flutter/material.dart';
import '../services.dart';
import 'dishCard.dart';
import 'package:menui_mobile/localizations.dart';

class DishList extends StatelessWidget {
  final String id;
  final List<String> categories;
  DishList({@required this.id, @required this.categories});

  final MenuiServices services = new MenuiServices();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ListView(children: [
        SizedBox(height: 24),
        FutureBuilder<List<Dish>>(
            future: services.fetchAllDishes(id),
            builder:
                (BuildContext context, AsyncSnapshot<List<Dish>> snapshot) {
              if (snapshot.hasData) {
                final List<Dish> dishes = snapshot.data;
                return ListView.builder(
                  controller: ScrollController(),
                  shrinkWrap: true,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final filteredDishes =
                        filterDishesByCategory(dishes, categories[index]);
                    return ExpansionTile(
                      leading: Icon(
                        Icons.fastfood_rounded,
                        color: Colors.orange,
                      ),
                      title: Text(
                        categories[index],
                        style: TextStyle(color: Colors.grey[300]),
                      ),
                      children: <Widget>[
                        ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: filteredDishes.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: DishCard(dish: filteredDishes[index]),
                            );
                          },
                        )
                      ],
                    );
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ]),
      Positioned.fill(
          bottom: 20,
          child: Align(
              alignment: Alignment.bottomCenter,
              child: RaisedButton.icon(
                splashColor: Colors.orange,
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                color: Colors.orange,
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.grey[900],
                ),
                label: Text(
                  AppLocalizations.instance.text("hideDishes"),
                  style: TextStyle(color: Colors.grey[900]),
                ),
                onPressed: () => Navigator.pop(context),
              )))
    ]);
  }

  List<Dish> filterDishesByCategory(List<Dish> dishes, String category) {
    List<Dish> result = [];
    for (var dish in dishes) {
      if (dish.category == category) {
        result.add(dish);
      }
    }
    return result;
  }
}
