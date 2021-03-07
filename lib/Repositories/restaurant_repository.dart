import 'dart:convert';

import 'package:flutter_auths/entity/restaurants_entity.dart';
import 'package:http/http.dart' as http;
class RestaurantRepository{
  static Future<Restaurants> fetchRestaurants(double lat,double lng) async {
    var url='https://developers.zomato.com/api/v2.1/geocode?lat=${lat}&lon=${lng}';
    var response = await http.get(
      url,
      headers: {'user-key': '1d63821dbb228ee5d09e8c8f7cfe10c3'}, //an example header
    );
    Restaurants restaurant=Restaurants.fromJson(jsonDecode(response.body));
    return restaurant;
  }
}