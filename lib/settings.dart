import 'package:shared_preferences/shared_preferences.dart';

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
  void addToOrder(String id) async{
    final settings = await SharedPreferences.getInstance();
    if(settings.containsKey('order')){
      List<String> order = settings.getStringList('order');
      order.add(id);
    } else {
      final List<String> order = new List<String>();
      order.add(id);
    }
  }

  // GET ORDER
  Future<List<String>> getOrder() async{
    final settings = await SharedPreferences.getInstance();
    if(settings.containsKey('order')){
      List<String> order = settings.getStringList('order');
      return order;
    } else {
      return new List<String>();
    }
  }
}
