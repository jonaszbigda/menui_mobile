import 'package:flutter/material.dart';
import '../services.dart';
import 'lineOfIcons.dart';
import 'dishList.dart';
import 'socialMedia.dart';

class RestaurantView extends StatelessWidget {
  final String id;
  final MenuiServices services = new MenuiServices();

  RestaurantView({@required this.id});

  @override
  Widget build(BuildContext context) {
    services.fetchAllDishes(id);
    List<String> categories = [];
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(color: Colors.grey[850]),
            child: FutureBuilder<Restaurant>(
              future: services.fetchRestaurant(id),
              builder:
                  (BuildContext context, AsyncSnapshot<Restaurant> snapshot) {
                if (snapshot.hasData) {
                  final Restaurant restaurant = snapshot.data;
                  categories = restaurant.categories;
                  return Column(
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
                                      color: Colors.grey[850],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        restaurant.name,
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.orange,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Text(
                                        restaurant.city,
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                                  margin: EdgeInsets.all(12),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 12),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[850],
                                      borderRadius: BorderRadius.circular(30)),
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.map,
                                        color: Colors.orange,
                                      ),
                                      onPressed: () {}),
                                )
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  vertical: 4, horizontal: 12),
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
                            Text(
                              'Informacje',
                              style:
                                  TextStyle(color: Colors.orange, fontSize: 14),
                            ),
                            SizedBox(
                              height: 12,
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
                              style:
                                  TextStyle(color: Colors.orange, fontSize: 14),
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
                              style:
                                  TextStyle(color: Colors.orange, fontSize: 14),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            SocialMedia(links: restaurant.links),
                            SizedBox(
                              height: 12,
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showMenu(context, categories);
          },
          label: Text(
            'Menu',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
          ),
          icon: Icon(
            Icons.arrow_upward_rounded,
            color: Colors.orange,
          ),
          backgroundColor: Colors.grey[900],
        ));
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
              id: id,
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
    return Padding(
        padding: EdgeInsets.all(6),
        child: Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: background(),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Column(
            children: <Widget>[
              Text(
                day,
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              Divider(
                height: 4,
                thickness: 2,
                color: Colors.white,
              ),
              Text(
                formatTodayHours(workingHours),
                style: TextStyle(color: Colors.white, fontSize: 11),
              )
            ],
          ),
        ));
  }
}

class WorkingHoursList extends StatelessWidget {
  final MenuiWorkingHours workingHours;
  WorkingHoursList({@required this.workingHours});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WorkingHoursDay('Pn', workingHours.pn, 1),
            WorkingHoursDay('Wt', workingHours.wt, 2),
            WorkingHoursDay('Śr', workingHours.sr, 3),
            WorkingHoursDay('Cz', workingHours.cz, 4),
          ],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          WorkingHoursDay('Pt', workingHours.pt, 5),
          WorkingHoursDay('So', workingHours.sb, 6),
          WorkingHoursDay('Nd', workingHours.nd, 7),
        ])
      ],
    );
  }
}
