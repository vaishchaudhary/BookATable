import 'package:flutter_auths/utils/helper.dart';

class RestaurantEvents{
 const RestaurantEvents();
}
class FetchRestauarntEvent extends RestaurantEvents{
  SearchLocation searchLocation;
  FetchRestauarntEvent(this.searchLocation);
}
class AddLoader extends RestaurantEvents{
  AddLoader();
}