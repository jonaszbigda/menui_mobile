import 'dart:convert';

import 'package:menui_mobile/localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class MenuiSettings {
  // SET LANGUAGE
  void setLanguage(String lang, BuildContext context) async {
    final settings = await SharedPreferences.getInstance();
    settings.setString('language', lang);
    await AppLocalizations.instance.load(Locale(lang, ''));
    String newLang = AppLocalizations.instance.getLocale();
    AppBuilder.of(context).rebuild(lang);
  }

  // GET LANGUAGE
  Future<String> getLanguage(BuildContext context) async {
    final settings = await SharedPreferences.getInstance();
    if (settings.containsKey('language')) {
      final String language = settings.getString('language');
      return language;
    } else {
      setLanguage('pl', context);
      return 'pl';
    }
  }

  // INIT LANGUAGE
  void initLanguage(BuildContext context) async {
    final String language = await getLanguage(context);
    String currentLanguage = AppLocalizations.instance.getLocale();
    if (currentLanguage != language) {
      await setLanguage(language, context);
    }
  }

  // SET RADIUS
  void setRadius(int radiusMeters) async {
    final settings = await SharedPreferences.getInstance();
    settings.setInt('radius', radiusMeters);
  }

  // GET RADIUS
  Future<int> getRadius() async {
    final settings = await SharedPreferences.getInstance();
    if (settings.containsKey('radius')) {
      final radius = settings.getInt('radius');
      return radius;
    } else {
      settings.setInt('radius', 600);
      return 600;
    }
  }

  // SET RECOMMENDATIONS
  void setRecommendations(bool recommend) async {
    final settings = await SharedPreferences.getInstance();
    settings.setBool('recommendations', recommend);
  }

  // GET RECOMMENDATIONS
  Future<bool> getRecommendations() async {
    final settings = await SharedPreferences.getInstance();
    if (settings.containsKey('recommendations')) {
      final recommend = settings.getBool('recommendations');
      return recommend;
    } else {
      settings.setBool('recommendations', false);
      return false;
    }
  }

  // DECODE LANGUAGE
  String decodeLanguage(String languageCode) {
    String language;
    switch (languageCode) {
      case 'pl':
        language = AppLocalizations.instance.text("pl");
        break;
      case 'en':
        language = AppLocalizations.instance.text("en");
        break;
      case 'de':
        language = AppLocalizations.instance.text("de");
        break;
    }
    return language;
  }

  // DECODE BOOL
  String decodeBool(bool value) {
    if (value == true) {
      return AppLocalizations.instance.text("yes");
    } else {
      return AppLocalizations.instance.text("no");
    }
  }

  // DECODE ORDER
  List<OrderItem> decodeOrder(String orderJson) {
    print(orderJson);
    final List decoded = jsonDecode(orderJson);
    List<OrderItem> order = [];
    decoded.forEach((item) => {
          order.add(new OrderItem(
              id: item['id'],
              quantity: item['quantity'],
              price: item['price'],
              priceName: item['priceName']))
        });
    return order;
  }

  // ENCODE ORDER
  String encodeOrder(List<OrderItem> order) {
    return jsonEncode(order);
  }

  // ADD DISH TO ORDER
  void addToOrder(OrderItem item) async {
    final settings = await SharedPreferences.getInstance();
    if (settings.containsKey('order')) {
      String rawOrder = settings.getString('order');
      List<OrderItem> order = decodeOrder(rawOrder);
      order.add(item);
      String encodedOrder = encodeOrder(order);
      settings.setString('order', encodedOrder);
    } else {
      final List<OrderItem> order = new List<OrderItem>();
      order.add(item);
      String encodedOrder = encodeOrder(order);
      settings.setString('order', encodedOrder);
    }
  }

  // REMOVE FROM ORDER
  void removeFromOrder(int index) async {
    final settings = await SharedPreferences.getInstance();
    String rawOrder = settings.getString('order');
    List<OrderItem> order = decodeOrder(rawOrder);
    order.removeAt(index);
    String encodedOrder = encodeOrder(order);
    settings.setString('order', encodedOrder);
  }

  // GET ORDER
  Future<List<OrderItem>> getOrder() async {
    final settings = await SharedPreferences.getInstance();
    if (settings.containsKey('order')) {
      String rawOrder = settings.getString('order');
      List<OrderItem> order = decodeOrder(rawOrder);
      return order;
    } else {
      return new List<OrderItem>();
    }
  }

  // CLEAR ORDER
  void clearOrder() async {
    final settings = await SharedPreferences.getInstance();
    String cleanOrder = encodeOrder(new List<OrderItem>());
    settings.setString('order', cleanOrder);
  }

  // ADD TO FAVORITES (OR REMOVE)
  void addToFavorites(String id) async {
    final settings = await SharedPreferences.getInstance();
    if (settings.containsKey('favorites')) {
      List<String> favorites = settings.getStringList('favorites');
      if (favorites.contains(id)) {
        favorites.remove(id);
        settings.setStringList('favorites', favorites);
      } else {
        favorites.add(id);
        settings.setStringList('favorites', favorites);
      }
    } else {
      List<String> favorites = new List<String>();
      favorites.add(id);
      settings.setStringList('favorites', favorites);
    }
  }

  // GET FAVORITES
  Future<List<String>> getFavs() async {
    final settings = await SharedPreferences.getInstance();
    if (settings.containsKey('favorites')) {
      final List<String> result = settings.getStringList('favorites');
      return result;
    } else {
      return [];
    }
  }

  // CHECK IF ID IS IN FAVORITES
  Future<bool> isInFavorites(String id) async {
    final settings = await SharedPreferences.getInstance();
    if (settings.containsKey('favorites')) {
      List<String> favorites = settings.getStringList('favorites');
      if (favorites.contains(id)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}

class AppBuilder extends StatefulWidget {
  final Function(BuildContext) builder;

  const AppBuilder({Key key, this.builder}) : super(key: key);

  @override
  AppBuilderState createState() => new AppBuilderState();

  static AppBuilderState of(BuildContext context) {
    return context.findAncestorStateOfType<AppBuilderState>();
  }
}

class AppBuilderState extends State<AppBuilder> {
  String languageCode;

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }

  void rebuild(String language) {
    print('REBUILDING...');
    if (languageCode == null || languageCode != language) {
      print('languageCode: $languageCode /// newLanguage: $language');
      setState(() {
        languageCode = language;
      });
    }
  }
}

void showSettings(BuildContext context, MenuiSettings settings) async {
  FocusManager.instance.primaryFocus.unfocus();
  final String languageCode = await settings.getLanguage(context);
  final String language = settings.decodeLanguage(languageCode);
  final int radius = await settings.getRadius();
  final bool recommendationsValue = await settings.getRecommendations();
  final recommendations = settings.decodeBool(recommendationsValue);

  showModalBottomSheet(
      backgroundColor: Colors.grey[850],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24))),
      context: context,
      builder: (BuildContext context) {
        return ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            ListTile(
                title: Text(
                  AppLocalizations.instance.text("language"),
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  language,
                  style: TextStyle(color: Colors.grey),
                ),
                leading: Icon(
                  Icons.language,
                  color: Colors.orange,
                ),
                onTap: () {
                  Navigator.pop(context);
                  showLanguageSelectionDialog(context, settings);
                }),
            ListTile(
                title: Text(
                  AppLocalizations.instance.text("localizationRadius"),
                  style: TextStyle(color: Colors.white),
                ),
                subtitle:
                    Text('${radius}m', style: TextStyle(color: Colors.grey)),
                leading: Icon(
                  Icons.location_searching_rounded,
                  color: Colors.orange,
                ),
                onTap: () {
                  Navigator.pop(context);
                  showRadiusSelectionDialog(context, settings, () {});
                }),
            ListTile(
                title: Text(
                  AppLocalizations.instance.text("suggest"),
                  style: TextStyle(color: Colors.white),
                ),
                subtitle:
                    Text(recommendations, style: TextStyle(color: Colors.grey)),
                leading: Icon(
                  Icons.notifications,
                  color: Colors.orange,
                ),
                onTap: () {
                  Navigator.pop(context);
                  showRecommendationsDialog(context, settings);
                }),
            ListTile(
                title: Text(
                  AppLocalizations.instance.text("aboutApp"),
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.info,
                  color: Colors.grey,
                ),
                onTap: () {
                  Navigator.pop(context);
                  showAppInfoDialog(context);
                }),
          ],
        );
      });
}

void showLanguageSelectionDialog(
    BuildContext context, MenuiSettings settings) async {
  final currentLanguage = await settings.getLanguage(context);
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(
            AppLocalizations.instance.text("language"),
            style: TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          backgroundColor: Colors.grey[850],
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                settings.setLanguage('pl', context);
                Navigator.pop(context);
              },
              child: Text(
                AppLocalizations.instance.text("pl"),
                style: TextStyle(color: getOptionColor(currentLanguage, 'pl')),
                textAlign: TextAlign.center,
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                settings.setLanguage('en', context);
                Navigator.pop(context);
              },
              child: Text(
                AppLocalizations.instance.text("en"),
                style: TextStyle(color: getOptionColor(currentLanguage, 'en')),
                textAlign: TextAlign.center,
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                settings.setLanguage('de', context);
                Navigator.pop(context);
              },
              child: Text(
                AppLocalizations.instance.text("de"),
                style: TextStyle(color: getOptionColor(currentLanguage, 'de')),
                textAlign: TextAlign.center,
              ),
            )
          ],
        );
      });
}

// SET SHOW RECOMMENDATIONS

void showRecommendationsDialog(
    BuildContext context, MenuiSettings settings) async {
  final showRecommendations = await settings.getRecommendations();
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(
            AppLocalizations.instance.text("suggest"),
            style: TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          backgroundColor: Colors.grey[850],
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                settings.setRecommendations(true);
                Navigator.pop(context);
              },
              child: Text(
                AppLocalizations.instance.text("yes"),
                style:
                    TextStyle(color: getOptionColor(showRecommendations, true)),
                textAlign: TextAlign.center,
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                settings.setRecommendations(false);
                Navigator.pop(context);
              },
              child: Text(
                AppLocalizations.instance.text("no"),
                style: TextStyle(
                    color: getOptionColor(showRecommendations, false)),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      });
}

// SHOW APP INFO

void showAppInfoDialog(BuildContext context) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            backgroundColor: Colors.grey[850],
            children: <Widget>[
              ListTile(
                  title: Text(
                    AppLocalizations.instance.text("appVersion"),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    version,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  )),
              ListTile(
                  title: Text(
                    AppLocalizations.instance.text("support"),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'menui@menui.pl',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  )),
            ]);
      });
}

// SELECT RADIUS

void showRadiusSelectionDialog(
    BuildContext context, MenuiSettings settings, Function onSaved) async {
  final int currentRadius = await settings.getRadius();
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return RadiusSlider(
          initialValue: currentRadius.toDouble(),
          onSaved: onSaved,
        );
      });
}

Color getOptionColor(targetOption, thisOption) {
  if (thisOption == targetOption) {
    return Colors.orange;
  } else {
    return Colors.grey;
  }
}

class RadiusSlider extends StatefulWidget {
  final double initialValue;
  final Function onSaved;
  RadiusSlider({Key key, @required this.initialValue, this.onSaved})
      : super(key: key);

  @override
  _RadiusSliderState createState() =>
      _RadiusSliderState(sliderValue: initialValue);
}

class _RadiusSliderState extends State<RadiusSlider> {
  double sliderValue;

  _RadiusSliderState({this.sliderValue});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        AppLocalizations.instance.text("localizationRadius"),
        style: TextStyle(color: Colors.white, fontSize: 16),
        textAlign: TextAlign.center,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: Colors.grey[850],
      children: <Widget>[
        Slider(
            value: sliderValue,
            min: 300,
            max: 3000,
            divisions: 9,
            label: formatDistance(sliderValue),
            onChanged: (double value) {
              setState(() {
                sliderValue = value;
              });
            }),
        SimpleDialogOption(
          onPressed: () async {
            final MenuiSettings settings = new MenuiSettings();
            settings.setRadius(sliderValue.toInt());
            if (widget.onSaved != null) {
              widget.onSaved();
            }
            Navigator.pop(context);
          },
          child: Text(
            AppLocalizations.instance.text("save"),
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  String formatDistance(double distance) {
    if (distance > 1000) {
      final double distanceInKM = distance / 1000;
      return '${distanceInKM.toString()}km';
    } else {
      return '${distance}m';
    }
  }
}

class OrderItem {
  final int quantity;
  final String price;
  final String priceName;
  final String id;

  OrderItem({this.id, this.price, this.priceName, this.quantity});

  Map<String, dynamic> toJson() {
    return {
      "quantity": quantity,
      "price": price,
      "priceName": priceName,
      "id": id
    };
  }
}
