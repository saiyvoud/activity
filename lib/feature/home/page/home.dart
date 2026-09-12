import 'package:activity/feature/home/widget/category.dart';
import 'package:activity/feature/home/widget/product.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(Icons.account_circle_outlined, size: 30),
                ),
                Text("Profile", style: TextStyle(color: Colors.grey)),
                Spacer(),
                Container(
                  height: 50,
                  width: 100,
                  child: Row(
                    children: [
                      Text("LA"),
                      Image.network(
                        "https://cdn-icons-png.flaticon.com/512/197/197568.png",
                      ),
                    ],
                  ),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.forum)),
              ],
            ),
            //
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hint: Text('Search ....'),
                  suffixIcon: Icon(Icons.search_outlined),
                ),
              ),
            ),
            // Category
            Category(),
            Row(children: [Text("Event"), Spacer(), Text("All")]),
            Product(),
          ],
        ),
      ),
    );
  }
}
