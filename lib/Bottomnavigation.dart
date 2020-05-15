import 'package:completenews/Addnews.dart';
import 'package:completenews/Cateogory.dart';
import 'package:completenews/Home.dart';
import 'package:completenews/Profile.dart';
import 'package:flutter/material.dart';

class Bottomnavigation extends StatefulWidget {
  @override
  _BottomnavigationState createState() => _BottomnavigationState();
}

class _BottomnavigationState extends State<Bottomnavigation> {
   int currentIndex = 0;

  var barcount = [Home(), Cateogory(), AddNews(), Profile()];
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: barcount[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.category,
            ),
            title: Text(
              'Category',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
            ),
            title: Text(
              'Add News',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_pin,
            ),
            title: Text(
              "Accounts",
            ),
          ),
        ],
        
      ),
      
    );
  }
}