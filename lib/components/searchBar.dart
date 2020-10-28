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

  var suggestions = <String>[];
  bool suggestionsOpen = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(fetchAutocomplete);
  }

  Future<void> fetchAutocomplete() async {
    if (_controller.text.isNotEmpty) {
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
      print(suggestions);
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
                                    onTap: () {
                                      _controller.text = suggestions[index];
                                      searchRestaurantsByString();
                                    },
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
                  //onChanged: (text) => fetchAutocomplete(text),
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
