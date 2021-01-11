import 'package:flutter/material.dart';

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
  bool cardPayments = false;
  bool petFriendly = false;
  bool glutenFree = false;
  bool vegan = false;
  bool vegetarian = false;
  bool alcohol = false;
  bool delivery = false;
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
                active: filters.cardPayments,
                img: 'img/i_card_black.png',
                onTapped: () => onSelectTag(Tags.cardPayments),
              ),
              RestaurantTag(
                name: "Lubimy zwierzaki",
                active: filters.petFriendly,
                img: 'img/i_pets_black.png',
                onTapped: () => onSelectTag(Tags.petFriendly),
              ),
              RestaurantTag(
                name: "Bez glutenu",
                active: filters.glutenFree,
                img: 'img/i_glutenFree_black.png',
                onTapped: () => onSelectTag(Tags.glutenFree),
              ),
              RestaurantTag(
                name: "Wegańskie",
                active: filters.vegan,
                img: 'img/i_vegan_black.png',
                onTapped: () => onSelectTag(Tags.vegan),
              ),
              RestaurantTag(
                name: "Wegetariańskie",
                active: filters.vegetarian,
                img: 'img/i_vegetarian_black.png',
                onTapped: () => onSelectTag(Tags.vegetarian),
              ),
              RestaurantTag(
                name: "Alkohol",
                active: filters.alcohol,
                img: 'img/i_alcohol_black.png',
                onTapped: () => onSelectTag(Tags.alcohol),
              ),
              RestaurantTag(
                name: "Dowozimy",
                active: filters.delivery,
                img: 'img/i_delivery_black.png',
                onTapped: () => onSelectTag(Tags.delivery),
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
  final bool active;
  final Function onTapped;

  RestaurantTag({this.name, this.active, this.img, this.onTapped});

  @override
  Widget build(BuildContext context) {
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
