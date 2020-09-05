import 'dart:convert';

import 'package:OURblood/api/api.dart';
import 'package:OURblood/constant.dart';
import 'package:OURblood/provider/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String email='';
  String password='';
  String error = '';

  void loginApi() async {
    var loginData = {
      'email':this.email,
      'password':this.password,
      'device_name':'mobile_phone'
    };

    Provider.of<UserProvider>(context,listen:false).login(loginData).then((value) {
      if (value) {
        Navigator.of(context).pushNamed('/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
  final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body:Center(
            child: loading ? CircularProgressIndicator() : Container(
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: SingleChildScrollView(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 155.0,
                        child: SvgPicture.asset(
                          "assets/icons/hero.svg",
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 45.0),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(color: Colors.white),
                                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                  hintText: "Email",
                                  border:OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0),
                                  )
                              ),
                              validator: (val) => val.isEmpty ? 'Enter an email' : null,
                              onChanged:(val){
                                setState(()=>email=val);
                              }
                            ),               
                            SizedBox(height: 25.0),
                            TextFormField(
                              decoration: InputDecoration(
                                errorStyle: TextStyle(color: Colors.white),
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: "Password",
                                border:OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ),    
                              ),
                              validator: (val) => val.isEmpty ? 'Enter a password' : null,
                              obscureText: true,
                              onChanged:(val){
                                setState(()=>password=val);
                              }                    
                            ),
                            SizedBox(
                              height: 35.0,
                            ),
                            Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.white,
                              child: MaterialButton(
                                minWidth: 300,
                                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                onPressed: (){
                                  loginApi();
                                },
                                child: 
                                userProvider.isLoading ? 
                                CircularProgressIndicator(backgroundColor: Colors.grey, strokeWidth: 1,) 
                                :
                                Text("Login",
                                    textAlign: TextAlign.center,
                                    ),
                              ),
                            ),  
                            SizedBox(height:12.0),
                            Text(
                                error !='' ? error : '',
                                style: TextStyle(color:Colors.white,fontSize: 14.0)
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
      );
  }
}
