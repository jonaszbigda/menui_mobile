import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class MenuiSettings {
  // SET LANGUAGE
  void setLanguage(String lang) async {
    final settings = await SharedPreferences.getInstance();
    settings.setString('language', lang);
    print('Language set to: $lang');
  }

  // GET LANGUAGE
  Future<String> getLanguage() async {
    final settings = await SharedPreferences.getInstance();
    if (settings.containsKey('language')) {
      final String language = settings.getString('language');
      return language;
    } else {
      settings.setString('language', 'pl');
      return 'pl';
    }
  }

  // SET RADIUS
  void setRadius(int radiusMeters) async {
    final settings = await SharedPreferences.getInstance();
    settings.setInt('radius', radiusMeters);
    print('Radius set to: $radiusMeters');
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
    print('Recommendations set to: $recommend');
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
        language = 'Polski';
        break;
      case 'en':
        language = 'English';
        break;
      case 'de':
        language = 'Deutsch';
        break;
    }
    return language;
  }

  // DECODE BOOL
  String decodeBool(bool value) {
    if (value == true) {
      return "Tak";
    } else {
      return "Nie";
    }
  }

  // ADD DISH TO ORDER --- TODO
  void addToOrder(String id) async {
    final settings = await SharedPreferences.getInstance();
    if (settings.containsKey('order')) {
      List<String> order = settings.getStringList('order');
      order.add(id);
    } else {
      final List<String> order = new List<String>();
      order.add(id);
    }
  }

  // GET ORDER
  Future<List<String>> getOrder() async {
    final settings = await SharedPreferences.getInstance();
    if (settings.containsKey('order')) {
      List<String> order = settings.getStringList('order');
      return order;
    } else {
      return new List<String>();
    }
  }

  // CLEAR ORDER
  void clearOrder() async {
    final settings = await SharedPreferences.getInstance();
    settings.setStringList('order', new List<String>());
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
      return settings.getStringList('favorites');
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

void showSettings(BuildContext context, MenuiSettings settings) async {
  FocusManager.instance.primaryFocus.unfocus();
  final String languageCode = await settings.getLanguage();
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
                  'Język',
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
                  'Promień lokalizacji',
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
                  showRadiusSelectionDialog(context, settings);
                }),
            ListTile(
                title: Text(
                  'Proponuj restauracje',
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
                  'O aplikacji',
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
  final currentLanguage = await settings.getLanguage();
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(
            'Język',
            style: TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          backgroundColor: Colors.grey[850],
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                settings.setLanguage('pl');
                Navigator.pop(context);
              },
              child: Text(
                'Polski',
                style: TextStyle(color: getOptionColor(currentLanguage, 'pl')),
                textAlign: TextAlign.center,
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                settings.setLanguage('en');
                Navigator.pop(context);
              },
              child: Text(
                'English',
                style: TextStyle(color: getOptionColor(currentLanguage, 'en')),
                textAlign: TextAlign.center,
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                settings.setLanguage('de');
                Navigator.pop(context);
              },
              child: Text(
                'Deutsch',
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
            'Polecaj restauracje w okolicy',
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
                'Tak',
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
                'Nie',
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
                    'Wersja aplikacji',
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
                    'Wsparcie',
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
    BuildContext context, MenuiSettings settings) async {
  final int currentRadius = await settings.getRadius();
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return RadiusSlider(
          initialValue: currentRadius.toDouble(),
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
  RadiusSlider({Key key, @required this.initialValue}) : super(key: key);

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
        'Promień lokalizacji',
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
            Navigator.pop(context);
          },
          child: const Text(
            'Zapisz',
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
