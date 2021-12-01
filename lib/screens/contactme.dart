import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stop_shop/screens/drawer.dart';
import 'package:stop_shop/screens/likedItems.dart';

class ContactMe extends StatefulWidget {
  const ContactMe({Key? key}) : super(key: key);

  @override
  _ContactMeState createState() => _ContactMeState();
}

class _ContactMeState extends State<ContactMe> {
  String github = "https://github.com/umairiqbal78";
  String linkdin = "https://www.linkedin.com/in/umair-iqbal-49a221203/";
  String facebook = "https://www.facebook.com/profile.php?id=100008747760277";
  String whatsapp = "03402591229";
  bottomPopUp(String url) {
    return showModalBottomSheet(
      context: context,
      // color is applied to main screen when modal bottom screen is displayed
      barrierColor: Colors.transparent,
      //background color for modal bottom screen
      backgroundColor: Colors.white,
      //elevates modal bottom screen
      elevation: 10,
      // gives rounded corner to modal bottom screen
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        copy(String url) {
          Clipboard.setData(new ClipboardData(text: url)).then((_) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Copied to your clipboard !')));
          });
        }

        return Container(
          height: 100,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          url,
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.copy_rounded),
                      onPressed: () {
                        Navigator.pop(context);
                        copy(url);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _drawerscaffoldkey =
        new GlobalKey<ScaffoldState>();

    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      // endDrawer: DrawerClass(),
      appBar: AppBar(
        title: Text(
          "Contact Me",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: BackButton(color: Colors.white),
        backgroundColor: Colors.grey[900],
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LikedItems()),
              );
            },
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          ),

          IconButton(
            onPressed: () {
              //on drawer menu pressed
              if (_drawerscaffoldkey.currentState!.isDrawerOpen) {
                //if drawer is open, then close the drawer
                Navigator.pop(context);
              } else {
                _drawerscaffoldkey.currentState!.openEndDrawer();
                //if drawer is closed then open the drawer.
              }
            },
            icon: Icon(Icons.menu),
          ), // Set menu icon at leading of AppBar
        ],
      ),
      body: Scaffold(
        key: _drawerscaffoldkey,
        endDrawer: DrawerClass(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height + 60,
                width: size.width,
                child: Stack(children: [
                  Container(
                    width: size.width,
                    margin: EdgeInsets.only(top: size.height * 0.2),
                    padding: EdgeInsets.only(top: size.height * 0.07),

                    // color: Colors.black,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(26.0),
                            topRight: Radius.circular(26.0))),
                    child: Column(
                      children: [
                        Text(
                          "UMAIR IQBAL",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 26.0,
                              letterSpacing: 0.5),
                        ),
                        Text(
                          "Flutter Developer, Karachi",
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16.0,
                              letterSpacing: 0.7),
                        ),
                        Text(
                          "Pakistan",
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16.0,
                              letterSpacing: 0.7),
                        ),
                        DefaultTabController(
                          length: 2,
                          child: SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0.0, vertical: 5.0),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: TabBar(
                                        labelColor: Colors.white,
                                        indicator: BoxDecoration(
                                            color: Colors.white,
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.black,
                                                    width: 2.0))),
                                        tabs: [
                                          Tab(
                                            child: Text(
                                              "About",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16.0),
                                            ),
                                          ),
                                          Tab(
                                            child: Text(
                                              "Recent",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16.0),
                                            ),
                                          ),
                                        ]),
                                  ),
                                  SizedBox(
                                    height: 430.0,
                                    child: TabBarView(children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 8.0),
                                        color: Colors.white,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Personal Information
                                            Text(
                                              "Personal info",
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Divider(
                                                color: Colors.black38,
                                                thickness: 2.0),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Icon(Icons.arrow_right_rounded),
                                                Flexible(
                                                  child: Text(
                                                    'Hi, I am a flutter Developer. Creating attractive UI and carefull about UX is my first proirity.',
                                                    style: TextStyle(
                                                        fontSize: 16.0),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Column(
                                                  children: [
                                                    Icon(
                                                      Icons.cake_rounded,
                                                      size: 20.0,
                                                      color: Colors.black,
                                                    ),
                                                    Text(
                                                      '13 September 2001',
                                                      style: TextStyle(
                                                          fontSize: 16.0),
                                                    ),
                                                  ],
                                                ),
                                                // Divider(
                                                //   color: Colors.black87,
                                                //   thickness: 2.0,
                                                // ),
                                                Column(
                                                  children: [
                                                    Icon(
                                                      Icons.favorite_border,
                                                      size: 20.0,
                                                      color: Colors.black,
                                                    ),
                                                    Text(
                                                      'Single',
                                                      style: TextStyle(
                                                          fontSize: 16.0),
                                                    ),
                                                  ],
                                                ),

                                                Column(
                                                  children: [
                                                    Icon(
                                                      Icons.work_rounded,
                                                      size: 20.0,
                                                      color: Colors.black,
                                                    ),
                                                    Text(
                                                      'Un Employeed',
                                                      style: TextStyle(
                                                          fontSize: 16.0),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),

                                            //Education
                                            SizedBox(
                                              height: 20.0,
                                            ),
                                            Text(
                                              "Education",
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Divider(
                                                color: Colors.black38,
                                                thickness: 2.0),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Icon(Icons.arrow_right_rounded),
                                                Text(
                                                  'Umaer Basha Institute of Technology',
                                                  style:
                                                      TextStyle(fontSize: 16.0),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 2.0,
                                            ),
                                            Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 30.0),
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          'Bachelors of Computer Science (BCS)'),
                                                      SizedBox(
                                                        height: 1.0,
                                                      ),
                                                      Text(
                                                          'Jan 2020 - Jan 2023')
                                                    ])),

                                            // Skills
                                            SizedBox(
                                              height: 20.0,
                                            ),
                                            Text(
                                              "Skills",
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Divider(
                                                color: Colors.black38,
                                                thickness: 2.0),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(Icons
                                                            .arrow_right_rounded),
                                                        Text(
                                                          'Flutter',
                                                          style: TextStyle(
                                                              fontSize: 12.0),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(Icons
                                                            .arrow_right_rounded),
                                                        Text(
                                                          'Dart',
                                                          style: TextStyle(
                                                              fontSize: 12.0),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(Icons
                                                            .arrow_right_rounded),
                                                        Text(
                                                          'Firebase Firestore',
                                                          style: TextStyle(
                                                              fontSize: 12.0),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(Icons
                                                            .arrow_right_rounded),
                                                        Text(
                                                          'CSS',
                                                          style: TextStyle(
                                                              fontSize: 12.0),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 20.0,
                                                ),
                                                Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(Icons
                                                              .arrow_right_rounded),
                                                          Text(
                                                            'Python',
                                                            style: TextStyle(
                                                                fontSize: 12.0),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(Icons
                                                              .arrow_right_rounded),
                                                          Text(
                                                            'Git',
                                                            style: TextStyle(
                                                                fontSize: 12.0),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(Icons
                                                              .arrow_right_rounded),
                                                          Text(
                                                            'HTML',
                                                            style: TextStyle(
                                                                fontSize: 12.0),
                                                          ),
                                                        ],
                                                      ),
                                                    ]),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Recent Tab
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 8.0),
                                        color: Colors.white,
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Project Details
                                              Text(
                                                "Projects",
                                                style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Divider(
                                                  color: Colors.black38,
                                                  thickness: 2.0),
                                              Row(
                                                children: [
                                                  Icon(Icons
                                                      .arrow_right_rounded),
                                                  Text(
                                                    'E-Commerce App',
                                                    style: TextStyle(
                                                        fontSize: 16.0),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 25.0,
                                                        vertical: 2.0),
                                                child: Flexible(
                                                    child: Text(
                                                        "An Online Shopping store app was my recent project. I designed UI for this project completly. Products data were taken from the rest api named as 'Fake store rest API'. It gives the product images, product categories, description, rating and price. There are several screens in this app.Splash Screen, Login , Sign Up Home (Product Screen), Product (Particular Product image and details screen) and a Cart Screen ( Cart Products screening), and Contact Me Screen.")),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(Icons
                                                      .arrow_right_rounded),
                                                  Text(
                                                    'Functionality',
                                                    style: TextStyle(
                                                        fontSize: 16.0),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 25.0,
                                                      vertical: 2.0),
                                                  child: Flexible(
                                                      child: Text(
                                                          "Used Firebase Services for this project. Firebase Authentication for Login/SignUp. Cloud FireStore for saving the details of users, cart items and user profile picture details. Cloud Storage for profile pictures of users."))),
                                              Text(
                                                "Connect",
                                                style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Divider(
                                                  color: Colors.black38,
                                                  thickness: 2.0),

                                              // SizedBox(
                                              //   height: 0.0,
                                              // ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    children: [
                                                      IconButton(
                                                          iconSize: 40.0,
                                                          icon: FaIcon(
                                                            FontAwesomeIcons
                                                                .github,
                                                            size: 40.0,
                                                            color: Colors.black,
                                                          ),
                                                          onPressed: () {
                                                            bottomPopUp(github);
                                                          }),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      IconButton(
                                                        iconSize: 40.0,
                                                        icon: FaIcon(
                                                          FontAwesomeIcons
                                                              .linkedin,
                                                          size: 40.0,
                                                          color:
                                                              Colors.blue[800],
                                                        ),
                                                        onPressed: () {
                                                          bottomPopUp(linkdin);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      IconButton(
                                                        iconSize: 40.0,
                                                        icon: FaIcon(
                                                          FontAwesomeIcons
                                                              .facebook,
                                                          size: 40.0,
                                                          color: Colors.blue,
                                                        ),
                                                        onPressed: () {
                                                          bottomPopUp(facebook);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      IconButton(
                                                        iconSize: 40.0,
                                                        icon: FaIcon(
                                                          FontAwesomeIcons
                                                              .whatsappSquare,
                                                          size: 40.0,
                                                          color: Colors.green,
                                                        ),
                                                        onPressed: () {
                                                          bottomPopUp(whatsapp);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ]),
                                      ),
                                    ]),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(25.0),
                      child: Column(
                        children: [
                          Row(children: [
                            Expanded(
                              child: CircleAvatar(
                                  radius: 70.0,
                                  child: ClipOval(
                                    child: Image.asset('assets/me.png'),
                                  )),
                            ),
                          ])
                        ],
                      ))
                ]),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
