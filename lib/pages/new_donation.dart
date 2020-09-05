import 'dart:convert';
import 'package:OURblood/api/api.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_permissions/simple_permissions.dart';

class NewDonation extends StatefulWidget {
  @override
  _NewDonationState createState() => _NewDonationState();
}

class _NewDonationState extends State<NewDonation> {

  bool loading = false; 
  String data = 'QR CODE Data';
    
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Donation') ,
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(data, style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
              RaisedButton(
                child: Text('Register'),
                onPressed: () async{
                  await _registerDonation();
                }
              ),
              RaisedButton(
                child: Text('Scan'),
                onPressed: () {
                  scanQR();
                }
              )
            ],
          ),
        ),
    );
  }

  _registerDonation() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userID = json.decode(localStorage.get('user'))['id'];
    setState(() {
      loading = true;
    });
    var data = {
      'hospital':'Hospital Test Phone',
      'date':'23/5/2020',
      'donor_name':'user1',
      'donor_donated_litre':'300',
      'donor_id':userID.toString()
    };

    var res = await CallApi().registerDonation(data);
    var body = json.decode(res.body);

    if(body['status'] == 'success'){
      print('success');
      setState(() {
        loading = false;
      });
    }else{
      print('failed');
      setState(() {
        loading = false;
      });
    }
  }

  void scanQR() async{
    bool result = await SimplePermissions.checkPermission(Permission.Camera);
    PermissionStatus status = PermissionStatus.notDetermined;
    if(!result){
      status = await SimplePermissions.requestPermission(Permission.Camera);
    }
    if(result || status == PermissionStatus.deniedNeverAsk){
      setState((){
        data = 'Please enable camera in settings';
      });
    }
    if(result || status == PermissionStatus.authorized){
      var scanResult = await BarcodeScanner.scan();
      setState((){
        data = scanResult.rawContent;
      });
    }
  }
}