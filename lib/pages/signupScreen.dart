import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auths/controllers/authentications.dart';
import 'package:flutter_auths/pages/loginScreen.dart';
import 'package:flutter_auths/pages/tasks.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String email;
  String password;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  void handleSignup() {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      signUp(email.trim(), password, context).then((value) {
        if (value != null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MyTask(),
              ));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: scaffoldKey,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image(
                  image: AssetImage('assets/bookATableLogo.jpg'),
                  height: 100,
                  width: 100,
                  fit: BoxFit.contain,
                  // color: Colors.orange,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    "Signup Here",
                    style: TextStyle(
                      fontSize: 30.0,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), labelText: "Email"),
                          validator: (_val) {
                            if (_val.isEmpty) {
                              return "Can't be empty";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            email = val;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Password"),
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "This Field Is Required."),
                              MinLengthValidator(6,
                                  errorText: "Minimum 6 Characters Required.")
                            ]),
                            onChanged: (val) {
                              password = val;
                            },
                          ),
                        ),
                        RaisedButton(
                          // passing an additional context parameter to show dialog boxs
                          onPressed: handleSignup,
                          color: Colors.cyan,
                          textColor: Colors.white,
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                MaterialButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => googleSignIn().whenComplete(() async {
                    FirebaseUser user = await FirebaseAuth.instance.currentUser();

                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => MyTask()));
                  }),
                  child: Image(
                    image: AssetImage('assets/googleSignIn.png'),
                    width: 300.0,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                ),
                MaterialButton(
                  padding: EdgeInsets.zero,
                  onPressed: ()  async {
                    bool value=await signInWithFacebook();
                    if(value) {
                      FirebaseUser user = await FirebaseAuth.instance
                          .currentUser();

                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => MyTask()));
                    }else{
                      scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text('Unable to continue with Facebook using this account'),
                            backgroundColor: Colors.orangeAccent,
                          )
                      );
                    }
                  },
                  child: Image(
                    image: AssetImage('assets/facebookSignIn.png'),
                    width: 300.0,
                    height: 50,
                    fit: BoxFit.contain,

                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(
                          text:"Already have an account? ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.2,
                          ),
                        ),
                        WidgetSpan(child:
                        InkWell(
                          onTap: () {
                            // send to login screen
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => LoginScreen()));
                          },
                          child:
                          Text(
                            "Sign In Here",
                            style: TextStyle(
                              color: Colors.cyan,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.2,
                            ),
                          ),
                        )
                        )
                      ]
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
