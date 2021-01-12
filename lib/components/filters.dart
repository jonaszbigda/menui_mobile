import 'package:flutter/material.dart';
import 'package:menui_mobile/services.dart';

enum Tags {
  cardPayments,
  petFriendly,
  glutenFree,
  vegan,
  vegetarian,
  alcohol,
  delivery
}

class Filters {
  List<Tags> tags = [];
  bool onlyOpen = false;
  List<String> selectedTypes = [];
  final List<String> availableTypes = [
    'chińska',
    'dietetyczna',
    'francuska',
    'grecka',
    'indyjska',
    'japońska',
    'koreańska',
    'koszerna',
    'meksykańska',
    'polska',
    'rosyjska',
    'skandynawska',
    'śródziemnomorska',
    'tajska',
    'turecka',
    'ukraińska',
    'węgierska',
    'wietnamska',
    'włoska',
    'mieszane',
    'inna'
  ];

  List<Restaurant> filterByTypes(
      List<Restaurant> restaurants, List<String> types) {
    if (types.isEmpty) {
      return restaurants;
    } else {
      List<Restaurant> result = restaurants.where((restaurant) {
        return types.contains(restaurant.type);
      }).toList();
      return result;
    }
  }

  List<Restaurant> filterByTags(List<Restaurant> restaurants, Filters filters) {
    if (filters.tags.isEmpty) {
      return restaurants;
    } else {
      List<Restaurant> result = [];
      restaurants.forEach((restaurant) => {
            if (filters.tags.every((tag) {
              return restaurant.tags.contains(tag);
            }))
              {result.add(restaurant)}
          });
      return result;
    }
  }

  List<Restaurant> filterRestaurants(
      List<Restaurant> restaurants, Filters filters) {
    List<Restaurant> result = [];
    result = filterByTypes(restaurants, filters.selectedTypes);
    result = filterByTags(result, filters);
    return result;
  }
}

class RestaurantFilters extends StatelessWidget {
  final Filters filters;
  final Function(String) onSelectType;
  final Function(Tags) onSelectTag;

  RestaurantFilters(
      {@required this.filters,
      @required this.onSelectType,
      @required this.onSelectTag});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.grey[850]),
      padding: EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'Rodzaj kuchni',
              style: TextStyle(color: Colors.orange),
            ),
          ),
          Wrap(
            spacing: 6,
            runAlignment: WrapAlignment.center,
            runSpacing: -14,
            children: filters.availableTypes.map<ButtonTheme>((String value) {
              return ButtonTheme(
                minWidth: 60,
                height: 20,
                child: RaisedButton(
                  splashColor: Colors.orange,
                  padding: EdgeInsets.all(6),
                  color: (() {
                    if (filters.selectedTypes.contains(value)) {
                      return Colors.orange;
                    } else {
                      return Colors.grey;
                    }
                  }()),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24))),
                  onPressed: () => onSelectType(value),
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 11),
                  ),
                ),
              );
            }).toList(),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'Tagi',
              style: TextStyle(color: Colors.orange),
            ),
          ),
          Wrap(
            spacing: 6,
            runSpacing: -12,
            children: [
              RestaurantTag(
                name: "Płatność kartą",
                img: 'img/i_card_black.png',
                onTapped: () => onSelectTag(Tags.cardPayments),
                filters: filters,
                filterTag: Tags.cardPayments,
              ),
              RestaurantTag(
                name: "Lubimy zwierzaki",
                img: 'img/i_pets_black.png',
                onTapped: () => onSelectTag(Tags.petFriendly),
                filters: filters,
                filterTag: Tags.petFriendly,
              ),
              RestaurantTag(
                name: "Bez glutenu",
                img: 'img/i_glutenFree_black.png',
                onTapped: () => onSelectTag(Tags.glutenFree),
                filters: filters,
                filterTag: Tags.glutenFree,
              ),
              RestaurantTag(
                name: "Wegańskie",
                img: 'img/i_vegan_black.png',
                onTapped: () => onSelectTag(Tags.vegan),
                filters: filters,
                filterTag: Tags.vegan,
              ),
              RestaurantTag(
                name: "Wegetariańskie",
                img: 'img/i_vegetarian_black.png',
                onTapped: () => onSelectTag(Tags.vegetarian),
                filters: filters,
                filterTag: Tags.vegetarian,
              ),
              RestaurantTag(
                name: "Alkohol",
                img: 'img/i_alcohol_black.png',
                onTapped: () => onSelectTag(Tags.alcohol),
                filters: filters,
                filterTag: Tags.alcohol,
              ),
              RestaurantTag(
                name: "Dowozimy",
                img: 'img/i_delivery_black.png',
                onTapped: () => onSelectTag(Tags.delivery),
                filters: filters,
                filterTag: Tags.delivery,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class RestaurantTag extends StatelessWidget {
  final String name;
  final String img;
  final Function onTapped;
  final Filters filters;
  final Tags filterTag;

  RestaurantTag(
      {this.name, this.img, this.onTapped, this.filters, this.filterTag});

  @override
  Widget build(BuildContext context) {
    bool active = false;
    if (filters.tags.contains(filterTag)) {
      active = true;
    }

    return ButtonTheme(
      height: 26,
      minWidth: 60,
      child: RaisedButton(
        splashColor: Colors.white,
        color: (() {
          if (active) {
            return Colors.orange;
          } else {
            return Colors.grey;
          }
        }()),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24))),
        onPressed: onTapped,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              img,
              width: 16,
            ),
            Padding(
              padding: EdgeInsets.only(left: 6),
              child: Text(
                name,
                style: TextStyle(fontSize: 11),
              ),
            )
          ],
        ),
      ),
    );
  }
}
