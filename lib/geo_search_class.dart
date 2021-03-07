class GeoSearchClass {
  String status;
  bool fromCache;
  List<Predictions> predictions;

  GeoSearchClass({this.status, this.fromCache, this.predictions});

  GeoSearchClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    fromCache = json['from_cache'];
    if (json['predictions'] != null) {
      predictions = new List<Predictions>();
      json['predictions'].forEach((v) {
        predictions.add(new Predictions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['from_cache'] = this.fromCache;
    if (this.predictions != null) {
      data['predictions'] = this.predictions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Predictions {
  String title;
  String description;
  String placeId;
  Location location;
  int distanceMeters;

  Predictions(
      {this.title,
        this.description,
        this.placeId,
        this.location,
        this.distanceMeters});

  Predictions.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    placeId = json['place_id'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    distanceMeters = json['distance_meters'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['place_id'] = this.placeId;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['distance_meters'] = this.distanceMeters;
    return data;
  }
}

class Location {
  double lat;
  double lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}