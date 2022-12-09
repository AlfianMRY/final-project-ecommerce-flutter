import 'package:final_project/utils/color.dart';
import 'package:flutter/material.dart';

import '../pages/barang_page.dart';
import '../pages/category_page.dart';

class Test4 extends StatefulWidget {
  const Test4({super.key});

  @override
  State<Test4> createState() => _Test4State();
}

class _Test4State extends State<Test4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('My Profile')),
        backgroundColor: Color.fromARGB(1000, 40, 79, 73),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Email',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 1.0,
          ),
          Text(
            'Nama',
            style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
          ),
          SizedBox(
            height: 5,
          ),
          Divider(),
          Text('Umur'),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(colorGreen)),
                onPressed: () {
                  Navigator.of(context).pushNamed(BarangPage.routeName);
                },
                child: Text(
                  'Barang',
                  style: TextStyle(color: colorOrange),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(colorGreen)),
                onPressed: () {
                  Navigator.of(context).pushNamed(CategoryPage.routeName);
                },
                child: Text(
                  'Category',
                  style: TextStyle(color: colorOrange),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
