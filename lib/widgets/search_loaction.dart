import 'dart:convert';
import 'package:flutter_auths/Blocs/fetch_restaurant_bloc.dart';
import 'package:flutter_auths/utils/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoder/geocoder.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:search_page/search_page.dart';
// import 'package:weather_api_example/home_page.dart';

import '../geo_search_class.dart';

class GeoSearchApi extends StatefulWidget {
  final Function fetchRestaurants;
  GeoSearchApi({Key key, this.fetchRestaurants}) : super(key: key);

  @override
  _GeoSearchApiState createState() => _GeoSearchApiState();
}

class _GeoSearchApiState extends State<GeoSearchApi> {
  var response;
  GeoSearchClass geoSearchClass;
  List<Predictions> predictions;
  String place = 'agra';
  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
    _textEditingController = TextEditingController();
    _textEditingController.text=appLocation.title;
    place=appLocation.title;
    fetchData();
  }

  TextEditingController _textEditingController;

  Future<void> fetchData() async {
    final response = await http.get(
        'https://geoproxy.dev.iamplus.services/search?input=' +
            place +
            '&location=0,0');

    if (response.statusCode == 200) {
      geoSearchClass = GeoSearchClass.fromJson(jsonDecode(response.body));
      predictions = geoSearchClass.predictions;
      setState(() {
        geoSearchClass = GeoSearchClass.fromJson(jsonDecode(response.body));
        predictions = geoSearchClass.predictions;
      });
    }
    // } else {
    //   throw Exception('Failed to load album');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Page'),
      ),
      body: Column(children: [
        Container(
          child: TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(Icons.search),
                hintText: 'Search a location'),
            controller: _textEditingController,
            onChanged: (text) {
              place = text;
              fetchData();
            },
            onSubmitted: (text) {
              setState(() {
                place = text;
              });
            },
          ),
        ),
        if (predictions != null)
          Expanded(
            child: ListView.builder(
                itemCount: geoSearchClass.predictions != null
                    ? geoSearchClass.predictions.length
                    : 0,
                itemBuilder: (context, index) {
                  final Predictions result = geoSearchClass.predictions != null
                      ? predictions[index]
                      : null;
                  if (result != null)
                    return ListTile(
                        title: Text(result.title),
                        subtitle: Text(result.description),
                        trailing: Text('${result.distanceMeters.toString()}'),
                        onTap: ()  async {
                          print(
                            'lat long ${result?.location?.lat} ${result?.location?.lat}'
                          );
                          final query = "${result.title}";
                          var response = await Geocoder.local.findAddressesFromQuery(query);
                          print('reponse lat long ${response.first.coordinates.latitude} ${response.first.coordinates.longitude}');
                          setState(() {
                            appLocation = SearchLocation(response.first.coordinates.latitude,
                                response.first.coordinates.longitude, result.title, result.description);
                          //  getLocationFromPlace(result.title,result.description,context);
                          });
                          widget.fetchRestaurants(appLocation);
                          Navigator.pop(context);

                        });
                }),
          ),
        if(geoSearchClass != null&&predictions==null)
          Container(
            child: Text('Unable to fetch results'),
          ),
        if (geoSearchClass == null)
          Container(
            color: Colors.white,
            child: Center(
              child: Loading(
                  indicator: BallPulseIndicator(),
                  size: 100.0,
                  color: Colors.orange),
            ),
          ),

      ]),
    );
  }
}