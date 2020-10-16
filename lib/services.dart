import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class MenuiServices {
  final String backendURL = 'https://menui.azurewebsites.net/';

  Future<List<String>> fetchAutocomplete(String text) async {
    final response =
        await http.get('${backendURL}search/autocomplete?string=$text');
    if (response.statusCode == 200 || response.statusCode == 304) {
      final List citiesDynamic = jsonDecode(response.body)['cities'];
      final List restaurantsDynamic = jsonDecode(response.body)['restaurants'];
      final List<String> cities = citiesDynamic.cast<String>().toList();
      final List<String> restaurants =
          restaurantsDynamic.cast<String>().toList();
      final List<String> result = [...cities, ...restaurants];

      return result;
    } else {
      print("coś tu nie zagrało podczas pobierania sugestii");
      return [];
    }
  }

  Future<Dish> fetchDish(String id) async {
    final response = await http.get('${backendURL}dish?dishId=$id');
    if (response.statusCode == 200 || response.statusCode == 304) {
      final decoded = jsonDecode(response.body);
      final result = new Dish(
          id: decoded['_id'],
          restaurantId: decoded['restaurantId'],
          name: decoded['name'],
          category: decoded['category']);
      return result;
    } else {
      throw "Nie udało się pobrać";
    }
  }

  Future<List<Restaurant>> fetchSearchByString(String text) async {
    final response = await http.get('${backendURL}search?string=$text');
    if (response.statusCode == 200 || response.statusCode == 304) {
      final List decoded = jsonDecode(response.body);
      List<Restaurant> results = [];
      for (var restaurant in decoded) {
        final workingHours = restaurant['workingHours'];
        final tags = restaurant['tags'];
        final links = restaurant['links'];
        final List responseLunchMenu = restaurant['lunchMenu'];
        List<MenuiLunchMenuSet> lunchMenu = [];
        if (responseLunchMenu != null) {
          for (var lunchSet in responseLunchMenu) {
            final MenuiLunchMenuSet thisSet = new MenuiLunchMenuSet(
                lunchSet['lunchSetName'],
                lunchSet['lunchSetPrice'],
                lunchSet['lunchSetDishes']);
            lunchMenu.add(thisSet);
          }
        }
        final result = new Restaurant(
            id: restaurant['_id'],
            name: restaurant['name'],
            city: restaurant['city'],
            adress: restaurant['adress'],
            coordinates: restaurant['coordinates'],
            imgUrl: restaurant['imgUrl'],
            placesId: restaurant['placesId'],
            workingHours: new MenuiWorkingHours(
                workingHours['pn'],
                workingHours['wt'],
                workingHours['sr'],
                workingHours['cz'],
                workingHours['pt'],
                workingHours['sb'],
                workingHours['nd']),
            description: restaurant['description'],
            tags: new MenuiTags(
                tags['cardPayments'],
                tags['petFriendly'],
                tags['glutenFree'],
                tags['vegan'],
                tags['vegetarian'],
                tags['alcohol'],
                tags['delivery']),
            links: new MenuiLinks(
                links['facebook'], links['instagram'], links['www']),
            phone: restaurant['phone'],
            categories: restaurant['categories'],
            lunchHours: restaurant['lunchHours'],
            lunchMenu: lunchMenu,
            dishes: restaurant['dishes']);
        results.add(result);
      }
      return results;
    } else {
      return [];
    }
  }
}

// DATA TYPES

class Restaurant {
  String id;
  String name;
  String city;
  String adress;
  List coordinates;
  String placesId;
  String imgUrl;
  MenuiWorkingHours workingHours;
  String description;
  MenuiTags tags;
  MenuiLinks links;
  String phone;
  List categories;
  String lunchHours;
  List<MenuiLunchMenuSet> lunchMenu;
  List dishes;

  Restaurant(
      {@required this.id,
      @required this.name,
      @required this.city,
      @required this.adress,
      @required this.coordinates,
      this.placesId,
      @required this.imgUrl,
      this.workingHours,
      this.description,
      this.tags,
      this.links,
      this.phone,
      this.categories,
      this.lunchHours,
      this.lunchMenu,
      this.dishes});
}

class Dish {
  String id;
  String restaurantId;
  String name;
  String category;
  String price;
  String notes;
  String imgUrl;
  String weight;
  MenuiAllergens allergens;
  String ingredients;
  String glicemicIndex;
  String kCal;
  bool vegan;
  bool vegetarian;

  Dish(
      {@required this.id,
      @required this.restaurantId,
      @required this.name,
      @required this.category,
      this.price,
      this.notes,
      this.imgUrl,
      this.weight,
      this.allergens,
      this.ingredients,
      this.glicemicIndex,
      this.kCal,
      this.vegan,
      this.vegetarian});
}

class MenuiAllergens {
  bool gluten;
  bool lactose;
  bool soy;
  bool eggs;
  bool seaFood;
  bool peanuts;
  bool sesame;

  MenuiAllergens(this.gluten, this.lactose, this.soy, this.eggs, this.seaFood,
      this.peanuts, this.sesame);
}

class MenuiLunchMenuSet {
  String lunchSetName;
  String lunchSetPrice;
  List lunchSetDishes;

  MenuiLunchMenuSet(this.lunchSetName, this.lunchSetPrice, this.lunchSetDishes);
}

class MenuiLinks {
  String facebook;
  String instagram;
  String www;

  MenuiLinks(this.facebook, this.instagram, this.www);
}

class MenuiTags {
  bool cardPayments;
  bool petFriendly;
  bool glutenFree;
  bool vegan;
  bool vegetarian;
  bool alcohol;
  bool delivery;

  MenuiTags(this.cardPayments, this.petFriendly, this.glutenFree, this.vegan,
      this.vegetarian, this.alcohol, this.delivery);
}

class MenuiWorkingHours {
  String pn;
  String wt;
  String sr;
  String cz;
  String pt;
  String sb;
  String nd;

  MenuiWorkingHours(
      this.pn, this.wt, this.sr, this.cz, this.pt, this.sb, this.nd);
}
