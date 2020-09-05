import 'dart:convert';

import 'package:OURblood/api/api.dart';
import 'package:OURblood/constant.dart';
import 'package:OURblood/models/donation.dart';
import 'package:flutter/material.dart';

class DonationHistoryPage extends StatefulWidget {
  @override
  _DonationHistoryPageState createState() => _DonationHistoryPageState();
}

class _DonationHistoryPageState extends State<DonationHistoryPage> {
    
  @override
  void initState(){
    super.initState();
    _getDonationRecord();
  }

  Future<List<Donation>> _getDonationRecord() async {
    var res = await CallApi().donationRecords();
    var body = json.decode(res.body) as List<Object>;
    return body.map((p) => Donation.fromJson(p)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation History') ,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder<List<Donation>>(
                future: _getDonationRecord(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Donation> data = snapshot.data;
                    return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.sentiment_very_satisfied,color: kPrimaryColor,) ,
                        title: Text(data[index].hospital,style: TextStyle(color: Colors.black),),
                        subtitle: Text(data[index].date,style: TextStyle(color: Colors.black),),
                        trailing: Text(data[index].donorDonatedLitre,style: TextStyle(color: Colors.black),),
                      );
                    });
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
          )
          ],
        ),
      )
    );
  }
}