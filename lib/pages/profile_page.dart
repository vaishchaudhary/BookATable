import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auths/entity/restaurants_entity.dart';
import 'package:flutter_auths/utils/helper.dart';
import 'package:flutter_auths/widgets/payment_gateway.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  // final Restaurant restaurantDetail;
  //
  // const ProfilePage({Key key, this.restaurantDetail})
  //     : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName='';
  @override
  void initState() {
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
              child:
                  ListView(
                    children: [
                      Image(
                      image: AssetImage('assets/bookATableLogo.jpg'),
                      fit: BoxFit.cover,
                      height:  MediaQuery.of(context).size.height/2,
                      width: MediaQuery.of(context).size.width,

                    ),
                      Text(
                        'Hi ${userName}, I hope u are enoying this App',
                        style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 2.0,
                          fontSize: 20,

                        ),
                      )
                    ],
                  ),

        )
        )
    );
  }

  Future<void> getUserDetails() async {
    FirebaseUser user =await  FirebaseAuth.instance.currentUser();
    userName=user.email;
  }
}


