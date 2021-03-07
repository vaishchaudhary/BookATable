import 'package:flutter_auths/Blocs/events/restaurant_events.dart';
import 'package:flutter_auths/Blocs/states/restaurant_states.dart';
import 'package:flutter_auths/Repositories/restaurant_repository.dart';
import 'package:flutter_auths/utils/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantBloc
    extends Bloc<RestaurantEvents, RestaurantStates> {
 // final RestaurantOrderApiRepository _restaurantorderRepository;

  RestaurantBloc() : super(RestaurantStates(status:Status.loading,event:null,data:null));

  void fetchRestaurants(SearchLocation location) {
    add(FetchRestauarntEvent(location));
  }

  @override
  Stream<RestaurantStates> mapEventToState(
      RestaurantEvents event) async* {
    if (event is FetchRestauarntEvent) {
     try
      {
        yield RestaurantStates(status:Status.loading,event:event,data:null);
        double lat=event.searchLocation.lat;
        double lng=event.searchLocation.long;
        var restaurantList=await RestaurantRepository.fetchRestaurants(lat, lng);
        if (restaurantList!=null) {
          yield RestaurantStates(status:Status.completed,event:event,data:restaurantList);
        } else {
          yield RestaurantStates(status:Status.error,event:event,data:null);        }
      }
      on Error catch(err){
        print('Something Went wrong ${err}');
        yield RestaurantStates(status:Status.error,event:event,data:null);      } on Exception catch(error){
      }
    }
  }
}