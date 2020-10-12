import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RestaurantCard extends StatelessWidget {
  RestaurantCard(
      {@required this.id, this.name, this.city, this.imgUrl, this.tags});

  final id;
  final name;
  final city;
  final imgUrl;
  final tags;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: <Widget>[
          Container(
            child: ClipRRect(
              child: Image.asset(
                "img/bg_tile.jpg",
                width: 80,
                height: 80,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            padding: EdgeInsets.all(8),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(
                    color: Colors.orange[600], fontSize: 16, height: 1.7),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Miasto: $city',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  Text(
                    'Opis...',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              )
            ],
          )
        ],
      ),
      color: Color.fromRGBO(50, 50, 50, 0.8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}

class MenuiSearchBar extends StatefulWidget {
  @override
  MenuiSearchBarState createState() {
    return MenuiSearchBarState();
  }
}

class MenuiSearchBarState extends State<MenuiSearchBar> {
  final _formKey = GlobalKey<FormState>();
  var suggestions = <String>[];
  bool suggestionsOpen = false;
  final LayerLink layerLink = LayerLink();
  OverlayEntry _overlayEntry;

  Future<void> fetchAutocomplete(text) async {
    final response = await http.get(
        'https://menui.azurewebsites.net/search/autocomplete?string=$text');
    final cities = jsonDecode(response.body)['cities'];
    final restaurants = jsonDecode(response.body)['restaurants'];
    final List<String> result = [...cities, ...restaurants];

    setState(() {
      suggestions = result;
    });

    if (!suggestionsOpen && result.isNotEmpty) {
      setState(() {
        suggestionsOpen = true;
      });
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry);
    }
    print(suggestions);
  }

  void hideSuggestions() {
    if (suggestionsOpen) {
      _overlayEntry.remove();
      setState(() {
        suggestionsOpen = false;
      });
    }
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;

    return OverlayEntry(
        builder: (context) => GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              hideSuggestions();
            },
            child: Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  children: [
                    Positioned(
                      width: size.width,
                      child: CompositedTransformFollower(
                        offset: Offset(0.0, size.height + 5.0),
                        link: layerLink,
                        showWhenUnlinked: false,
                        child: Material(
                          color: Colors.grey[800],
                          elevation: 4.0,
                          child: ConstrainedBox(
                            constraints: new BoxConstraints(maxHeight: 200),
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: suggestions.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                      suggestions[index],
                                      style: TextStyle(color: Colors.orange),
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ),
                    )
                  ],
                ))));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: CompositedTransformTarget(
          link: layerLink,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextFormField(
                  onChanged: (text) => fetchAutocomplete(text),
                  style: TextStyle(color: Colors.orange),
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.orange, width: 2.0),
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'Wyszukaj miasto lub nazwę restauracji.',
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.orange,
                      )),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Wpisz coś w pole wyszukiwania.';
                    }
                    return null;
                  },
                  cursorColor: Colors.orange,
                ),
              ),
            ],
          ),
        ));
  }
}
