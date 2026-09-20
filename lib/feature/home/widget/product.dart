import 'package:activity/feature/home/widget/detail_home.dart';
import 'package:flutter/material.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  List<dynamic> product = [
    {
      "id": 1,
      "title": "Thriving beyond the storm",
      "date": "28/8/2026",
      "time": "8:00 - 12:00",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUC1WcJ5NovCtPqqyATD7EVJSwh8mBAR-SXJ-JhESEj4f7P2NIkPK9VkxQ&s=10",
      "address": "Bangkok Thailand",
      "price": 500000,
    },
    {
      "id": 2,
      "title": "Explore Laos",
      "date": "31/10/2026",
      "time": "15:00 - 23:30",
      "image":
          "https://ak-d.tripcdn.com/images/1mi33224x9aaoeyor9D26.jpg?proc=resize%2Fm_z%2Cw_375%2Ch_0%3Bformat%2Ff_webp%2C9C2E",
      "address": "Laos PDR",
      "price": 500000,
    },
    {
      "id": 3,
      "title": "Biggest Music",
      "date": "28/8/2026",
      "time": "8:00 - 12:00",
      "image":
          "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/music-concert-flyer-design-template-2d59fde071fcf31f0d8a138b3a6e516d_screen.jpg?ts=1737708040",
      "address": "Bangkok Thailand",
      "price": 500000,
    },
    {
      "id": 4,
      "title": "Run the canyon just outside",
      "date": "28/8/2026",
      "time": "8:00 - 12:00",
      "image":
          "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/music-concert-flyer-design-template-2d59fde071fcf31f0d8a138b3a6e516d_screen.jpg?ts=1737708040",
      "address": "Bangkok Thailand",
      "price": 500000,
    },
  ];
 
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      primary: false,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 0.55,
      ),
      itemCount: product.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailHome(product: product[index]),
              ),
            );
            print(product[index]);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 4, 28, 248),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Image.network(
                  product[index]['image'],
                  fit: BoxFit.cover,
                  height: 300,
                  width: double.infinity,
                ),
                Text(
                  product[index]['title'],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.white),
                    SizedBox(width: 2),
                    Text(
                      product[index]['date'],
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.alarm, color: Colors.white),
                    SizedBox(width: 2),
                    Text(
                      product[index]['time'],
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.white),
                    SizedBox(width: 2),
                    Text(
                      product[index]['address'],
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Buy Now",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 4, 28, 248),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
