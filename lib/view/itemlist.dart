import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/models/barang.dart';
import 'package:final_project/providers/barang_provider.dart';
import 'package:final_project/utils/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/barang_detail_page.dart';
import '../screen/login.dart';
import '../utils/currency_format.dart';
// import 'detailitem.dart';

class Cart1 extends StatefulWidget {
  const Cart1({super.key});

  @override
  State<Cart1> createState() => _Test2State();
}

class _Test2State extends State<Cart1> {
  final List<Map> myProducts =
      List.generate(10, (index) => {"id": index, "name": "Product $index"})
          .toList();

  logout() async {
    await FirebaseAuth.instance.signOut();
    prefs.remove("isuserlogin");
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) {
      return const Login();
    }), (route) => false);
  }

  var _firebase;
  var fav = false;

  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      prefs = value;
    });
    _firebase = FirebaseFirestore.instance.collection("ImageStore");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<BarangProvider>(context, listen: false).getAllBarang();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBgLight,
      endDrawer: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [Text('data')],
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              logout();
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
        title: const Center(
            child: Text(
          "My Toko",
          style: TextStyle(color: Colors.orange),
        )),
        backgroundColor: Color.fromARGB(1000, 40, 79, 73),
      ),
      body: Consumer<BarangProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (value.barang.isEmpty) {
            return Center(
              child: Text('Belum ada barang'),
            );
          } else {
            var barang = value.barang;
            return Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 120,
                  color: colorGreen,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Set up your space easily',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 22),
                      ),
                      SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            color: Colors.white),
                        margin: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.1),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            hintText: 'Search Item',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    primary: true,
                    itemExtent: 100,
                    // separatorBuilder: (context, index) => SizedBox(width: 15),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: index == 0 ? colorOrange : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        // padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(16),

                        // width: 50,
                        height: 30,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(index == 0
                                ? Icons.star_border
                                : Icons.get_app_sharp),
                            Text('${index + 1}')
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 200, crossAxisCount: 2),
                    itemCount: barang.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return CardItem(context, barang, index);
                    },
                  ),
                ),
              ],
            );
          }
        },
        // child: ,
      ),
    );
  }

  GestureDetector CardItem(
      BuildContext context, List<Barang> barang, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return BarangDetailPage(
                barang: barang[index],
              );
            },
          ),
        );
      },
      child: Container(
        height: 130,
        margin: EdgeInsets.all(8),
        // color: colorBgLight,
        child: Stack(
          clipBehavior: Clip.antiAlias,
          children: [
            Positioned(
              top: 70,
              right: 0,
              left: 0,
              bottom: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: EdgeInsets.only(top: 46, left: 8, right: 8),
                  height: 300,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        barang[index].name.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 145, 145, 145),
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            CurrencyFormat.convertToIdr(barang[index].harga, 2),
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          Text(barang[index].stock.toString()),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 42),
              child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 5),
                    color: Colors.black,
                    // blurRadius: 5.0,
                  ),
                ], borderRadius: BorderRadius.circular(16)),
                height: 100,
                // height: double.infinity,
                width: MediaQuery.of(context).size.width * 0.5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    barang[index].image.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    barang[index].fav = !barang[index].fav;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // color: colorBgLight,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    barang[index].fav == true
                        ? Icons.favorite
                        : Icons.favorite_border,
                    size: 18,
                    color:
                        barang[index].fav == true ? Colors.red : Colors.black,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
