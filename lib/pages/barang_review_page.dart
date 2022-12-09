// ignore_for_file: must_be_immutable

// import 'package:final_project_provider/providers/review_provider.dart';
// import 'package:final_project_provider/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../providers/review_provider.dart';
import '../utils/color.dart';

class BarangReviewPage extends StatefulWidget {
  var id;
  final review;
  static final routeName = 'barang-review';
  BarangReviewPage({super.key, this.id, this.review});

  @override
  State<BarangReviewPage> createState() => _BarangReviewPageState();
}

class _BarangReviewPageState extends State<BarangReviewPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ReviewProvider>(context, listen: false)
          .getAllReview(widget.id.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: colorGreen,
            )),
        title: Text(
          'Review',
          style: TextStyle(color: colorGreen, fontWeight: FontWeight.w700),
        ),
      ),
      body: Consumer<ReviewProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (value.review.length == 0) {
            return Center(
              child: Text('Belum Ada Review'),
            );
          } else {
            var review = value.review;

            var hasil = 0;
            for (var i in value.review) {
              hasil = hasil + i.star!.toInt();
            }
            return Container(
              color: colorBgLight,
              child: Column(
                children: [
                  Container(
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RatingBar.builder(
                          unratedColor: colorGreen,
                          initialRating: hasil / review.length,
                          ignoreGestures: true,
                          updateOnDrag: false,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                        Text((hasil / review.length).toString()),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: review.length,
                      itemBuilder: (context, index) {
                        List<Icon> star = [];
                        for (var i = 0; i < 5; i++) {
                          if (review[index].star! >= i) {
                            star.add(Icon(
                              Icons.star_rounded,
                              color: colorOrange,
                            ));
                          } else {
                            star.add(Icon(
                              Icons.star_rounded,
                              color: colorGreen,
                            ));
                          }
                        }
                        // print(star);
                        return Container(
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(vertical: 5),
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    child: Icon(Icons.person),
                                    backgroundColor: colorGreen,
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(review[index].user!.name.toString()),
                                      Row(
                                        children: [
                                          RatingBar.builder(
                                            itemSize: 16,
                                            unratedColor: colorGreen,
                                            initialRating:
                                                review[index].star!.toDouble(),
                                            ignoreGestures: true,
                                            updateOnDrag: false,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            // itemPadding:
                                            //     EdgeInsets.symmetric(horizontal: 4.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                          SizedBox(width: 10),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2.5),
                                            child: Text(
                                                '${review[index].star!.toDouble()}'),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Divider(
                                thickness: 3,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(review[index].review.toString()),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
