import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallApi{

  final String url = 'http://10.0.2.2:8000/api/';
  var token;

  _setHeaders()=>{
    'Content-type':'application/json',
    'Accept':'application/json'
  };

  _setHeadersWithToken()=>{
    'Content-type':'application/json',
    'Accept':'application/json',
    'Authorization': 'Bearer '+token
  };

  Future login(data) async{
    var fullUrl = url + 'sanctum/token';
    return http.post(
      fullUrl,
      body:jsonEncode(data),
      headers: _setHeaders()
    );
  }

  Future logout(data) async{
    var fullUrl = url + 'sanctum/logout';
    return http.post(
      fullUrl,
      body:jsonEncode(data),
      headers: _setHeaders()
    );   
  }

  Future donationRecords() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userID = json.decode(localStorage.get('user'))['id'];
    var fullUrl = url+'donation/'+userID.toString();
    await _setToken();
    return http.get(
      fullUrl,
      headers: _setHeadersWithToken()
    );    
  }

  Future registerDonation(data) async{
    var fullUrl = url + 'donation';
    await _setToken();
    return http.post(
      fullUrl,
      body:jsonEncode(data),
      headers: _setHeadersWithToken()
    );    
  }

  _setToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token');
  }

} 