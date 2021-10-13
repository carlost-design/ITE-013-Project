import 'package:flutter/material.dart';

class BookingAir extends StatefulWidget {
  @override
  _BookingAir createState() => _BookingAir();
}

class _BookingAir extends State<BookingAir> {
  // for dropdown list items
  List<String> dropdownItems = ['   Yes', '   No'];

  //for "is it one way" variables
  String holderOneWay = ""; //holds the final value for one way
  var valueOneWay = null;

  //getting the data from one way dropdown
  void getDropdownOneWay() {
    setState(() {
      holderOneWay = valueOneWay;
    });
  }

  //for "personal assistance" variables
  String holderPersonal = ""; //holds the final value for personal assistance
  var valuePersonal = null;

  //getting the data from personal assistance dropdown
  void getDropdownPersonal() {
    setState(() {
      holderPersonal = valuePersonal;
    });
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
                child: Padding(
                    padding: EdgeInsets.only(left: 15, top: 45, right: 15),
                    child: Column(children: [
                      RichText(
                        text: TextSpan(
                          text: "Book your ",
                          style: TextStyle(fontSize: 30, color: Colors.deepOrange),
                          children: const <TextSpan>[
                            TextSpan(
                              text: "flight",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          child: ListView(children: [
                        SizedBox(height: 8),
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_on_outlined),
                            fillColor: Colors.white54,
                            filled: true,
                            labelText: 'Enter the Origin',
                          ),
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_on),
                            fillColor: Colors.white54,
                            filled: true,
                            labelText: 'Enter the Destination',
                          ),
                          textInputAction: TextInputAction.done,
                        ),
                        SizedBox(height: 10),

                        //dropdown for "is it one way"
                        DropdownButton<String>(
                          value: valueOneWay,
                          hint: Text("One way ticket or two?"),
                          icon: Icon(Icons.arrow_drop_down),
                          onChanged: (String? data) {
                            setState(() {
                              valueOneWay = data!;
                            });
                          },
                          items: dropdownItems.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        //-----

                        SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.date_range),
                            fillColor: Colors.white54,
                            filled: true,
                            labelText: 'Enter the Departure Date',
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_add_alt_1),
                            fillColor: Colors.white54,
                            filled: true,
                            labelText: 'Enter the No. of Passenger',
                          ),
                        ),
                        SizedBox(height: 10),

                        //dropdown for "personal assistance"
                        DropdownButton<String>(
                          value: valuePersonal,
                          hint: Text(
                              "Do you have a Vaccination card?"),
                          icon: Icon(Icons.arrow_drop_down),
                          onChanged: (String? data) {
                            setState(() {
                              valuePersonal = data!;
                            });
                          },
                          items: dropdownItems.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        //-----

                        SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.check_box),
                            fillColor: Colors.white54,
                            filled: true,
                            labelText: 'If yes, you have 50%off!',
                          ),
                        ),
                        SizedBox(height: 25),
                        Row(
                          children: [
                            Expanded(
                                child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                      primary: Colors.deepOrange, // background
                                      onPrimary: Colors.white, // foreground
                                     ),
                                    onPressed: () {},
                                    child: Text('Search for avalaible flights',
                                       
                                        style: TextStyle(fontSize: 20)))),
                                        
                          ],
                        ),
                        SizedBox(height: 10),
                      ]))
                    ])))),
      );
}
