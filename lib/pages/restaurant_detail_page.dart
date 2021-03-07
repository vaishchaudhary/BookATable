import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auths/entity/restaurants_entity.dart';
import 'package:flutter_auths/utils/helper.dart';
import 'package:flutter_auths/widgets/payment_gateway.dart';
import 'package:url_launcher/url_launcher.dart';

class RestaurantDetailPage extends StatefulWidget {
  final Restaurant restaurantDetail;

  const RestaurantDetailPage({Key key, this.restaurantDetail})
      : super(key: key);

  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  GlobalKey<ScaffoldState> globalKey=GlobalKey();
  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          key: globalKey,
      backgroundColor: Colors.white,
      body: Container(
          child: ListView(
        children: [
          topButtonsHeader(onPressedBack: () {
            Navigator.pop(context);
          }),
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: Stack(
              children: [
                ShaderMask(
                  blendMode: BlendMode.srcATop,
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.white,
                          Colors.white.withOpacity(0),
                          Colors.white.withOpacity(0),
                          Colors.white,
                        ],
                        stops: [
                          0,
                          0.4,
                          0.8,
                          1
                        ]).createShader(bounds);
                  },
                  child: Hero(
                    tag: 'image-${widget.restaurantDetail.id}',
                    child: CachedNetworkImage(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width,
                      imageUrl: widget.restaurantDetail.featuredImage,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => LinearProgressIndicator(
                        backgroundColor: Colors.orange,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                      errorWidget: (context, url, error) => Image(
                        image: AssetImage('assets/bookATableLogo.jpg'),
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 24, right: 24, bottom: 14),
                      child: Text(
                        // widget.restaurantDetail.name.length>15?
                        // '${widget.restaurantDetail.name.substring(0,15)}..':
                        '${widget.restaurantDetail.name}',
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 28,
                            letterSpacing: 2.0,
                            color: Colors.orange.shade700),
                      ),
                    ))
              ],
            ),
          ),
          bottomHeaderButtons(),
          moreInfo(),
          bookATable(),
        ],
      )),
    ));
  }

  Widget bottomHeaderButtons() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(right: 24),
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 24, right: 40),
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.red,
                  size: 22,
                ),
              ),
              InkWell(
                child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.ios_share,
                      size: 22,
                      color: Colors.black,
                    )),
                onTap: () async {
                  bool value = await canLaunch(widget.restaurantDetail.url);
                  if (value) {
                    await launch(
                      widget.restaurantDetail.url,
                      // forceSafariVC: true,
                      // forceWebView: true,
                      // headers: <String, String>{'my_header_key': 'my_header_value'},
                    );
                  } else {}
                },
              ),
            ],
          ),
          if (widget.restaurantDetail.userRating.aggregateRating != null)
            RatingWidget(widget.restaurantDetail.userRating.aggregateRating),
        ],
      ),
    );
  }

  Widget topButtonsHeader({Function onPressedBack}) {
    return Container(
      padding: EdgeInsets.only(top: 20, right: 10),
      child: Row(
        children: <Widget>[
          Spacer(),
          InkWell(
            onTap: onPressedBack,
            child: Text(
              'Close',
              style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 2.0,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          )
          /*IconButton(
              icon: Icon(CupertinoIcons.shopping_cart),
              onPressed: (){
              },
            )*/
          ,
        ],
      ),
    );
  }

  Widget moreInfo() {
    return Container(
      padding: EdgeInsets.only(left: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'More Info: ',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Container(
            width: 300,
            padding: EdgeInsets.only(top: 5, bottom: 2),
            child: Text(
              'Address: ${widget.restaurantDetail.location.address}',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ),
          Text(
            'Average Cost : ${'\u20B9'}${widget.restaurantDetail.averageCostForTwo}',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Text(
              'Booking Cost : ${'\u20B9'}${widget.restaurantDetail.averageCostForTwo}',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              SearchLocation searchLocation = SearchLocation(
                double.parse(widget.restaurantDetail.location.latitude),
                double.parse(widget.restaurantDetail.location.longitude),
                widget.restaurantDetail.name,
                widget.restaurantDetail.location.address,
              );
              showGetDirectionMap(searchLocation);
            },
            child: Padding(
                padding: EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    Text(
                      'Get Directions',
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.orange,
                      size: 20,
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Widget bookATable() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PayMentGayWay(
                    amount: double.parse(widget
                        .restaurantDetail.averageCostForTwo
                        .toString()),
                    successfull:onPaymentSuccessFull,
                    failure:onPaymentFailure
                ),

            ));
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 15, right: 15, top: 20),
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.black, width: 1.5)),
        child: Text(
          'Book A Table',
          style: TextStyle(
              color: Colors.orange.shade700,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              letterSpacing: 2.0),
        ),
      ),
    );
  }

  void onPaymentSuccessFull(){
    globalKey.currentState.showSnackBar(
      SnackBar(content: Text('Your table is booked successfully',
        style: TextStyle(
          color: Colors.white,
          letterSpacing: 1.0,
        ),
      ),
        backgroundColor: Colors.deepOrange,
      )
    );
  }
  void onPaymentFailure(){
    globalKey.currentState.showSnackBar(
        SnackBar(content: Text('Oops! Your table is not booked',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.0,
          ),
        ),
          backgroundColor: Colors.deepOrange,
        )
    );
  }
}

class RatingWidget extends StatelessWidget {
  final String rating;

  RatingWidget(this.rating);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 8),
          child: Icon(
            Icons.star,
            color: Colors.yellow.shade700,
            size: 9,
          ),
        ),
        Text(rating,
            style: TextStyle(
                color: Colors.yellow.shade700, fontSize: 12, letterSpacing: 1.0)
            // RegularMierATextStyle(
            //     txtColor: RestaurantColor.filterYellow, size: 12, letterSpacing: 1),
            ),
      ],
    );
  }
}
