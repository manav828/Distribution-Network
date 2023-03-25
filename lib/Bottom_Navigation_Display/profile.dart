// import 'package:flutter/material.dart';
// import 'bottom_navigation.dart';
//
// class Profile extends StatelessWidget {
//   const Profile({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('profile'),
//       ),
//     );
//     // bottomNavigationBar: BottomNavigation());
//   }
// }

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Distributor_login_signup/register.dart';
import '../Home Page/all_items_home/homePage.dart';
import '../fetch_from_firebase/provaider/userProvaider.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  static const String AGENTID = "agentData";

  String? userName;
  String? phoneNumber;
  String? email;
  String? shopName;
  String? agentName;
  String? agentId;
  void initState() {
    // TODO: implement initState
    getAgentId();
    fetch();

    super.initState();
  }

  getAgentId() async {
    var sharedPref = await SharedPreferences.getInstance();
    agentId = sharedPref.getString(AGENTID);
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return FutureBuilder(
        future: fetch(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Container(
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    const Color(0xFF020024),
                    const Color(0xFF096079),
                    const Color(0xFF00d4ff),
                  ], begin: Alignment.topCenter, end: Alignment.center)),
                ),
                FutureBuilder(
                    future: fetch(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      return Scaffold(
                        backgroundColor: Colors.transparent,
                        body: Container(
                          child: Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.only(top: _height / 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      CircleAvatar(
                                        backgroundImage:
                                            AssetImage('assets/img.png'),
                                        radius: _height / 10,
                                      ),
                                      SizedBox(
                                        height: _height / 30,
                                      ),
                                      Text(
                                        userName.toString(),
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: _height / 2.2),
                                child: Container(
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: _height / 2.6,
                                    left: _width / 20,
                                    right: _width / 30),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black45,
                                                blurRadius: 2.0,
                                                offset: Offset(0.0, 2.0))
                                          ]),
                                      // child:  Padding(
                                      //   padding:
                                      //        EdgeInsets.all(_width / 20),
                                      //   // child:  Row(
                                      //   //     mainAxisAlignment: MainAxisAlignment.center,
                                      //   //     children: <Widget>[
                                      //   //       headerChild('Photos', 114),
                                      //   //       headerChild('Followers', 1205),
                                      //   //       headerChild('Following', 360),
                                      //   //     ]),
                                      // ),
                                    ),
                                    SizedBox(
                                      height: 55,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: _height / 20),
                                      child: Column(
                                        children: <Widget>[
                                          infoChild(_width, Icons.email,
                                              email.toString()),
                                          infoChild(_width, Icons.call,
                                              phoneNumber.toString()),
                                          infoChild(_width, Icons.location_city,
                                              agentName),
                                          infoChild(
                                              _width, Icons.house, shopName),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: _height / 30),
                                            child: Container(
                                              width: _width / 3,
                                              height: _height / 20,
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF00d4ff),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              _height / 40)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black87,
                                                        blurRadius: 2.0,
                                                        offset:
                                                            Offset(0.0, 1.0))
                                                  ]),
                                              child: Center(
                                                child: Text('SHOW ORDER',
                                                    style: TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ],
            ),
          );
        });
  }

  Widget headerChild(String header, int value) => Expanded(
          child: Column(
        children: <Widget>[
          Text(header),
          SizedBox(
            height: 8.0,
          ),
          Text(
            '$value',
            style: TextStyle(
                fontSize: 14.0,
                color: const Color(0xFF26CBE6),
                fontWeight: FontWeight.bold),
          )
        ],
      ));

  Widget infoChild(double width, IconData icon, data) => Padding(
        padding: EdgeInsets.only(bottom: 8.0),
        child: InkWell(
          child: Row(
            children: <Widget>[
              SizedBox(
                width: width / 10,
              ),
              Icon(
                icon,
                color: const Color(0xFF26CBE6),
                size: 36.0,
              ),
              SizedBox(
                width: width / 20,
              ),
              Text(data)
            ],
          ),
          onTap: () {
            print('Info Object selected');
          },
        ),
      );

  fetch() async {
    final firebaseUser = (await FirebaseAuth.instance.currentUser!).uid;
    print(firebaseUser);
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('Admin')
          .doc('PG2lndSUQG3e3ju13VEm')
          .collection('Agents')
          .doc(agentId)
          .collection('Distributor')
          .doc(firebaseUser)
          .get()
          .then((ds) {
        userName = ds.get('displayName');
        phoneNumber = ds.get('phone');
        email = ds.get('email');
        agentName = ds.get('agentName');
        shopName = ds.get('shopName');
      }).catchError((e) {
        // print(agentId);
        print(e);
      });
    }
  }
}
