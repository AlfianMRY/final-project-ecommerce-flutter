import 'package:final_project/pages/barang_detail_page.dart';
import 'package:final_project/pages/barang_page.dart';
import 'package:final_project/view/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/barang_add_page.dart';
import 'pages/barang_review_page.dart';
import 'pages/category_add_page.dart';
import 'pages/category_page.dart';
import 'providers/barang_provider.dart';
import 'providers/category_provider.dart';
import 'providers/review_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';
// import 'package:final_project/uifp//view/home.dart';
// import 'package:final_project/uifp/view/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
        home: const Splash(),
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

    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Final Project',
    //   theme: ThemeData(
    //     primarySwatch: Colors.orange,
    //   ),
    //   home: const Splash(),
    // );
  }
}
