// import 'package:ami_milk/HomePage/all_items_home/displaItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '';

import '../../splash_screen/splash_screen.dart';
import 'displaItem.dart';

late User loggedinUser;

GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class homePage extends StatefulWidget {
  @override
  State<homePage> createState() => homePageState();
}

//using this function you can use the credentials of the user
String? agentId;

class homePageState extends State<homePage> {
  final _auth = FirebaseAuth.instance;
  static const String AGENTID = "agentData";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
    getAgentId();
  }

  getAgentId() async {
    var sharedPref = await SharedPreferences.getInstance();
    agentId = sharedPref.getString(AGENTID);
    print(agentId);
  }

  String? userName;
  String? phoneNumber;
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedinUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      drawer: Drawer(
        child: ListView(
          // Remove padding
          padding: EdgeInsets.zero,
          children: [
            FutureBuilder(
              future: _fetch(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                return UserAccountsDrawerHeader(
                  accountName: Text(userName.toString()),
                  accountEmail: Text(phoneNumber.toString()),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Image.asset(
                        'assets/img.png',
                        fit: BoxFit.cover,
                        width: 90,
                        height: 90,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
                  ),
                );
              },
              // child:
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Favorites'),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Friends'),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Share'),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Request'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.description),
              title: Text('Policies'),
              onTap: () => null,
            ),
            Divider(),
            ListTile(
              title: Text('Exit'),
              leading: Icon(Icons.exit_to_app),
              onTap: () async {
                _auth.signOut();
                var sharedPref = await SharedPreferences.getInstance();
                sharedPref.setBool(SplashScreenState.KEYLOGIN, false);
                Navigator.pushReplacementNamed(context, 'login');
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: const Color(0xffefecec),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 50.0, left: 25, right: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xfff2f2f4),
                        child: IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            _scaffoldState.currentState?.openDrawer();
                          },
                        ),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xfff2f2f4),
                        child: IconButton(
                          icon: const Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 25),
                        ),
                        Row(
                          children: const [
                            Text(
                              'Ami Milk',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto',
                                fontSize: 33,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Wrap(
                            children: const [
                              SizedBox(
                                height: 100,
                              ),
                              Text(
                                'Ami Milk provides fresh and healthy milk daily',
                                textAlign: TextAlign.justify,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Roboto',
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Text(
                          'Products',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto',
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 25, right: 25),
                child: DisplayItem(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _fetch() async {
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
      }).catchError((e) {
        print(e);
      });
    }
  }
}
