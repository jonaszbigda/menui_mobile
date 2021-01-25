import 'package:flutter/material.dart';
import '../settings.dart';
import 'menuiButton.dart';
import 'package:menui_mobile/localizations.dart';

class FavoriteButton extends StatefulWidget {
  final String id;

  FavoriteButton({@required this.id, Key key}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  final MenuiSettings settings = new MenuiSettings();
  Future<bool> isInFavorites;
  bool inFavorites = false;

  @override
  void initState() {
    super.initState();
    isInFavorites = settings.isInFavorites(widget.id);
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
        initialData: false,
        future: isInFavorites,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            inFavorites = snapshot.data;
            if (inFavorites) {
              return MenuiButton(
                color: Colors.orange,
                icon: Icons.favorite_rounded,
                text: AppLocalizations.instance.text("remove"),
                onPressed: () {
                  settings.addToFavorites(widget.id);
                  setState(() {
                    isInFavorites = settings.isInFavorites(widget.id);
                  });
                },
              );
            } else {
              return MenuiButton(
                color: Colors.grey,
                icon: Icons.favorite_rounded,
                text: AppLocalizations.instance.text("add"),
                onPressed: () {
                  settings.addToFavorites(widget.id);
                  setState(() {
                    isInFavorites = settings.isInFavorites(widget.id);
                  });
                },
              );
            }
          } else {
            return MenuiButton(
              color: Colors.grey,
              icon: Icons.favorite_rounded,
              text: AppLocalizations.instance.text("add"),
              onPressed: () {},
            );
          }
        },
      );
}
