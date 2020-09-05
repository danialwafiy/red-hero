import 'dart:convert';

import 'package:OURblood/api/api.dart';
import 'package:OURblood/models/User.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  
  User _user;
  String errorMessage;
  bool isLoading = false, _isLogin = false;

  User get user => _user;
  bool get isLogin => _isLogin;


  Future<bool> login(loginData) async {
    setLoading(true);
    await CallApi().login(loginData).then((data) async {
      var resData = json.decode(data.body);
      if(resData['status'] == 'success'){
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('token', resData['token']);
        setUser(User.fromJson(resData['user']));
        setIsLogin(true);        
        setLoading(false);
      }else{
        Map<String, dynamic> result = json.decode(data.body);
        setMessage(result['message']);
        setLoading(false);
      }
    });
    return isLogin;
  }

  Future<bool> logout(userEmail) async {
    setLoading(true);
    await CallApi().logout(userEmail).then((data) async {
      print(json.decode(data.body));
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      await localStorage.remove('token');
      setUser(null);
      setIsLogin(false);        
      setLoading(false);
    });
    return isLogin;
  }

  void setIsLogin(value){
    _isLogin = value;
    notifyListeners();
  }

  void setLoading(value){
    isLoading = value;
    notifyListeners();
  }

  void setUser(value){
    _user = value;
    notifyListeners();
  }

  void setMessage(value){
    errorMessage = value;
    notifyListeners();
  }


}