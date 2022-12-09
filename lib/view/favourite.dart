import 'package:flutter/material.dart';

import 'detailitem.dart';

class Test3 extends StatefulWidget {
  const Test3({super.key});

  @override
  State<Test3> createState() => _Test3State();
}

class _Test3State extends State<Test3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Favourite")),
        backgroundColor: Color.fromARGB(1000, 40, 79, 73),
      ),
      body: ListView.builder(
        itemCount: 15,
        itemBuilder: ((context, index) {
          return ListTile(
            leading: Container(
              color: Colors.grey,
              height: 150,
              width: 100,
              child: const Text("image"),
            ),
            title: const Text('Nama Item'),
            subtitle: const Text('Harga'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => const DetailItem(),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
