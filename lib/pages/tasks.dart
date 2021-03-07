import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auths/Blocs/fetch_restaurant_bloc.dart';
import 'package:flutter_auths/controllers/authentications.dart';
import 'package:flutter_auths/entity/restaurants_entity.dart';
import 'package:flutter_auths/pages/profile_page.dart';
import 'package:flutter_auths/pages/restaurant_detail_page.dart';
import 'package:flutter_auths/utils/helper.dart';
import 'package:flutter_auths/widgets/restaurant_network_image.dart';
import 'package:flutter_auths/widgets/search_loaction.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';

import 'loginScreen.dart';

class MyTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant App',
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
   restaurantBloc.fetchRestaurants(appLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 25.0, top: 45.0, right: 25.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    child: CircleAvatar(
                      radius: 20,
                     backgroundColor: Colors.white,
                     child: Icon(
                       Icons.account_circle,
                       size: 40,
                       color: Colors.orange.shade700,
                     ),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Book A Table",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.logout,
                      size: 30,
                      color: Colors.grey,
                    ),
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
                            builder: (context) => GeoSearchApi(
                                  fetchRestaurants: fetchRestaurants,
                                )));
                  },
                  child: textWidget()),
              // SizedBox(
              //   height: 10.0,
              // ),
              // Container(
              //   height: 40.0,
              //   margin: EdgeInsets.only(bottom: 10),
              //   child: ListView(
              //     scrollDirection: Axis.horizontal,
              //     children: <Widget>[
              //       buildTopChip("healthy", true),
              //       buildTopChip("italian", false),
              //       buildTopChip("mexican", false),
              //       buildTopChip("asian", false),
              //       buildTopChip("chinese", false),
              //       buildTopChip("haitian", false),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
        BlocBuilder(
            bloc: restaurantBloc,
            builder: (context, state) {
              if (state != null && state.status == Status.completed) {
                textController.text = appLocation.title;
                Restaurants restaurants = state.data;
                if(restaurants?.nearbyRestaurants!=null) {
                  return Container(
                    child: Expanded(
                        child:
                        ListView.builder(
                          itemCount: restaurants.nearbyRestaurants.length,
                          itemBuilder: (context, index) {
                            return buildItemWidget(
                                restaurants.nearbyRestaurants[index]
                                    .restaurant);
                          },
                        )),
                  );
                }else{
                  return Container();
                }
              }
              else if (state != null && state.status == Status.error) {
                textController.text = appLocation.title;
                return Container();
              } else if (state != null && state.status == Status.loading) {
                textController.text = appLocation.title;
                return Container(
                  height: 500,
                  child: Center(
                    child: Loading(
                        indicator: BallPulseIndicator(),
                        size: 100.0,
                        color: Colors.lightBlueAccent),
                  ),
                );
              } else {
                return Container();
              }
            })
      ],
    )));
  }

  Widget buildItemWidget(Restaurant restaurantDetail) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RestaurantDetailPage(
                      restaurantDetail: restaurantDetail,
                    )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 12.0),
        padding: EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: <Widget>[
            Hero(
              tag: 'image-${restaurantDetail.id}',
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                ),
                child:  restaurantDetail.featuredImage!=null?
                CachedNetworkImage(
                  imageUrl: restaurantDetail.featuredImage,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => LinearProgressIndicator(
                    backgroundColor: Colors.orange.shade200,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  errorWidget: (context, url, error) => Image(
                    image: AssetImage('assets/bookATableLogo.jpg'),
                    fit: BoxFit.cover,
                    // height:  200,
                  ),
                ):AssetImage('assets/bookATableLogo.jpg'),
              ),
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
                        restaurantDetail.name.length > 20
                            ? '${restaurantDetail.name.substring(0, 20)}...'
                            : restaurantDetail.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                      Text(
                        restaurantDetail.location.address.length > 40
                            ? '${restaurantDetail.location.address.substring(0, 40)}...'
                            : restaurantDetail.location.address,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0,
                            color: Colors.grey),
                      ),
                      Text(
                        'Book a table in just \u{20B9}${restaurantDetail.averageCostForTwo}',
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
                      restaurantDetail.userRating.aggregateRating,
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
        padding: EdgeInsets.only(left: 8.0, right: 8.0),
        label: Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        backgroundColor: isActive ? Colors.orange : Colors.grey,
      ),
    );
  }

  void fetchRestaurants(SearchLocation location) {
    setState(() {
      textController.text = appLocation.title;
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


