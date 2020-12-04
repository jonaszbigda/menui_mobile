import 'package:flutter/material.dart';
import '../services.dart';
import 'searchResults.dart';

class MenuiSearchBar extends StatefulWidget {
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

  var suggestions = <String>[];
  bool suggestionsOpen = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(fetchAutocomplete);
  }

  Future<void> fetchAutocomplete() async {
    if (_controller.text.isNotEmpty && _controller.text != previousText) {
      previousText = _controller.text;
      final List<String> results =
          await services.fetchAutocomplete(_controller.text);

      setState(() {
        suggestions = results;
      });

      if (!suggestionsOpen && results.isNotEmpty) {
        setState(() {
          suggestionsOpen = true;
        });
        _overlayEntry = _createOverlayEntry();
        Overlay.of(context).insert(_overlayEntry);
      } else if (results.isEmpty) {
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
            builder: (context) => SearchResults(restaurants: results)));
  }

  void hideSuggestions() {
    if (suggestionsOpen) {
      _overlayEntry.remove();
      setState(() {
        suggestions = [];
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
              FocusScopeNode currentFocus = FocusScope.of(context);
              print('12345');
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
                                itemCount: suggestions.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    onTap: () {
                                      _controller.text = suggestions[index];
                                      searchRestaurantsByString();
                                    },
                                    leading: Icon(
                                      Icons.search_rounded,
                                      color: Colors.grey,
                                    ),
                                    title: Text(
                                      suggestions[index],
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
                padding: const EdgeInsets.all(12),
                child: TextFormField(
                  controller: _controller,
                  style: TextStyle(color: Colors.orange),
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(16)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.orange, width: 2.0),
                          borderRadius: BorderRadius.circular(20)),
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