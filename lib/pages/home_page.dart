import 'package:final_project_provider/pages/barang_page.dart';
import 'package:final_project_provider/pages/category_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
        centerTitle: true,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(BarangPage.routeName);
              },
              child: Text('Barang'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CategoryPage.routeName);
              },
              child: Text('Category'),
            ),
          ],
        ),
      ),
    );
  }
}
