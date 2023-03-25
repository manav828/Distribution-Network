import 'package:ami_milk/AGENT%20PAGES/homePage/homePage.dart';
import 'package:ami_milk/fetch_from_firebase/provaider/agentProvaider.dart';
import 'package:ami_milk/fetch_from_firebase/provaider/horiItemProvaider.dart';
import 'package:ami_milk/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Admin/adminHome/admin_home.dart';
import 'Bottom_Navigation_Display/cart.dart';
import 'Bottom_Navigation_Display/profile.dart';
import 'Bottom_Navigation_Display/search.dart';
import 'Distributor_login_signup/login.dart';
import 'Distributor_login_signup/register.dart';
import 'Home Page/horizontal_menu/hori_Display.dart';
import 'Home Page/mainHomeDesign.dart';
import 'fetch_from_firebase/provaider/cartProvaider.dart';
import 'fetch_from_firebase/provaider/homeItemProvaider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<HomeItemProvaider>(
            create: (context) => HomeItemProvaider(),
          ),
          ChangeNotifierProvider<HoriItemProvaider>(
            create: (context) => HoriItemProvaider(),
          ),
          ChangeNotifierProvider<CartProvider>(
            create: (context) => CartProvider(),
          ),
          ChangeNotifierProvider<AgentProvaider>(
            create: (context) => AgentProvaider(),
          ),
        ],
        child: MaterialApp(
          home: SplashScreen(),
          routes: {
            'home': (context) => mainHomePageDesign(),
            'horiDisplay': (context) => HoriDisplay(),
            'profile': (context) => Profile(),
            'cart': (context) => Cart(),
            'search': (context) => Search(),
            'login': (context) => MyLogin(),
            'register': (context) => MyRegister(),
            // for agent nevigation
            'agentHome': (context) => agentHome(),

            //for admin nevigation
            'adminHome': (context) => adminHome(),
          },
        ));
  }
}
