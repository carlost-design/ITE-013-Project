import 'package:flutter/material.dart';
import 'package:myapp/homepage.dart';
import 'package:myapp/bookAirport.dart';
import 'package:myapp/profile.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  final pageScreens = [
    HomePage(),
    BookingAir(),
    const Center(child: Text("Profile", style: TextStyle(fontSize: 30))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageScreens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
         backgroundColor: Colors.black,
         selectedItemColor: Colors.deepOrange,
         unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.airplane_ticket),
            label: "Book Flight",
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.manage_accounts_outlined),
            label: "Profile",
            
          ),
        ],
      ),
    );
  }
}
