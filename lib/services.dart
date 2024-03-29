import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import './settings.dart';
import './components/filters.dart';

class MenuiServices {
  final String backendURL = 'https://api.menui.pl/';
  final MenuiSettings settings = new MenuiSettings();

  Future<MenuiSuggestions> fetchAutocomplete(String text) async {
    final response =
        await http.get('${backendURL}search/autocomplete?string=$text');
    if (response.statusCode == 200 || response.statusCode == 304) {
      final List citiesDynamic = jsonDecode(response.body)['cities'];
      final List restaurantsDynamic = jsonDecode(response.body)['restaurants'];
      final List<String> cities = citiesDynamic.cast<String>().toList();
      final List<String> restaurants =
          restaurantsDynamic.cast<String>().toList();
      final MenuiSuggestions result =
          new MenuiSuggestions(cities: cities, names: restaurants);
      return result;
    } else {
      return new MenuiSuggestions(cities: [], names: []);
    }
  }

  Future<Dish> fetchDish(String id) async {
    final response = await http.get('${backendURL}dish?dishId=$id');
    if (response.statusCode == 200 || response.statusCode == 304) {
      final decoded = jsonDecode(response.body);
      final thisAllergens = decoded['allergens'];
      final thisPrices = decoded['prices'];
      final thisPrice1 = thisPrices['price1'];
      final thisPrice2 = thisPrices['price2'];
      final thisPrice3 = thisPrices['price3'];
      final result = new Dish(
          id: decoded['_id'],
          restaurantId: decoded['restaurantId'],
          name: decoded['name'],
          category: decoded['category'],
          prices: new MenuiPrices(
              price1:
                  new MenuiPrice(thisPrice1['priceName'], thisPrice1['price']),
              price2:
                  new MenuiPrice(thisPrice2['priceName'], thisPrice2['price']),
              price3:
                  new MenuiPrice(thisPrice3['priceName'], thisPrice3['price'])),
          notes: decoded['notes'],
          imgUrl: decoded['imgUrl'],
          weight: decoded['weight'],
          ingredients: decoded['ingredients'],
          vegetarian: decoded['vegetarian'],
          vegan: decoded['vegan'],
          glicemicIndex: decoded['glicemicIndex'],
          kCal: decoded['kCal'],
          allergens: new MenuiAllergens(
              thisAllergens['gluten'],
              thisAllergens['lactose'],
              thisAllergens['soy'],
              thisAllergens['eggs'],
              thisAllergens['seaFood'],
              thisAllergens['peanuts'],
              thisAllergens['sesame']));
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
          final thisPrices = dish['prices'];
          final thisPrice1 = thisPrices['price1'];
          final thisPrice2 = thisPrices['price2'];
          final thisPrice3 = thisPrices['price3'];
          final Dish thisDish = new Dish(
              id: dish['_id'],
              restaurantId: dish['restaurantId'],
              name: dish['name'],
              category: dish['category'],
              prices: new MenuiPrices(
                  price1: new MenuiPrice(
                      thisPrice1['priceName'], thisPrice1['price']),
                  price2: new MenuiPrice(
                      thisPrice2['priceName'], thisPrice2['price']),
                  price3: new MenuiPrice(
                      thisPrice3['priceName'], thisPrice3['price'])),
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
    } else {
      return List<Dish>();
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
          coordinates: decoded['location']['coordinates'],
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
          tags: decodeTags(tags),
          lunchHours: decoded['lunchHours'],
          lunchMenu: lunchMenu,
          dishes: decoded['dishes']);
      return result;
    } else {
      return null;
    }
  }

  Future<List<Restaurant>> fetchRestaurantsByLocation(
      double lat, double lng) async {
    final radius = await settings.getRadius();
    final response = await http
        .get('${backendURL}search/location?lon=$lat&lat=$lng&radius=$radius');
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
            coordinates: restaurant['location']['coordinates'],
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
            tags: decodeTags(tags),
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
            tags: decodeTags(tags),
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

  List<Tags> decodeTags(dynamic tags) {
    List<Tags> result = [];
    if (tags['cardPayments']) result.add(Tags.cardPayments);
    if (tags['petFriendly']) result.add(Tags.petFriendly);
    if (tags['glutenFree']) result.add(Tags.glutenFree);
    if (tags['vegan']) result.add(Tags.vegan);
    if (tags['vegetarian']) result.add(Tags.vegetarian);
    if (tags['alcohol']) result.add(Tags.alcohol);
    if (tags['delivery']) result.add(Tags.delivery);
    return result;
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
  List<Tags> tags;
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

  Restaurant.empty(
      {this.adress = "",
      this.city = "",
      this.coordinates = const [],
      this.id = "",
      this.imgUrl = "",
      this.name = "",
      this.type = ""});
}

class Dish {
  String id;
  String restaurantId;
  String name;
  String category;
  MenuiPrices prices;
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
      this.prices,
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

class MenuiMarker {
  final List coordinates;
  final String title;
  final String type;

  MenuiMarker(
      {@required this.coordinates, @required this.title, @required this.type});
}

class MenuiPrices {
  MenuiPrice price1;
  MenuiPrice price2;
  MenuiPrice price3;

  MenuiPrices(
      {@required this.price1, @required this.price2, @required this.price3});
}

class MenuiPrice {
  String priceName;
  String price;

  MenuiPrice(this.priceName, this.price);
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

  bool hasAllergens() {
    if (!this.gluten &&
        !this.lactose &&
        !this.soy &&
        !this.eggs &&
        !this.seaFood &&
        !this.peanuts &&
        !this.sesame) {
      return false;
    } else {
      return true;
    }
  }
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

class MarkersAndLocation {
  final Map<MarkerId, Marker> markers;
  final LatLng coordinates;

  MarkersAndLocation({@required this.markers, @required this.coordinates});
}

class MenuiSuggestions {
  final List<String> cities;
  final List<String> names;

  MenuiSuggestions({@required this.cities, @required this.names});

  MenuiSuggestions.empty({this.cities = const [], this.names = const []});

  bool suggestionsEmpty() {
    if (this.cities.isEmpty && this.names.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  int getLenght() {
    int lenght = this.cities.length + this.names.length;
    return lenght;
  }

  String getSuggestion(int index) {
    List<String> suggestions = new List<String>.from(this.cities)
      ..addAll(this.names);
    return suggestions[index];
  }

  bool isCity(int index) {
    if (index > (this.cities.length - 1)) {
      return false;
    } else {
      return true;
    }
  }
}
