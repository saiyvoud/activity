import 'package:activity/feature/home/page/home.dart';
import 'package:flutter/material.dart';

class BottomNavigatorWidget extends StatefulWidget {
  const BottomNavigatorWidget({super.key});

  @override
  State<BottomNavigatorWidget> createState() => _BottomNavigatorWidgetState();
}

class _BottomNavigatorWidgetState extends State<BottomNavigatorWidget> {
  int currentIndex = 0;
  List<Widget> children = [
    HomePage(),
    Container(),
    Container(),
    Container(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: children[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 4, 28, 248),
        currentIndex: currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ໜ້າຫຼັກ'),
          BottomNavigationBarItem(icon: Icon(Icons.card_giftcard),label: 'ບັດຂອງຂ້ອຍ'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications),label: 'ແຈ້ງເຕືອນ'),
          BottomNavigationBarItem(icon: Icon(Icons.person_3_sharp),label: 'ໂປໄຟຣ'),
        ],
      ),
    );
  }
}
