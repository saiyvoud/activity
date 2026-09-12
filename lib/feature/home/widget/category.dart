import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  int currentIndex = 0;

  _onTap(index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<String> category = [
    "ທັງໝົດ",
    "ສຳມະນາ",
    "ທ່ອງທ່ຽວ",
    "ກິດຈະກຳ",
    "ຈອງປີ້",
    "ຄອສອອນລາຍ",
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: category.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: currentIndex == index ? Colors.blueAccent : Colors.grey,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextButton(
            onPressed: _onTap(index),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                category[index],
                style: TextStyle(
                  color: currentIndex == index ? Colors.white : Colors.black,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
