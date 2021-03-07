import 'package:geocoder/geocoder.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';

import '../geo_search_class.dart';

class FoodItem{
  String name,time,type,price,image;
  FoodItem(this.name,this.time,this.type,this.price,this.image);
}

class CartItem{
  String name,count,price,image;
  CartItem(this.name,this.count,this.price,this.image);
}

class CouponItem{
  String image,code,name,description;
  CouponItem(this.image,this.code,this.name,this.description);
}

class Food{
  String image,name,type,discount,coupon,rating,time,price;
  Food(this.image,this.name,this.type,this.discount,this.coupon,this.rating,this.time,this.price);
}
class BuildItem{
  String name;
  String desc;
  String image;
  double rating;
  double price;

  BuildItem(this.name, this.desc, this.image,this.rating, this.price);
}

class Payment{
  String image,name;
  Payment(this.image,this.name);
}

class DailyFood{
  List dailyFoodItemList;
  String status;

  DailyFood(this.dailyFoodItemList,this.status);
}

class DailyFoodItem{
  String image,name,type;
  DailyFoodItem(this.image,this.name,this.type);
}

class Plan{
  String price,validity;
  List planMenu;
  Plan(this.price,this.validity,this.planMenu);
}

class PlanMenu{
  String name,count;
  PlanMenu(this.name,this.count);
}

List titles = ['Food', 'Domestic', 'Entertainment', 'Contact'];
List items = [
  new FoodItem('Chicken Burger', '15 min', 'Burger', '25', 'img/hamburger.png'),
  new FoodItem('Icecream', '2 min', 'Dessert', '20', 'img/icecream.png'),
  new FoodItem('Cookies', '25 min', 'Starter', '10', 'img/cookie.png'),
  new FoodItem('Bread Toast', '10 min', 'Breakfast', '5', 'img/breakfast.png')
];


List <BuildItem> buildItemsList=[
 new BuildItem(
    "Joe's Linder",
      "123 reviews = S. Oxford 13th",
     "https://images.pexels.com/photos/3676531/pexels-photo-3676531.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
      4.5,
      10
 ),
  new BuildItem(
      "Mama's brunch",
      "98 reviews = S. Gulier 6th",
      "https://images.pexels.com/photos/1147993/pexels-photo-1147993.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
      4.5,
      20
  ),
  new BuildItem(
      "Joe's Linder",
      "123 reviews = S. Oxford 13th",
      "https://images.pexels.com/photos/842571/pexels-photo-842571.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
      4.5,
      30
  ),
];

List cart = [];

int price = 0;
int discount = 0;
int planSelected = 0;
int totalPoints = 0;
int currentIndex = 0;

List studentPlanList = [];
List employeePlanList= [];
List othersPlanList = [];
SearchLocation appLocation;

class SearchLocation {
  double lat,long;
  String title,description;

  SearchLocation(this.lat, this.long, this.title, this.description);
}

String uID = "";
String planName = "";
String planPrice = "";
String planValidity = "";
String menuToday = "0";
String currentAddress = "";

List dailyFoodList = [];
void showGetDirectionMap() async {
  try {
    final availableMaps = await MapLauncher.installedMaps;
    print(availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

    await availableMaps.first.showMarker(
      coords: Coords(31.233568, 121.505504),
      title: "Shanghai Tower",
      description: "Asia's tallest building",
    );
    if (await MapLauncher.isMapAvailable(MapType.google)) {
      await MapLauncher.launchMap(
        mapType: MapType.google,
        coords: Coords(31.233568, 121.505504),
        title: 'address',
        description: 'restaurant address',
      );
    }
  } on Exception {
    // Scaffold.of(context)
    //     .showSnackBar(SnackBar(content: Text('Error launching Map')));
  }

}
void getLocationFromPlace(String placeTitle, String placeDesc, BuildContext context) async {
  print('reponse1 title long ${placeTitle} ${placeDesc}');
  final query = "$placeTitle";
    var response = await Geocoder.local.findAddressesFromQuery(query);
    print('reponse lat long ${response.first.coordinates.latitude} ${response.first.coordinates.longitude}');
    appLocation = SearchLocation(response.first.coordinates.latitude,
        response.first.coordinates.longitude, placeTitle, placeDesc);
    Navigator.pop(context);

}
enum Status {
  completed,
  loading,
  error
}
