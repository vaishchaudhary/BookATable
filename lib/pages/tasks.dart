import 'package:flutter/material.dart';
import 'package:flutter_auths/Blocs/fetch_restaurant_bloc.dart';
import 'package:flutter_auths/Blocs/states/restaurant_states.dart';
import 'package:flutter_auths/controllers/authentications.dart';
import 'package:flutter_auths/entity/restaurants_entity.dart';
import 'package:flutter_auths/utils/helper.dart';
import 'package:flutter_auths/widgets/payment_gateway.dart';
import 'package:flutter_auths/widgets/search_loaction.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'loginScreen.dart';

class MyTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: BlocProvider<RestaurantBloc>(
        create: (context) => RestaurantBloc(),
        child: HomePage1(),
      ),
    );
  }
}

class HomePage1 extends StatefulWidget {
  @override
  _HomePage1State createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  TextEditingController textController;
  RestaurantBloc restaurantBloc;

  @override
  void initState() {
    restaurantBloc = BlocProvider.of<RestaurantBloc>(context);
    textController = TextEditingController();
    appLocation = SearchLocation(27.1767, 78.0081, 'Agra', 'dayalbagh,agra');
    textController.text = appLocation.title;
    restaurantBloc.fetchRestaurants(SearchLocation(27.1767, 78.0081, 'Agra', 'dayalbagh,agra'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
                  child: Column(
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.only(left: 25.0, top: 45.0, right: 25.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Book A Table",
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            InkWell(
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://images.pexels.com/photos/2787310/pexels-photo-2787310.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260"),
                              ),
                              onTap: () {
                                signOutUser().then((value) {
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()),
                                    (Route<dynamic> route) => false,
                                  );
                                });
                              },
                            )
                          ],
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GeoSearchApi(fetchRestaurants: fetchRestaurants,)));
                            },
                            child: textWidget()),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          height: 40.0,
                          margin: EdgeInsets.only(bottom: 10),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              buildTopChip("healthy", true),
                              buildTopChip("italian", false),
                              buildTopChip("mexican", false),
                              buildTopChip("asian", false),
                              buildTopChip("chinese", false),
                              buildTopChip("haitian", false),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
        BlocBuilder(
            bloc: restaurantBloc,
            builder: (context, state) {
              if(state!=null&&state.status==Status.completed) {
                textController.text=appLocation.title;
                Restaurants restaurants=state.data;
                return
                  Container(
                    child: Expanded(
                        child: ListView.builder(
                          itemCount: restaurants.nearbyRestaurants.length,
                          itemBuilder: (context, index) {
                            return buildItemWidget(
                              restaurants.nearbyRestaurants[index].restaurant.name,
                              restaurants.nearbyRestaurants[index].restaurant.location.address,
                              restaurants.nearbyRestaurants[index].restaurant.featuredImage,
                            double.parse( restaurants.nearbyRestaurants[index].restaurant.userRating.aggregateRating),
                              10.0,
                            );
                          },
                        )),
                  );
              }
              else if(state!=null&&state.status==Status.error) {
                textController.text=appLocation.title;
                return Container();
              }
              else if(state!=null&&state.status==Status.loading) {
                textController.text=appLocation.title;
                return
                  Container(
                    height: 500,
                    child: Center(
                    child: Loading(
                        indicator: BallPulseIndicator(),
                        size: 100.0,
                        color: Colors.lightBlueAccent),
                ),
                  );
              }
              else {
                return Container();
              }
            })
                ],
              ))
            );
  }

  Widget buildItemWidget(
      String title, String subTitle, String url, double rating, double price) {
    return InkWell(
      onTap: () {
// showGetDirectionMap();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PayMentGayWay()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 12.0),
        padding: EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: url!=null?NetworkImage(
                        url,
                    ):AssetImage('assets/bookATableLogo.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  )),
            ),
            Container(
              padding: EdgeInsets.all(25.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2.0, spreadRadius: 1.0, color: Colors.grey)
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                         Text(
                           title.length>20?'${title.substring(0,20)}...':title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),

                      Text(
                        subTitle.length>40?'${subTitle.substring(0,40)}...':subTitle,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0,
                            color: Colors.grey),
                      ),
                      Text(
                        'Book a table in just \u{20B9}${price}',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12.0,
                            color: Colors.orangeAccent),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.orange,
                    child: Text(
                      rating.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildTopChip(String label, bool isActive) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: Chip(
        padding: EdgeInsets.only(left:8.0,right: 8.0),
        label: Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        backgroundColor: isActive ? Colors.orange : Colors.grey,
      ),
    );
  }
  void fetchRestaurants(SearchLocation location){
   setState(() {
      textController.text=appLocation.title;
   });
    restaurantBloc.fetchRestaurants(location);
  }
  textWidget() {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
       margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.search,
                size: 20,
                color: Colors.black,
              ),
              Expanded(
                child: Text(
                  '${appLocation.title ?? 'Agra'}',
                  style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 1.5,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          Divider(
            thickness: 2,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
