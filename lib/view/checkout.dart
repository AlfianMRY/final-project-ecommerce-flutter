import 'package:flutter/material.dart';

import 'home.dart';
// import 'package:final_project/uifp/view/home.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(name),
            Text(
              'Your Order has been accepted',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Your item is being processed! please be patient :)',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: (() => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (c) => const Home(),
                    ),
                  )),
              child: Container(
                height: 50,
                width: 250,
                child: Center(
                    child: Text(
                  'return to home',
                  style: TextStyle(color: Colors.white),
                )),
                color: Color.fromARGB(1000, 40, 79, 73),
              ),
            )
          ],
        ),
      ),
    );
  }
}
