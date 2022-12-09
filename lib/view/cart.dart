import 'package:flutter/material.dart';

import 'checkout.dart';
// import 'package:final_project/uifp/view/checkout.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('cart'),
        backgroundColor: Color.fromARGB(1000, 40, 79, 73),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              child: Center(
                  child: Text(
                'Image',
                style: TextStyle(color: Colors.black),
              )),
              color: Colors.grey,
            ),
            SizedBox(
              height: 330,
            ),
            GestureDetector(
              onTap: (() => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (c) => const Checkout(),
                    ),
                  )),
              child: Container(
                height: 50,
                width: 250,
                child: Center(
                    child: Text(
                  'beli',
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
