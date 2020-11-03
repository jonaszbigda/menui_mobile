import 'package:flutter/material.dart';
import 'searchBar.dart';
import '../settings.dart';

class HomePage extends StatelessWidget {
  final MenuiSettings settings = new MenuiSettings();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("img/bg_tile.jpg"), fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "img/logo_orange.png",
                width: 160,
              ),
              MenuiSearchBar(),
              Text(
                'lub',
                style: TextStyle(color: Colors.grey[500]),
              ),
              RaisedButton.icon(
                color: Colors.grey[850],
                onPressed: () {},
                icon: Icon(
                  Icons.my_location,
                  color: Colors.orange,
                ),
                label: Text(
                  'Pokaż w pobliżu',
                  style: TextStyle(color: Colors.grey[400]),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSettings(context);
        },
        child: Icon(
          Icons.settings,
          color: Colors.orange,
        ),
        backgroundColor: Colors.grey[850],
      ),
    );
  }

  // SHOW SETTINGS

  showSettings(BuildContext context) async {
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
                    showLanguageSelectionDialog(context);
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
                    showRadiusSelectionDialog(context);
                  }),
              ListTile(
                  title: Text(
                    'Proponuj restauracje',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(recommendations,
                      style: TextStyle(color: Colors.grey)),
                  leading: Icon(
                    Icons.notifications,
                    color: Colors.orange,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    showRecommendationsDialog(context);
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

  // SELECT LANGUAGE

  void showLanguageSelectionDialog(BuildContext context) async {
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
                  style:
                      TextStyle(color: getOptionColor(currentLanguage, 'pl')),
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
                  style:
                      TextStyle(color: getOptionColor(currentLanguage, 'en')),
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
                  style:
                      TextStyle(color: getOptionColor(currentLanguage, 'de')),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          );
        });
  }

  // SET SHOW RECOMMENDATIONS

  void showRecommendationsDialog(BuildContext context) async {
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
                  style: TextStyle(
                      color: getOptionColor(showRecommendations, true)),
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

  void showAppInfoDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
              backgroundColor: Colors.grey[850],
              children: <Widget>[
                ListTile(
                    title: Text(
                      'Wersja aplikacji',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      '0.0.1 (alpha)',
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
                      'support@menui.pl',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    )),
                Text(
                  'Menui Sp. z o.o. - wszelkie prawa zastrzeżone.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                )
              ]);
        });
  }

  // SELECT RADIUS

  void showRadiusSelectionDialog(BuildContext context) async {
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
