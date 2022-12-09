import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'detailitem.dart';

class CartItem extends StatefulWidget {
  const CartItem({super.key});

  @override
  State<CartItem> createState() => _TestState();
}

class _TestState extends State<CartItem> {
  // List _post = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('my cart')),
        backgroundColor: Color.fromARGB(1000, 40, 79, 73),
      ),
      body: ListView.builder(
        itemCount: 5,
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

  Future _getData() async {
    try {
      var headers = {
        'Authorization': 'Bearer 2957|YN1MLjIrQPt1QR17a4nrrFaxMh7a3Vk8lUjEnswP',
      };
      var request = http.Request(
          'GET', Uri.parse('https://api1.sib3.nurulfikri.com/api/barang'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }
}
