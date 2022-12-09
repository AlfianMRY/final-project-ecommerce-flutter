import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/barang_provider.dart';
import '../utils/color.dart';
import 'barang_detail_page.dart';

class BarangPage extends StatefulWidget {
  const BarangPage({super.key});

  static final routeName = 'barangPage';

  @override
  State<BarangPage> createState() => _BarangPageState();
}

class _BarangPageState extends State<BarangPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<BarangProvider>(context, listen: false).getAllBarang();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: colorGreen,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Semua Barang',
          style: TextStyle(color: colorGreen, fontWeight: FontWeight.w700),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorGreen,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () async {
          var response = await Navigator.pushNamed(context, 'barang-add');
          if (response == 'refresh') {
            setState(() {});
          }
        },
      ),
      body: Consumer<BarangProvider>(builder: (context, value, child) {
        if (value.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final barang = value.barang;
        // print(barang);
        if (barang.length <= 1 || barang == []) {
          return Center(
            child: Text('Items Not Found'),
          );
        } else {
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(
              thickness: 4,
            ),
            itemCount: barang.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.network(
                  '${barang[index].image}',
                ),
                title: Text(
                  '${barang[index].name}',
                  style:
                      TextStyle(color: colorGreen, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  '${barang[index].deskripsi}',
                  maxLines: 1,
                ),
                trailing: PopupMenuButton(
                  onSelected: (val) {
                    if (val == 'detail') {
                      print('${barang[index].id}');
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return BarangDetailPage(
                            barang: barang[index],
                          );
                        },
                      ));
                    } else if (val == 'delete') {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Confirm'),
                              content:
                                  Text('Are Your Sure To Delete This Item?'),
                              actions: [
                                ElevatedButton(
                                  child: Text('No'),
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                ),
                                ElevatedButton(
                                  child: Text('Yes'),
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                ),
                              ],
                            );
                          }).then((value) {
                        if (value == true) {
                          try {
                            Provider.of<BarangProvider>(context, listen: false)
                                .deleteBarang(barang[index].id.toString())
                                .then((value) {
                              setState(() {});
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Data Berhasil Di Hapus')));
                            });
                          } catch (e) {
                            print(e);
                          }
                        }
                      });
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: Text('Detail'),
                        value: 'detail',
                      ),
                      PopupMenuItem(
                        child: Text('Edit'),
                        onTap: () {},
                      ),
                      PopupMenuItem(
                        child: Text('Delete'),
                        value: 'delete',
                        onTap: () {},
                      ),
                    ];
                  },
                ),
              );
            },
          );
        }
      }),
    );
  }
}
