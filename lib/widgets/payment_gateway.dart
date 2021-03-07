import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../home.dart';


class PayMentGayWay extends StatelessWidget{
  String test = "Test Charge";
  int amount = 100;
  String htmlText=''' <html> <head> <meta name="viewport" content="width=device-width"></head> <center> <body> <form action="Your Server" method="POST"> <scriptsrc="https://checkout.stripe.com/checkout.js" class="stripe-button"data-key="pk_test_key"data-amount="100"data-name="Test-Charge"data-description="My Order"data-image="https://stripe.com/img/documentation/checkout/marketplace.png"data-locale="auto"data-currency="eur"></script></form></body></center></html>''';
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Home(),
      );
  }
}