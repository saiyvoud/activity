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
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUC1WcJ5NovCtPqqyATD7EVJSwh8mBAR-SXJ-JhESEj4f7P2NIkPK9VkxQ&s=10",
      "address": "Bangkok Thailand"
    },
    {
      "id": 2,
      "title": "Explore Laos",
      "date": "31/10/2026",
      "time": "15:00 - 23:30",
      "image": "https://ak-d.tripcdn.com/images/1mi33224x9aaoeyor9D26.jpg?proc=resize%2Fm_z%2Cw_375%2Ch_0%3Bformat%2Ff_webp%2C9C2E",
      "address": "Laos PDR"
    },
    {
      "id": 3,
      "title": "Biggest Music",
      "date": "28/8/2026",
      "time": "8:00 - 12:00",
      "image": "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/music-concert-flyer-design-template-2d59fde071fcf31f0d8a138b3a6e516d_screen.jpg?ts=1737708040",
       "address": "Bangkok Thailand"
    },
    {
      "id": 4,
      "title": "Run the canyon just outside",
      "date": "28/8/2026",
      "time": "8:00 - 12:00",
      "image": "https://d2mkojm4rk40ta.cloudfront.net/us-east-1-src/prod/clientUploads/2026-05/04/1/72731/7747e22b-2c22-41ca-bff7-64e13e80cf61-bP-qPu.png",
       "address": "Bangkok Thailand"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: product.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(color: Colors.blueAccent,borderRadius: BorderRadius.circular(10)),
          child: Column(children: [
            Image.network(product[index]['image'],fit: BoxFit.cover,height: 120,width: double.infinity,),
            Text(product[index]['title'],style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            Row(children: [
              Icon(Icons.calendar_today),
              Text(product[index]['date']),
            ],),
            Row(children: [
              Icon(Icons.alarm),
              Text(product[index]['time']),
            ],),
             Row(children: [
              Icon(Icons.location_on),
              Text(product[index]['address']),
            ],),
            TextButton(onPressed: (){}, child: Text("Buy",style: TextStyle(color: Colors.white),)),
          ],),
        );
      },
    );
  }
}
