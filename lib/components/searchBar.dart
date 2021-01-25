import 'package:flutter/material.dart';
import '../services.dart';
import 'searchResults.dart';
import 'package:menui_mobile/localizations.dart';

class MenuiSearchBar extends StatefulWidget {
  final String initialValue;

  MenuiSearchBar(this.initialValue);

  @override
  MenuiSearchBarState createState() {
    return MenuiSearchBarState();
  }
}

class MenuiSearchBarState extends State<MenuiSearchBar> {
  final MenuiServices services = new MenuiServices();
  final _formKey = GlobalKey<FormState>();
  final LayerLink layerLink = LayerLink();
  OverlayEntry _overlayEntry;
  final _controller = TextEditingController();
  String previousText = '';

  MenuiSuggestions suggestions;
  bool suggestionsOpen = false;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue;
    _controller.addListener(fetchAutocomplete);
  }

  Future<void> fetchAutocomplete() async {
    if (_controller.text.isNotEmpty && _controller.text != previousText) {
      previousText = _controller.text;
      final MenuiSuggestions results =
          await services.fetchAutocomplete(_controller.text);
      setState(() {
        suggestions = results;
      });

      if (!suggestionsOpen && !results.suggestionsEmpty()) {
        setState(() {
          suggestionsOpen = true;
        });
        _overlayEntry = _createOverlayEntry();
        Overlay.of(context).insert(_overlayEntry);
      } else if (results.suggestionsEmpty()) {
        hideSuggestions();
      }
    } else {
      hideSuggestions();
    }
  }

  Future<void> searchRestaurantsByString() async {
    final List<Restaurant> results =
        await services.fetchSearchByString(_controller.text);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchResults(
                  restaurants: results,
                  initialText: _controller.text,
                )));
  }

  void hideSuggestions() {
    if (suggestionsOpen) {
      _overlayEntry.remove();
      setState(() {
        suggestions = new MenuiSuggestions.empty();
        suggestionsOpen = false;
      });
    }
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;

    return OverlayEntry(
        builder: (context) => GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
              hideSuggestions();
            },
            child: Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  children: [
                    Positioned(
                      width: size.width * 0.94,
                      child: CompositedTransformFollower(
                        offset: Offset(size.width * 0.03, size.height),
                        link: layerLink,
                        showWhenUnlinked: false,
                        child: Material(
                          color: Colors.grey[850],
                          borderRadius: BorderRadius.circular(20),
                          elevation: 4.0,
                          child: ConstrainedBox(
                            constraints: new BoxConstraints(maxHeight: 200),
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: suggestions.getLenght(),
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    onTap: () {
                                      _controller.text =
                                          suggestions.getSuggestion(index);
                                      searchRestaurantsByString();
                                    },
                                    leading: (() {
                                      if (suggestions.isCity(index)) {
                                        return Icon(
                                          Icons.location_city_rounded,
                                          color: Colors.grey,
                                        );
                                      } else {
                                        return Icon(
                                          Icons.fastfood_rounded,
                                          color: Colors.grey,
                                        );
                                      }
                                    }()),
                                    title: Text(
                                      suggestions.getSuggestion(index),
                                      style: TextStyle(color: Colors.grey),
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
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: TextFormField(
                  onFieldSubmitted: (text) => searchRestaurantsByString(),
                  controller: _controller,
                  style: TextStyle(color: Colors.orange, fontSize: 14),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[900],
                      hintStyle: TextStyle(color: Colors.grey[200]),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[900], width: 1.0),
                          borderRadius: BorderRadius.circular(16)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.orange, width: 2.0),
                          borderRadius: BorderRadius.circular(20)),
                      hintText: AppLocalizations.instance.text('searchbar'),
                      suffixIcon: IconButton(
                        onPressed: () => searchRestaurantsByString(),
                        icon: Icon(
                          Icons.search,
                          color: Colors.orange,
                        ),
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
