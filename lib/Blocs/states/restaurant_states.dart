import 'package:flutter_auths/Blocs/events/restaurant_events.dart';
import 'package:flutter_auths/utils/helper.dart';

class RestaurantStates{
   Status status;
 RestaurantEvents event;
  dynamic data;

  RestaurantStates({this.status, this.event, this.data});
}