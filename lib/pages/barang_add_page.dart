import 'dart:convert';
import 'dart:io';
// import 'package:final_project_provider/utils/color.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
// import 'package:final_project_provider/providers/barang_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../providers/barang_provider.dart';
import '../utils/color.dart';

// ignore: must_be_immutable
class BarangAddPage extends StatefulWidget {
  BarangAddPage({super.key});

  static final routeName = 'barang-add';

  @override
  State<BarangAddPage> createState() => _BarangAddPage();
}

class _BarangAddPage extends State<BarangAddPage> {
  @override
  void initState() {
    if (mounted) {
      super.initState();
      categoryItems();
    }
  }

  final _formKey = GlobalKey<FormState>();

  var token = '3187|fzHMS0qfMrflTW5QdkMx1yxtzQMR3LXMg0279KMg';

  File? image;
  List _menuItems = [];
  String? _selectedValue = null;
  TextEditingController _nameC = TextEditingController();
  TextEditingController _stockC = TextEditingController();
  TextEditingController _descriptionC = TextEditingController();
  TextEditingController _priceC = TextEditingController();

  @override
  void dispose() {
    _nameC.dispose();
    _stockC.dispose();
    _descriptionC.dispose();
    _priceC.dispose();
    super.dispose();
  }

  Future getImage(String action) async {
    final ImagePicker _picker = ImagePicker();
    var actionImage;
    if (action == 'galery') {
      actionImage = ImageSource.gallery;
    } else if (action == 'camera') {
      actionImage = ImageSource.camera;
    }
    final imagePicked =
        await _picker.pickImage(source: actionImage, imageQuality: 80);

    if (imagePicked != null) {
      setState(() {
        image = File(imagePicked.path);
      });
    } else {
      return;
    }
  }

  Future categoryItems() async {
    try {
      var response = await http.get(
        Uri.parse('https://api1.sib3.nurulfikri.com/api/admin/category'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      var data = jsonDecode(response.body);
      if (this.mounted) {
        setState(() {
          _menuItems = data['data'];
        });
      }
    } catch (e) {
      print(e);
    }
    // return data;
  }

  @override
  Widget build(BuildContext context) {
    categoryItems();
    // print($token);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: colorGreen,
            )),
        backgroundColor: Colors.white,
        title: Text(
          'Tambah Barang',
          style: TextStyle(color: colorGreen, fontWeight: FontWeight.w700),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  color: Colors.grey.shade400,
                  // margin: EdgeInsets.all(10),
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      image != null
                          ? Center(
                              child: Image.file(
                                image!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(),
                      Center(
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(colorGreen),
                              ),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Pilih Foto'),
                                        content: Text('Upload foto dari :'),
                                        actions: [
                                          ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      colorGreen),
                                            ),
                                            child: Text('Camera'),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop('camera');
                                            },
                                          ),
                                          ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      colorGreen),
                                            ),
                                            child: Text('galery'),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop('galery');
                                            },
                                          ),
                                        ],
                                      );
                                    }).then((value) async {
                                  if (value != null) {
                                    await getImage(value);
                                  }
                                });
                              },
                              child: Text('Pilih Foto')))
                    ],
                  ),
                ),
                TextFormField(
                  controller: _nameC,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukan Nama';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: DropdownButtonFormField(
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      hint: Text('Pilih Kategori'),
                      validator: (value) =>
                          value == null ? "Pilih Kategori" : null,
                      items: _menuItems.map((item) {
                        return DropdownMenuItem(
                          value: item['id'].toString(),
                          child: Text(item['name'].toString()),
                        );
                      }).toList(),
                      value: _selectedValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedValue = newValue;
                          print(_selectedValue);
                        });
                      }),
                ),
                TextFormField(
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: _stockC,
                  decoration: InputDecoration(labelText: 'Stock'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukan Stock';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionC,
                  decoration: InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukan Deskripsi';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _priceC,
                  keyboardType: TextInputType.numberWithOptions(),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  decoration:
                      InputDecoration(labelText: 'Price', prefixText: 'Rp. '),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukan Harga';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(colorGreen),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate() &&
                          image != null &&
                          _selectedValue != null) {
                        var response = await Provider.of<BarangProvider>(
                                context,
                                listen: false)
                            .submitForm(
                                name: _nameC,
                                stock: _stockC,
                                category: _selectedValue,
                                deskripsi: _descriptionC,
                                harga: _priceC,
                                image: image!.path);
                        if (response.statusCode == 200) {
                          Navigator.pop(context, 'refresh');
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Berhasil Upload')));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Gagal Upload')));
                        }
                      }
                      if (image == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Foto Harus Di Isi')));
                      }
                    },
                    child: Text('Submit'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
