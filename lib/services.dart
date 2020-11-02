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

  Future<List<Dish>> fetchAllDishes(String id) async {
    final response =
        await http.get('${backendURL}restaurant/dishes?restaurantId=$id');
    if (response.statusCode != 400 &&
        response.statusCode != 404 &&
        response.statusCode != 500) {
      final List decodedResponse = json.decode(response.body);
      List<Dish> dishes = [];
      if (decodedResponse.isNotEmpty && decodedResponse != null) {
        for (var dish in decodedResponse) {
          final thisAllergens = dish['allergens'];
          final Dish thisDish = new Dish(
              id: dish['_id'],
              restaurantId: dish['restaurantId'],
              name: dish['name'],
              category: dish['category'],
              price: dish['price'],
              notes: dish['notes'],
              imgUrl: dish['imgUrl'],
              weight: dish['weight'],
              ingredients: dish['ingredients'],
              vegetarian: dish['vegetarian'],
              vegan: dish['vegan'],
              glicemicIndex: dish['glicemicIndex'],
              kCal: dish['kCal'],
              allergens: new MenuiAllergens(
                  thisAllergens['gluten'],
                  thisAllergens['lactose'],
                  thisAllergens['soy'],
                  thisAllergens['eggs'],
                  thisAllergens['seaFood'],
                  thisAllergens['peanuts'],
                  thisAllergens['sesame']));
          dishes.add(thisDish);
        }
      }
      return dishes;
    }
  }

  Future<Restaurant> fetchRestaurant(String id) async {
    final response = await http.get('${backendURL}restaurant?restaurantId=$id');
    if (response.statusCode == 200 || response.statusCode == 304) {
      final decoded = jsonDecode(response.body);
      final workingHours = decoded['workingHours'];
      final tags = decoded['tags'];
      final links = decoded['links'];
      final List<String> categories = decoded['categories'].cast<String>();
      final List responseLunchMenu = decoded['lunchMenu'];
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
          id: decoded['_id'],
          name: decoded['name'],
          city: decoded['city'],
          adress: decoded['adress'],
          type: decoded['type'],
          coordinates: decoded['coordinates'],
          phone: decoded['phone'],
          imgUrl: decoded['imgUrl'],
          placesId: decoded['placesId'],
          workingHours: new MenuiWorkingHours(
              workingHours['pn'],
              workingHours['wt'],
              workingHours['sr'],
              workingHours['cz'],
              workingHours['pt'],
              workingHours['sb'],
              workingHours['nd']),
          description: decoded['description'],
          links: new MenuiLinks(
              links['facebook'], links['instagram'], links['www']),
          categories: categories,
          tags: new MenuiTags(
              tags['cardPayments'],
              tags['petFriendly'],
              tags['glutenFree'],
              tags['vegan'],
              tags['vegetarian'],
              tags['alcohol'],
              tags['delivery']),
          lunchHours: decoded['lunchHours'],
          lunchMenu: lunchMenu,
          dishes: decoded['dishes']);

      return result;
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
            type: restaurant['type'],
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

  String getTodayHours(MenuiWorkingHours workingHours) {
    final DateTime now = DateTime.now();
    String todayHours;
    switch (now.weekday) {
      case 1:
        todayHours = formatTodayHours(workingHours.pn);
        break;
      case 2:
        todayHours = formatTodayHours(workingHours.wt);
        break;
      case 3:
        todayHours = formatTodayHours(workingHours.sr);
        break;
      case 4:
        todayHours = formatTodayHours(workingHours.cz);
        break;
      case 5:
        todayHours = formatTodayHours(workingHours.pt);
        break;
      case 6:
        todayHours = formatTodayHours(workingHours.sb);
        break;
      case 7:
        todayHours = formatTodayHours(workingHours.nd);
        break;
    }
    return todayHours;
  }

  String formatTodayHours(String hours) {
    if (hours == "") {
      return 'nieczynne';
    } else {
      return hours;
    }
  }
}

// DATA TYPES

class Restaurant {
  String id;
  String name;
  String city;
  String adress;
  String type;
  List coordinates;
  String placesId;
  String imgUrl;
  MenuiWorkingHours workingHours;
  String description;
  MenuiTags tags;
  MenuiLinks links;
  String phone;
  List<String> categories;
  String lunchHours;
  List<MenuiLunchMenuSet> lunchMenu;
  List dishes;

  Restaurant(
      {@required this.id,
      @required this.name,
      @required this.city,
      @required this.adress,
      @required this.type,
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
