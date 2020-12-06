import 'package:flutter/material.dart';
import "components/homeScreen.dart";

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus.unfocus();
        },
        child: MaterialApp(
          title: 'Menui - food guide',
          themeMode: ThemeMode.dark,
          theme: ThemeData(
            platform: TargetPlatform.iOS,
            primarySwatch: Colors.orange,
            primaryColor: Colors.orange,
            accentColor: Colors.grey,
            backgroundColor: Colors.grey,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: HomePage(),
          debugShowCheckedModeBanner: false,
        ));
  }
}
