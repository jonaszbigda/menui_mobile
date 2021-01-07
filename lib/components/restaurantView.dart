import 'package:flutter/material.dart';
import '../services.dart';
import 'lineOfIcons.dart';
import 'dishList.dart';
import 'socialMedia.dart';
import 'restaurantMapView.dart';
import 'orderView.dart';
import 'favoritesView.dart';
import '../settings.dart';
import 'homeScreen.dart';
import 'package:share/share.dart';
import 'favoriteButton.dart';
import 'menuiButton.dart';

class RestaurantView extends StatefulWidget {
  final String id;

  RestaurantView({@required this.id, Key key}) : super(key: key);

  _RestaurantViewState createState() => _RestaurantViewState();
}

class _RestaurantViewState extends State<RestaurantView> {
  final MenuiServices services = new MenuiServices();
  final MenuiSettings settings = new MenuiSettings();
  Restaurant restaurant = new Restaurant.empty();

  @override
  Widget build(BuildContext context) {
    List<String> categories = [];
    return FutureBuilder<Restaurant>(
        future: services.fetchRestaurant(widget.id),
        builder: (BuildContext context, AsyncSnapshot<Restaurant> snapshot) {
          if (snapshot.hasData) {
            restaurant = snapshot.data;
            categories = restaurant.categories;
            return Scaffold(
              body: Container(
                decoration: BoxDecoration(color: Colors.grey[850]),
                child: ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    restaurant.imgUrl,
                                  ),
                                  fit: BoxFit.cover)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 160,
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[900],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          restaurant.name,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.orange,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        Text(
                                          restaurant.city,
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        )
                                      ],
                                    ),
                                    margin: EdgeInsets.all(12),
                                  ),
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              )
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(color: Colors.grey[850]),
                          child: Column(
                            children: <Widget>[
                              LineOfIcons(
                                tags: restaurant.tags,
                              ),
                              Divider(
                                height: 14,
                                thickness: 4,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 20),
                                child: Text(
                                  restaurant.description,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey[300]),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Divider(
                                height: 14,
                                thickness: 4,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Informacje',
                                style: TextStyle(
                                    color: Colors.orange, fontSize: 14),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              MenuiDoubleColorText(
                                leading: 'Kuchnia: ',
                                following: '${restaurant.type}',
                              ),
                              MenuiDoubleColorText(
                                leading: 'Adres: ',
                                following:
                                    '${restaurant.city}, ${restaurant.adress}',
                              ),
                              MenuiDoubleColorText(
                                leading: 'Kontakt: ',
                                following: '${restaurant.phone}',
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                'Godziny otwarcia',
                                style: TextStyle(
                                    color: Colors.orange, fontSize: 14),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              WorkingHoursList(
                                  workingHours: restaurant.workingHours),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                'Social media',
                                style: TextStyle(
                                    color: Colors.orange, fontSize: 14),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              SocialMedia(links: restaurant.links),
                              SizedBox(
                                height: 6,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 80,
                        )
                      ],
                    )
                  ],
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton.icon(
                          splashColor: Colors.orange,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          color: Colors.grey[900],
                          icon: Icon(
                            Icons.keyboard_arrow_up_rounded,
                            color: Colors.orange,
                          ),
                          label: Text(
                            "Karta dań",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () =>
                              showMenu(context, restaurant.categories),
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.grey[900]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        MenuiButton(
                          color: Colors.orange,
                          icon: Icons.home_rounded,
                          text: "Szukaj",
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage())),
                        ),
                        MenuiButton(
                          color: Colors.orange,
                          icon: Icons.note_rounded,
                          text: "Zamównienie",
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderView())),
                        ),
                        MenuiButton(
                          color: Colors.orange,
                          icon: Icons.favorite_rounded,
                          text: "Ulubione",
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FavoritesView())),
                        ),
                        MenuiButton(
                          color: Colors.orange,
                          icon: Icons.settings,
                          text: "Ustawienia",
                          onPressed: () {
                            showSettings(context, settings);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              appBar: AppBar(
                backgroundColor: Colors.grey[900],
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.orange,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                actions: [
                  MenuiButton(
                    color: Colors.grey,
                    icon: Icons.map_rounded,
                    text: "Mapa",
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RestaurantMapView(
                                  coordinates: restaurant.coordinates,
                                  name: restaurant.name,
                                  type: restaurant.type,
                                ))),
                  ),
                  MenuiButton(
                    color: Colors.grey,
                    icon: Icons.share_rounded,
                    text: "Udostępnij",
                    onPressed: () => Share.share(
                        'https://www.menui.pl/restaurant/${restaurant.id}',
                        subject: '${restaurant.name}'),
                  ),
                  FavoriteButton(
                    id: restaurant.id,
                  )
                ],
              ),
            );
          } else {
            return Scaffold(
                body: Container(
              decoration: BoxDecoration(color: Colors.grey[850]),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ));
          }
        });
  }

  showMenu(BuildContext context, List<String> categories) {
    if (categories.isNotEmpty) {
      showModalBottomSheet(
          backgroundColor: Colors.grey[850],
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return DishList(
              categories: categories,
              id: widget.id,
            );
          });
    }
  }
}

class MenuiDoubleColorText extends StatelessWidget {
  final String leading;
  final String following;

  MenuiDoubleColorText({@required this.leading, @required this.following});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2),
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
              text: leading,
              style: TextStyle(color: Colors.grey, fontSize: 12)),
          TextSpan(
              text: following,
              style: TextStyle(color: Colors.grey[300], fontSize: 12))
        ]),
      ),
    );
  }
}

class WorkingHoursDay extends StatelessWidget {
  final String day;
  final String workingHours;
  final int index;

  WorkingHoursDay(this.day, this.workingHours, this.index);

  String formatTodayHours(String hours) {
    if (hours == "") {
      return 'nieczynne';
    } else {
      return hours;
    }
  }

  background() {
    final DateTime now = DateTime.now();
    if (now.weekday == this.index) {
      return Colors.orange;
    } else {
      return Colors.grey[700];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 80),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: background(),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Column(
        children: <Widget>[
          Text(
            day,
            style:
                TextStyle(fontWeight: FontWeight.w300, color: Colors.grey[200]),
          ),
          SizedBox(
            height: 4,
          ),
          Divider(
            height: 4,
            thickness: 1,
            color: Colors.white,
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            formatTodayHours(workingHours),
            style: TextStyle(color: Colors.white, fontSize: 11),
          )
        ],
      ),
    );
  }
}

class WorkingHoursList extends StatelessWidget {
  final MenuiWorkingHours workingHours;
  WorkingHoursList({@required this.workingHours});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      alignment: WrapAlignment.center,
      children: <Widget>[
        WorkingHoursDay('Pn', workingHours.pn, 1),
        WorkingHoursDay('Wt', workingHours.wt, 2),
        WorkingHoursDay('Śr', workingHours.sr, 3),
        WorkingHoursDay('Cz', workingHours.cz, 4),
        WorkingHoursDay('Pt', workingHours.pt, 5),
        WorkingHoursDay('So', workingHours.sb, 6),
        WorkingHoursDay('Nd', workingHours.nd, 7),
      ],
    );
  }
}
