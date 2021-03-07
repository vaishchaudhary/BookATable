import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';

class PaymentHome extends StatefulWidget {
  final double amount;
  final Function successfull;
  final Function failure;
  const PaymentHome({Key key, this.amount,this.successfull,this.failure}) : super(key: key);
  @override
  _PaymentHomeState createState() => _PaymentHomeState();
}

class _PaymentHomeState extends State<PaymentHome> {

  Razorpay razorpay;
  TextEditingController textEditingController = new TextEditingController();
  double amount=10;
  @override
  void initState() {
    super.initState();
   amount=widget.amount;
    razorpay = new Razorpay();
    textEditingController.text='\u{20B9} ${amount}';
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }
  void openCheckout(){
    var options = {
      "key" : "rzp_test_a5TVoLjVT5I3hb",
      "currency": "INR",
      "amount" : amount*100,
      "name" : "Sample App",
      "description" : "Payment for booking a table in restaurant",
      // "prefill" : {
      //   "contact" : "2323232323",
      //   "email" : "shdjsdh@gmail.com"
      // },
      "external" : {
        "wallets" : ["paytm"]
      }
    };

    try{
      razorpay.open(options);

    }catch(e){
      print(e.toString());
      widget.failure();
      Navigator.pop(context);
    }

  }

  void handlerPaymentSuccess(){
    print("Pament success");
    //Toast.show("Pament success", context);
    widget.successfull();
    Navigator.pop(context);
  }

  void handlerErrorFailure(){
    print("Pament error");
    widget.failure();
    Navigator.pop(context);
   // Toast.show("Pament error", context);
  }

  void handlerExternalWallet(){
    print("External Wallet");
  //  Toast.show("External Wallet", context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Proceed to pay"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
              enabled: false,
              decoration: InputDecoration(
                  hintText: "amount to pay"
              ),
            ),
            SizedBox(height: 12,),
            RaisedButton(
              color: Colors.blue,
              child: Text("Proceed", style: TextStyle(
                  color: Colors.white
              ),),
              onPressed: (){
                openCheckout();
              },
            )
          ],
        ),
      ),
    );
  }
}