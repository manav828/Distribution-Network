import 'package:ami_milk/splash_screen/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../fetch_from_firebase/provaider/agentProvaider.dart';
// import 'home.dart';

class MyLogin extends StatefulWidget {
  @override
  _MyLoginState createState() => _MyLoginState();
}

final _auth = FirebaseAuth.instance;

class _MyLoginState extends State<MyLogin> {
  late String email;
  late String password;
  String? agentId;
  bool showSpinner = false;

  static const String AGENTID = "agentData";
  getAgentId() async {
    var sharedPref = await SharedPreferences.getInstance();
    agentId = sharedPref.getString(AGENTID);
    print(agentId);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AgentProvaider agentProvaider = Provider.of(context, listen: false);
    agentProvaider.fetchAgentData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(),
            Container(
              padding: EdgeInsets.only(left: 35, top: 130),
              child: Text(
                'Welcome\nBack',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: "Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (value) {
                              email = value;
                              //Do something with the user input.
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextField(
                            style: TextStyle(),
                            obscureText: true,
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (value) {
                              password = value;
                              //Do something with the user input.
                            },
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sign in',
                                style: TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xff4c505b),
                                child: IconButton(
                                    color: Colors.white,
                                    onPressed: () async {
                                      setState(() {
                                        showSpinner = true;
                                      });

                                      try {
                                        final user = await _auth
                                            .signInWithEmailAndPassword(
                                                email: email,
                                                password: password);

                                        if (user != null) {
                                          var sharedPref =
                                              await SharedPreferences
                                                  .getInstance();
                                          sharedPref.setBool(
                                              SplashScreenState.KEYLOGIN, true);
                                          // print(SplashScreenState.KEYLOGIN);
                                          if (email == 'admin@mahimilk.com') {
                                            Navigator.pushReplacementNamed(
                                                context, 'adminHome');
                                          } else {
                                            final QuerySnapshot querySnapshot =
                                                await FirebaseFirestore.instance
                                                    .collection('Admin')
                                                    .doc('PG2lndSUQG3e3ju13VEm')
                                                    .collection('Agents')
                                                    .get();

                                            final List<QueryDocumentSnapshot>
                                                agents = querySnapshot.docs;
                                            bool emailMatched = false;

                                            for (int i = 0;
                                                i < agents.length;
                                                i++) {
                                              final agentEmail =
                                                  agents[i].get('agentEmail');
                                              if (email == agentEmail) {
                                                emailMatched = true;
                                                var sharedPref =
                                                    await SharedPreferences
                                                        .getInstance();
                                                //make the true after the agent page ready
                                                sharedPref.setBool(
                                                    SplashScreenState
                                                        .KEYAGENTLOGIN,
                                                    false);
                                                Navigator.pushReplacementNamed(
                                                    context, 'agentHome');
                                                break;
                                              }
                                            }

                                            if (!emailMatched) {
                                              // Handle case when the email does not match any agent email in the collection
                                              Navigator.pushReplacementNamed(
                                                  context, 'home');
                                            }
                                          }
                                        }
                                      } catch (e) {
                                        print(e);
                                      }
                                      setState(() {
                                        showSpinner = false;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward,
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'register');
                                },
                                child: Text(
                                  'Sign Up',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xff4c505b),
                                      fontSize: 18),
                                ),
                                style: ButtonStyle(),
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Forgot Password',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xff4c505b),
                                      fontSize: 18,
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
