import 'package:OURblood/constant.dart';
import 'package:OURblood/pages/new_donation.dart';
import 'package:OURblood/provider/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/donation_history.dart';
import 'pages/home.dart';
import 'pages/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }
  
  void _checkLogin() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if(token!= null){
        setState(() {
          isLoggedIn = true;
        });
    } 
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProvider>(
        create: (context) => UserProvider(),
        child: MaterialApp(
        initialRoute:isLoggedIn?'/':'/login',
        routes: {
          '/':(_)=>HomePage(),
          '/donation-history':(_)=>DonationHistoryPage(),
          '/login':(_)=>LoginPage(),
          '/new-donation':(_)=>NewDonation()
        },
        debugShowCheckedModeBanner:false,
        title: 'Covid 19',
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          accentColor: Colors.white,
          scaffoldBackgroundColor: kBackgroundColor,
          fontFamily: "Poppins",
          textTheme: TextTheme(
            bodyText1: TextStyle(color: kBodyTextColor)
          )
        ),
      ),
    );
  }
}

