import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  int currentIndex = 0;

  onTap(index) {
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
    return Container(
      height: 40,
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        scrollDirection: Axis.horizontal,
        itemCount: category.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: currentIndex == index ?  Color.fromARGB(255, 4, 28, 248) : Colors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextButton(
              onPressed: ()=> onTap(index),
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
      ),
    );
  }
}
