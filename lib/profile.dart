import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  double screenWidth = 0.0;
  double screenheight = 0.0;
  bool passwordVisible = false;
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passFocus = FocusNode();

  List<String> visitedPlacesList = ["Vienna", "Venice", "Porto", "Berlin"];

  List<String> visitedPlacesImages = [
    "assets/images/vienna.jpg",
    "assets/images/venice.jpg",
    "assets/images/porto.jpg",
    "assets/images/berlin.jpg",
  ];

  @override
  void initState() {
    passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Profile",
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.indigo),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      //it prevents to resize the view when keyboard appears
      
      body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
            Container(
              child: Column(children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 15.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(left: 15, right: 15),
                            child: Row(
                              
                            )),
                        SizedBox(height: 5),
                        Container(
                          margin: EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    width: 60.0,
                                    height: 60.0,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.indigo,
                                          width: 1,
                                        ),
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: ExactAssetImage(
                                                "assets/images/johndoe.jpg")))),
                                SizedBox(width: 20),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("John Doe"),
                                      Text(
                                        "A traveler, Love to travel.",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                )
                              ]),
                        ),
                        SizedBox(height: 15),
                        Container(child: Form(child: _body()))
                      ]),
                )
              ]),
            ),
          ])),
    );
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: (EdgeInsets.all(17)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.fromLTRB(15.0, 5.0, 5.0, 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(5), bottom: Radius.circular(5)),
                    shape: BoxShape.rectangle,
                    color: Colors.grey,
                  ),
                  child: TextFormField(
                    controller: name,
                    focusNode: _nameFocus,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (term) {
                      FocusScope.of(context).requestFocus(_emailFocus);
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "John Doe" /*Strings.uname*/,
                        // called from static string file
                        hintStyle: new TextStyle(color: Colors.grey)),
                  )),
              SizedBox(height: 15.0),
              Container(
                  padding: EdgeInsets.fromLTRB(15.0, 5.0, 5.0, 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(5), bottom: Radius.circular(5)),
                    shape: BoxShape.rectangle,
                    color: Colors.grey,
                  ),
                  child: TextFormField(
                    controller: email,
                    focusNode: _emailFocus,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (term) {
                      FocusScope.of(context).requestFocus(_passFocus);
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "test@gmail.com" /*Strings.uname*/,
                        // called from static string file
                        hintStyle: new TextStyle(color: Colors.grey)),
                  )),
              SizedBox(height: 15.0),
              Container(
                padding: EdgeInsets.fromLTRB(15.0, 5.0, 5.0, 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(5), bottom: Radius.circular(5)),
                  shape: BoxShape.rectangle,
                  color: Colors.grey,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: password,
                  focusNode: _passFocus,
                  obscureText: !passwordVisible,
                  //This will obscure text dynamically
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter your password',
                    hintStyle: new TextStyle(color: Colors.grey),
                    // Here is key idea
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.indigoAccent,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                  child: Text(
                    "Visited Places",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ),
        Container(
            padding: EdgeInsets.only(left: 10),
            width: screenWidth,
            height: 120.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: visitedPlacesList.length,
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                        width: 120,
                        padding: EdgeInsets.all(10.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              visitedPlacesImages[index],
                              height: 80,
                              fit: BoxFit.fill,
                            ))),
                    Positioned(
                      child: Container(
                          margin: EdgeInsets.only(right: 10, bottom: 5, top: 5),
                          padding: EdgeInsets.only(
                              left: 10, right: 10, bottom: 5, top: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5.0),
                                  bottomRight: Radius.circular(5.0)),
                              color: Colors.black26),
                          child: Text(
                            visitedPlacesList[index],
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                backgroundColor: Colors.transparent),
                          )),
                      bottom: 25,
                      left: 10,
                    )
                  ],
                );
              },
            )),
      ],
    );
  }
}

/*
  * email validation
  * */
String? validateEmail(String email) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(email);
  if (email.isEmpty) {
    return 'Please enter email address';
  } else if (!regex.hasMatch(email))
    return 'Enter Valid Email';
  else
    return null;
}
