import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../home.dart';


class PayMentGayWay extends StatelessWidget{
  String test = "Test Charge";
 final double amount;
final Function successfull;
  final Function failure;
   PayMentGayWay({Key key, this.amount,this.successfull,this.failure}) : super(key: key);
  @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: PaymentHome(amount: amount,successfull:successfull,failure:failure),
      );
  }
}