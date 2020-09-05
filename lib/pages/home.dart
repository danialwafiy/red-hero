import 'package:OURblood/components/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constant.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: Builder(
        builder: (BuildContext context){
          return  Column(
          children: <Widget>[
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                padding: EdgeInsets.only(left:20,top:50,right:20),
                height: MediaQuery.of(context).size.height/2,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end:Alignment.bottomLeft,
                    colors: [
                      Color.fromRGBO(255, 65, 108,1),
                      kPrimaryColor
                    ]
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        Scaffold.of(context).openDrawer();
                      },
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: SvgPicture.asset("assets/icons/menu.svg"),
                      ),
                    ),
                    SizedBox(height:20),
                    Expanded(
                      child: Stack(
                        children: <Widget>[
                          SvgPicture.asset(
                            "assets/icons/hero.svg",
                            width: 230,
                            fit:BoxFit.fitWidth,
                            alignment: Alignment.topCenter,
                          ),
                          Positioned(
                            top:50,
                            left:120,
                            child: Text(
                              "You're a hero\n in someone’s life.",
                              style: kHeadingTextStyle.copyWith(
                                color:Colors.white
                              )
                            ),
                          ),
                          Container()
                        ],
                      ) ,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:20),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      RichText(
                        text:TextSpan(
                          children: [
                            TextSpan(
                              text:"Donation details\n",
                              style:kTitleTextstyle
                            ),
                            TextSpan(
                              text:"Last donation: 19/7/2020",
                              style:TextStyle(color:kTextLightColor)
                            )
                          ]
                        )
                      ),
                      Spacer(),
                      Text(
                        "Full History",
                        style:TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w600
                        )
                      )
                    ],
                  ),
                  SizedBox(height:20),
                  Container(
                    padding:EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0,4),
                          blurRadius: 30,
                          color: kShadowColor
                        )
                      ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Counter(
                          color:Color(0xFFFF4848),
                          number: 1046,
                          title: "Litres donated",
                        ),
                        Counter(
                            color: Color(0xFF3382CC),
                            number: 87,
                            title: "Donations",
                          ),
                        Counter(
                            color: Color(0xFF36C12C),
                            number: 46,
                            title: "Hospitals",
                          )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        );
        }
      ),
    );
  }
}

class Counter extends StatelessWidget {
  final int number;
  final Color color;
  final String title;

  const Counter({
    Key key, this.number, this.color, this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(6),
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(.26)
          ),
          child: Container(
            decoration: BoxDecoration(
              shape:BoxShape.circle,
              color: Colors.transparent,
              border:Border.all(
                color: color,
                width: 2
              )
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          "$number",
          style: TextStyle(
            fontSize: 40,
            color: color
          ),
        ),
        Text(
          title,
          style:kSubTextStyle
        )
      ],
    );
  }
}

class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) { 
    var path = Path();
    path.lineTo(0, size.height-80);
    path.quadraticBezierTo(size.width/2,size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path>oldClipper){
    return false;
  }
}
