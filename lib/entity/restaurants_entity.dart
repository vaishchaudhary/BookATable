class Restaurants {
  Location location;
  Popularity popularity;
  String link;
  List<NearbyRestaurants> nearbyRestaurants;

  Restaurants(
      {this.location, this.popularity, this.link, this.nearbyRestaurants});

  Restaurants.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    popularity = json['popularity'] != null
        ? new Popularity.fromJson(json['popularity'])
        : null;
    link = json['link'];
    if (json['nearby_restaurants'] != null) {
      nearbyRestaurants = new List<NearbyRestaurants>();
      json['nearby_restaurants'].forEach((v) {
        nearbyRestaurants.add(new NearbyRestaurants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    if (this.popularity != null) {
      data['popularity'] = this.popularity.toJson();
    }
    data['link'] = this.link;
    if (this.nearbyRestaurants != null) {
      data['nearby_restaurants'] =
          this.nearbyRestaurants.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Location {
  String entityType;
  int entityId;
  String title;
  String latitude;
  String longitude;
  int cityId;
  String cityName;
  int countryId;
  String countryName;

  Location(
      {this.entityType,
        this.entityId,
        this.title,
        this.latitude,
        this.longitude,
        this.cityId,
        this.cityName,
        this.countryId,
        this.countryName});

  Location.fromJson(Map<String, dynamic> json) {
    entityType = json['entity_type'];
    entityId = json['entity_id'];
    title = json['title'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    cityId = json['city_id'];
    cityName = json['city_name'];
    countryId = json['country_id'];
    countryName = json['country_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['entity_type'] = this.entityType;
    data['entity_id'] = this.entityId;
    data['title'] = this.title;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['city_id'] = this.cityId;
    data['city_name'] = this.cityName;
    data['country_id'] = this.countryId;
    data['country_name'] = this.countryName;
    return data;
  }
}

class Popularity {
  String popularity;
  String nightlifeIndex;
  List<String> nearbyRes;
  List<String> topCuisines;
  String popularityRes;
  String nightlifeRes;
  String subzone;
  int subzoneId;
  String city;

  Popularity(
      {this.popularity,
        this.nightlifeIndex,
        this.nearbyRes,
        this.topCuisines,
        this.popularityRes,
        this.nightlifeRes,
        this.subzone,
        this.subzoneId,
        this.city});

  Popularity.fromJson(Map<String, dynamic> json) {
    popularity = json['popularity'];
    nightlifeIndex = json['nightlife_index'];
    nearbyRes = json['nearby_res'].cast<String>();
    topCuisines = json['top_cuisines'].cast<String>();
    popularityRes = json['popularity_res'];
    nightlifeRes = json['nightlife_res'];
    subzone = json['subzone'];
    subzoneId = json['subzone_id'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['popularity'] = this.popularity;
    data['nightlife_index'] = this.nightlifeIndex;
    data['nearby_res'] = this.nearbyRes;
    data['top_cuisines'] = this.topCuisines;
    data['popularity_res'] = this.popularityRes;
    data['nightlife_res'] = this.nightlifeRes;
    data['subzone'] = this.subzone;
    data['subzone_id'] = this.subzoneId;
    data['city'] = this.city;
    return data;
  }
}

class NearbyRestaurants {
  Restaurant restaurant;

  NearbyRestaurants({this.restaurant});

  NearbyRestaurants.fromJson(Map<String, dynamic> json) {
    restaurant = json['restaurant'] != null
        ? new Restaurant.fromJson(json['restaurant'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.restaurant != null) {
      data['restaurant'] = this.restaurant.toJson();
    }
    return data;
  }
}

class Restaurant {
  R r;
  String apikey;
  String id;
  String name;
  String url;
  LocationAddress location;
  int switchToOrderMenu;
  String cuisines;
  int averageCostForTwo;
  int priceRange;
  String currency;
  List<String> offers;
  int opentableSupport;
  int isZomatoBookRes;
  String mezzoProvider;
  int isBookFormWebView;
  String bookFormWebViewUrl;
  String bookAgainUrl;
  String thumb;
  UserRating userRating;
  String photosUrl;
  String menuUrl;
  String featuredImage;
  bool medioProvider;
  int hasOnlineDelivery;
  int isDeliveringNow;
  String storeType;
  bool includeBogoOffers;
  String deeplink;
  int isTableReservationSupported;
  int hasTableBooking;
  String eventsUrl;
  String orderUrl;
  String orderDeeplink;
  String bookUrl;

  Restaurant(
      {this.r,
        this.apikey,
        this.id,
        this.name,
        this.url,
        this.location,
        this.switchToOrderMenu,
        this.cuisines,
        this.averageCostForTwo,
        this.priceRange,
        this.currency,
        this.offers,
        this.opentableSupport,
        this.isZomatoBookRes,
        this.mezzoProvider,
        this.isBookFormWebView,
        this.bookFormWebViewUrl,
        this.bookAgainUrl,
        this.thumb,
        this.userRating,
        this.photosUrl,
        this.menuUrl,
        this.featuredImage,
        this.medioProvider,
        this.hasOnlineDelivery,
        this.isDeliveringNow,
        this.storeType,
        this.includeBogoOffers,
        this.deeplink,
        this.isTableReservationSupported,
        this.hasTableBooking,
        this.eventsUrl,
        this.orderUrl,
        this.orderDeeplink,
        this.bookUrl});

  Restaurant.fromJson(Map<String, dynamic> json) {
    r = json['R'] != null ? new R.fromJson(json['R']) : null;
    apikey = json['apikey'];
    id = json['id'];
    name = json['name'];
    url = json['url'];
    location = json['location'] != null
        ? new LocationAddress.fromJson(json['location'])
        : null;
    switchToOrderMenu = json['switch_to_order_menu'];
    cuisines = json['cuisines'];
    averageCostForTwo = json['average_cost_for_two'];
    priceRange = json['price_range'];
    currency = json['currency'];
    if (json['offers'] != null) {
      offers = new List<Null>();
      json['offers'].forEach((v) {
        offers.add(v);
      });
    }
    opentableSupport = json['opentable_support'];
    isZomatoBookRes = json['is_zomato_book_res'];
    mezzoProvider = json['mezzo_provider'];
    isBookFormWebView = json['is_book_form_web_view'];
    bookFormWebViewUrl = json['book_form_web_view_url'];
    bookAgainUrl = json['book_again_url'];
    thumb = json['thumb'];
    userRating = json['user_rating'] != null
        ? new UserRating.fromJson(json['user_rating'])
        : null;
    photosUrl = json['photos_url'];
    menuUrl = json['menu_url'];
    featuredImage = json['featured_image'];
    medioProvider = json['medio_provider'];
    hasOnlineDelivery = json['has_online_delivery'];
    isDeliveringNow = json['is_delivering_now'];
    storeType = json['store_type'];
    includeBogoOffers = json['include_bogo_offers'];
    deeplink = json['deeplink'];
    isTableReservationSupported = json['is_table_reservation_supported'];
    hasTableBooking = json['has_table_booking'];
    eventsUrl = json['events_url'];
    orderUrl = json['order_url'];
    orderDeeplink = json['order_deeplink'];
    bookUrl = json['book_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.r != null) {
      data['R'] = this.r.toJson();
    }
    data['apikey'] = this.apikey;
    data['id'] = this.id;
    data['name'] = this.name;
    data['url'] = this.url;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['switch_to_order_menu'] = this.switchToOrderMenu;
    data['cuisines'] = this.cuisines;
    data['average_cost_for_two'] = this.averageCostForTwo;
    data['price_range'] = this.priceRange;
    data['currency'] = this.currency;
    if (this.offers != null) {
      data['offers'] = this.offers.map((v) => v).toList();
    }
    data['opentable_support'] = this.opentableSupport;
    data['is_zomato_book_res'] = this.isZomatoBookRes;
    data['mezzo_provider'] = this.mezzoProvider;
    data['is_book_form_web_view'] = this.isBookFormWebView;
    data['book_form_web_view_url'] = this.bookFormWebViewUrl;
    data['book_again_url'] = this.bookAgainUrl;
    data['thumb'] = this.thumb;
    if (this.userRating != null) {
      data['user_rating'] = this.userRating.toJson();
    }
    data['photos_url'] = this.photosUrl;
    data['menu_url'] = this.menuUrl;
    data['featured_image'] = this.featuredImage;
    data['medio_provider'] = this.medioProvider;
    data['has_online_delivery'] = this.hasOnlineDelivery;
    data['is_delivering_now'] = this.isDeliveringNow;
    data['store_type'] = this.storeType;
    data['include_bogo_offers'] = this.includeBogoOffers;
    data['deeplink'] = this.deeplink;
    data['is_table_reservation_supported'] = this.isTableReservationSupported;
    data['has_table_booking'] = this.hasTableBooking;
    data['events_url'] = this.eventsUrl;
    data['order_url'] = this.orderUrl;
    data['order_deeplink'] = this.orderDeeplink;
    data['book_url'] = this.bookUrl;
    return data;
  }
}

class R {
  int resId;
  bool isGroceryStore;
  // HasMenuStatus hasMenuStatus;

  R({this.resId, this.isGroceryStore});

  R.fromJson(Map<String, dynamic> json) {
    resId = json['res_id'];
    isGroceryStore = json['is_grocery_store'];
    // hasMenuStatus = json['has_menu_status'] != null
    //     ? new HasMenuStatus.fromJson(json['has_menu_status'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['res_id'] = this.resId;
    data['is_grocery_store'] = this.isGroceryStore;
    // if (this.hasMenuStatus != null) {
    //   data['has_menu_status'] = this.hasMenuStatus.toJson();
    // }
    return data;
  }
}

// class HasMenuStatus {
//   int delivery;
//   bool takeaway;
//
//   HasMenuStatus({this.delivery, this.takeaway});
//
//   // HasMenuStatus.fromJson(Map<String, dynamic> json) {
//   //   delivery = json['delivery'];
//   //   takeaway = json['takeaway'];
//   // }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['delivery'] = this.delivery;
//     data['takeaway'] = this.takeaway;
//     return data;
//   }
// }

class LocationAddress {
  String address;
  String locality;
  String city;
  int cityId;
  String latitude;
  String longitude;
  String zipcode;
  int countryId;
  String localityVerbose;

  LocationAddress(
      {this.address,
        this.locality,
        this.city,
        this.cityId,
        this.latitude,
        this.longitude,
        this.zipcode,
        this.countryId,
        this.localityVerbose});

  LocationAddress.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    locality = json['locality'];
    city = json['city'];
    cityId = json['city_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    zipcode = json['zipcode'];
    countryId = json['country_id'];
    localityVerbose = json['locality_verbose'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['locality'] = this.locality;
    data['city'] = this.city;
    data['city_id'] = this.cityId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['zipcode'] = this.zipcode;
    data['country_id'] = this.countryId;
    data['locality_verbose'] = this.localityVerbose;
    return data;
  }
}

class UserRating {
  String aggregateRating;
  String ratingText;
  String ratingColor;
  RatingObj ratingObj;
  int votes;

  UserRating(
      {this.aggregateRating,
        this.ratingText,
        this.ratingColor,
        this.ratingObj,
        this.votes});

  UserRating.fromJson(Map<String, dynamic> json) {
    aggregateRating = json['aggregate_rating'];
    ratingText = json['rating_text'];
    ratingColor = json['rating_color'];
    ratingObj = json['rating_obj'] != null
        ? new RatingObj.fromJson(json['rating_obj'])
        : null;
    votes = json['votes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aggregate_rating'] = this.aggregateRating;
    data['rating_text'] = this.ratingText;
    data['rating_color'] = this.ratingColor;
    if (this.ratingObj != null) {
      data['rating_obj'] = this.ratingObj.toJson();
    }
    data['votes'] = this.votes;
    return data;
  }
}

class RatingObj {
  Title title;
  BgColor bgColor;

  RatingObj({this.title, this.bgColor});

  RatingObj.fromJson(Map<String, dynamic> json) {
    title = json['title'] != null ? new Title.fromJson(json['title']) : null;
    bgColor = json['bg_color'] != null
        ? new BgColor.fromJson(json['bg_color'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.title != null) {
      data['title'] = this.title.toJson();
    }
    if (this.bgColor != null) {
      data['bg_color'] = this.bgColor.toJson();
    }
    return data;
  }
}

class Title {
  String text;

  Title({this.text});

  Title.fromJson(Map<String, dynamic> json) {
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    return data;
  }
}

class BgColor {
  String type;
  String tint;

  BgColor({this.type, this.tint});

  BgColor.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    tint = json['tint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['tint'] = this.tint;
    return data;
  }
}