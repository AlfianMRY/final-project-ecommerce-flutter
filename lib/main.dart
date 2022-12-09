import 'package:final_project_provider/pages/barang_add_page.dart';
import 'package:final_project_provider/pages/barang_detail_page.dart';
import 'package:final_project_provider/pages/barang_page.dart';
import 'package:final_project_provider/pages/barang_review_page.dart';
import 'package:final_project_provider/pages/category_add_page.dart';
import 'package:final_project_provider/pages/category_page.dart';
import 'package:final_project_provider/pages/home_page.dart';
import 'package:final_project_provider/providers/barang_provider.dart';
import 'package:final_project_provider/providers/category_provider.dart';
import 'package:final_project_provider/providers/review_provider.dart';
// import 'package:final_project_provider/providers/barang.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => BarangProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ReviewProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CategoryProvider(),
        )
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Test Provider Final Project',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
        routes: {
          BarangPage.routeName: (context) => BarangPage(),
          BarangDetailPage.routeName: (context) => BarangDetailPage(),
          BarangAddPage.routeName: (context) => BarangAddPage(),
          BarangReviewPage.routeName: (context) => BarangReviewPage(),
          CategoryPage.routeName: (context) => CategoryPage(),
          CategoryAddPage.routeName: (context) => CategoryAddPage(),
        },
      ),
    );
  }
}
