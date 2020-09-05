import 'dart:convert';

import 'package:OURblood/api/api.dart';
import 'package:OURblood/constant.dart';
import 'package:OURblood/models/User.dart';
import 'package:OURblood/provider/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {

  User user;

  @override
  void initState(){
    super.initState();
    _getUserInfo();
  }

  void _getUserInfo() async{
    user = Provider.of<UserProvider>(context,listen:false).user;
  }

  void logoutApi() async {
    var data = {
      'email': user.email,
    };
    Provider.of<UserProvider>(context,listen:false).logout(data).then((value) {
      if (!value) {
        Navigator.of(context).pushNamed('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: kPrimaryColor,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top:30,bottom:10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage('https://www.pngkey.com/png/full/115-1150420_avatar-png-pic-male-avatar-icon-png.png'),
                          fit:BoxFit.fill
                        )
                      ),
                    ),
                    Text(user!=null ? '${user.name}' : '',style:kTitleTextstyleContra),
                    Text(user!=null ? '${user.email}' :'',style:TextStyle(color: Colors.white,fontSize: 10))
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile',style:kSubTextStyle),
              onTap: null,
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Donation History',style:kSubTextStyle),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/donation-history');
              },
            ),
            ListTile(
              leading: Icon(Icons.local_hospital),
              title: Text('New Donation',style:kSubTextStyle),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/new-donation');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings',style:kSubTextStyle),
              onTap: null,
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout',style:kSubTextStyle),
              onTap: () async =>await logoutApi(),
            )
          ],
        ),
    );
  }
}