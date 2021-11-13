import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stop_shop/screens/authentication/signin.dart';
import 'package:stop_shop/screens/services/auth.dart';
import 'package:stop_shop/shared/constants.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String email = '';
  String username = '';
  String password = '';
  String error = '';
  bool obscureText = true;
  bool iconToggle = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
            body: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(children: [
                          SizedBox(height: 80.0),
                          Image.asset(
                            'assets/one-stop-shop-logos.png',
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      fontSize: 35.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                label: Text('Username')),
                            onChanged: (val) {
                              setState(() {
                                username = val;
                              });
                            },
                            validator: (val) =>
                                val!.isEmpty ? 'Enter an username' : null,
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            decoration: textInputDecoration,
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                            validator: (val) =>
                                val!.isEmpty ? 'Enter an email' : null,
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                              suffixIcon: IconButton(
                                  focusColor: Colors.black,
                                  hoverColor: Colors.black,
                                  disabledColor: Colors.grey,
                                  color: Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      obscureText = !obscureText;
                                      iconToggle = !iconToggle;
                                    });
                                  },
                                  icon: Icon(iconToggle
                                      ? Icons.visibility
                                      : Icons.visibility_off_rounded)),
                              label: Text('Password'),
                            ),
                            onChanged: (val) {
                              setState(() {
                                password = val;
                              });
                            },
                            obscureText: obscureText,
                            validator: (val) => val!.length < 6
                                ? 'Enter atleast 6 numerics'
                                : null,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              try {
                                if (_formKey.currentState!.validate()) {
                                  dynamic result =
                                      _auth.registerWithEmailandPassword(
                                          email, password);

                                  if (result == null) {
                                    setState(() {
                                      error =
                                          'Please enter valid Username and Email ';
                                    });
                                  } else {
                                    print('user is registered');
                                  }
                                }
                              } catch (e) {
                                print(e.toString());
                              }
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.grey[900])),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            error,
                            style: TextStyle(color: Colors.red, fontSize: 14.0),
                          ),
                          new RichText(
                              textAlign: TextAlign.start,
                              text: new TextSpan(
                                children: [
                                  new TextSpan(
                                      text: 'Already Have an Account, then:  ',
                                      style:
                                          TextStyle(color: Colors.grey[400])),
                                  new TextSpan(
                                    text: 'Sign In',
                                    style: TextStyle(color: Colors.grey[800]),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        widget.toggleView();
                                      },
                                  ),
                                ],
                              )),
                        ]))))));
  }
}
