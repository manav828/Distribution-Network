import 'package:ami_milk/fetch_from_firebase/models/agentModel.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Home Page/all_items_home/homePage.dart';
import '../fetch_from_firebase/provaider/agentProvaider.dart';

// import 'items/homeDesign.dart';
String? agentId;

final FirebaseAuth _auth = FirebaseAuth.instance;

class sendInfo {
  sendInfo({this.userName, this.phoneNumber});
  final String? userName;
  final String? phoneNumber;

  String? sendName() {
    return userName;
  }

  String? sendPhone() {
    return phoneNumber;
  }
}

// AgentProvaider? agentProvaider;

class MyRegister extends StatefulWidget {
  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  final _auth = FirebaseAuth.instance;
  late String displayName;
  late String email;
  late String phone;
  // late String area;
  late String shopName;
  late String password;
  bool showSpinner = false;
  String? AgentName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AgentProvaider>(context, listen: false).fetchAgentData();
    Provider.of<AgentProvaider>(context, listen: false).getAgentName();
  }

  @override
  Widget build(BuildContext context) {
    AgentProvaider agentNameProvaider = Provider.of(context);
    List<String> agentNames = agentNameProvaider.getAgentName() ?? [];
    AgentProvaider agentProvaider = Provider.of(context);
    final List<String>? AgentNameList = agentProvaider.getAgentName();
    final List<AgentModel> agentData = agentProvaider.getAgentDataList;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 35, top: 30),
              child: Text(
                'Create\nAccount',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            child: TextField(
                              textAlignVertical: TextAlignVertical.bottom,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Name",
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onChanged: (value) {
                                displayName = value;
                                //Do something with the user input.
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 50,
                            child: TextField(
                              textAlignVertical: TextAlignVertical.bottom,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "ShopName",
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onChanged: (value) {
                                shopName = value;
                                //Do something with the user input.
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 60,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // SizedBox(height: 8.0),
                                SizedBox(
                                  height: 60.0,
                                  child: DropdownButtonFormField<String>(
                                    itemHeight: kMinInteractiveDimension,
                                    value: AgentName,
                                    onChanged: (String? value) {
                                      setState(() {
                                        AgentName = value;
                                        agentId = agentNameProvaider
                                            .getAgentId(value!);
                                        print(
                                            'Selected agent: $value, ID: $agentId');
                                      });
                                    },
                                    // dropdownColor: Colors.transparent,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      hintText: "Agent",
                                      hintStyle: TextStyle(color: Colors.white),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),

                                    items: AgentNameList!
                                        .map<DropdownMenuItem<String>>(
                                            (String value) =>
                                                DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                ))
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 50,
                            child: TextField(
                              textAlignVertical: TextAlignVertical.bottom,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Email",
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onChanged: (value) {
                                email = value;
                                //Do something with the user input.
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 50,
                            child: TextField(
                              textAlignVertical: TextAlignVertical.bottom,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Phone Number",
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onChanged: (value) {
                                phone = value;
                                //Do something with the user input.
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 50,
                            child: TextField(
                              textAlignVertical: TextAlignVertical.bottom,
                              style: TextStyle(color: Colors.white),
                              obscureText: true,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Password",
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onChanged: (value) {
                                password = value;
                                //Do something with the user input.
                              },
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 27,
                                    fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xff4c505b),
                                child: IconButton(
                                    color: Colors.white,
                                    onPressed: () async {
                                      setState(() {
                                        showSpinner = true;

                                        // print(_AreaName);
                                      });
                                      try {
                                        final newUser = _auth
                                            .createUserWithEmailAndPassword(
                                                email: email,
                                                password: password)
                                            .then((value) {
                                          FirebaseFirestore.instance
                                              .collection('Admin')
                                              .doc('PG2lndSUQG3e3ju13VEm')
                                              .collection('Agents')
                                              .doc(agentId)
                                              .collection('Distributor')
                                              .doc(value.user?.uid)
                                              .set({
                                            "email": value.user?.email,
                                            "displayName": displayName,
                                            "phone": phone,
                                            "agentName": AgentName,
                                            // "agentId": agentId,
                                            "shopName": shopName,
                                            "Role": "Distributor",
                                          });
                                        });
                                        var sharedPref = await SharedPreferences
                                            .getInstance();
                                        sharedPref.setString(
                                            homePageState.AGENTID,
                                            agentId.toString());
                                        print(agentId);

                                        sendInfo info = sendInfo(
                                            userName: displayName,
                                            phoneNumber: phone);

                                        if (newUser != null) {
                                          Navigator.pushNamed(context, 'login');
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
                                  Navigator.pushNamed(context, 'login');
                                },
                                child: Text(
                                  'Sign In',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.white,
                                      fontSize: 18),
                                ),
                                style: ButtonStyle(),
                              ),
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
