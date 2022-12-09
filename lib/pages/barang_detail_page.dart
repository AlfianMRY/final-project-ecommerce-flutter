// import 'package:final_project_provider/providers/barangProvider.dart';
// import 'package:final_project_provider/pages/barang_review_page.dart';
// import 'package:final_project_provider/providers/review_provider.dart';
// import 'package:final_project_provider/utils/color.dart';
// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../providers/review_provider.dart';
import '../utils/color.dart';
import '../utils/currency_format.dart';
import 'barang_review_page.dart';
// import 'package:provider/provider.dart';

class BarangDetailPage extends StatefulWidget {
  BarangDetailPage({super.key, this.barang});
  static final routeName = 'detail-barang';
  final barang;

  @override
  State<BarangDetailPage> createState() => _BarangDetailPageState();
}

class _BarangDetailPageState extends State<BarangDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ReviewProvider>(context, listen: false)
          .getAllReview(widget.barang.id.toString());
    });
  }

  bool active = true;

  int _item = 1;

  void _addItem() {
    setState(() {
      _item++;
    });
    print('tambah $_item');
  }

  void _lessItem() {
    setState(() {
      if (_item > 1) {
        _item--;
      }
    });
    print('kurang $_item');
  }

  @override
  Widget build(BuildContext context) {
    var barang = widget.barang;
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton(
              style: ButtonStyle(
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                )),
              ),
              onPressed: () {},
              child: Text(
                'Add to Cart',
                style: TextStyle(color: colorGreen),
              ),
            ),
            ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(colorGreen),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
                ),
                onPressed: () {},
                icon: Icon(Icons.space_dashboard_rounded),
                label: Text('Set in your space'))
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leadingWidth: 80,
          leading: Container(
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(16)),
            margin: EdgeInsets.only(top: 10, left: 20),
            child: IconButton(
              color: colorOrange,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  barang.image,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.5,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.black87, Colors.transparent],
                          begin: Alignment.topCenter,
                          end: Alignment.center)),
                ),
              ],
            ),
            Container(
              color: colorBgLight,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          barang.name,
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              color: colorGreen),
                        ),
                        Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(16)),
                            child: Icon(Icons.bookmark_outline)),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            CurrencyFormat.convertToIdr(barang.harga, 2),
                            style: TextStyle(
                                color: colorOrange,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => _lessItem(),
                                child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: colorOrange,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    color: colorOrange,
                                  ),
                                ),
                              ),
                              Text('$_item'),
                              GestureDetector(
                                onTap: () => _addItem(),
                                child: Container(
                                  margin: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: colorOrange,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: colorOrange,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    color: colorOrange,
                    size: 32,
                  ),
                  Consumer<ReviewProvider>(
                    builder: (context, value, child) {
                      if (value.isLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (value.review.length == 0) {
                        return Text('Belum ada review');
                      } else {
                        var hasil = 0;
                        for (var i in value.review) {
                          hasil = hasil + i.star!.toInt();
                        }
                        var review = value.review;
                        var rating = (hasil / review.length);
                        return Text(
                            '$rating Total Dari ${review.length} Review');
                      }
                    },
                  ),
                ],
              ),
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: MaterialButton(
                    color: colorBgLight,
                    onPressed: () {
                      setState(() {
                        active = true;
                      });
                    },
                    child: Text(
                      'Deskripsi',
                      style:
                          TextStyle(color: active ? colorOrange : colorBgDark),
                    ),
                  ),
                ),
                MaterialButton(
                  // color: active == false ? colorBgLight : Colors.white70,
                  onPressed: () async {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return BarangReviewPage(
                          id: barang.id,
                        );
                      },
                    ));
                  },
                  child: Text('Review'),
                ),
              ],
            ),
            Divider(
              thickness: 2,
              color: colorGreen,
              indent: 8,
              endIndent: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Text(barang.deskripsi),
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
