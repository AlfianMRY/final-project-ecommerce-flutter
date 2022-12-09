// import 'dart:convert';

import 'package:final_project_provider/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/color.dart';

class CategoryAddPage extends StatefulWidget {
  const CategoryAddPage({super.key});
  static final routeName = 'addCategory';

  @override
  State<CategoryAddPage> createState() => _CategoryAddPageState();
}

class _CategoryAddPageState extends State<CategoryAddPage> {
  TextEditingController _name = TextEditingController();

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
          'Tambah Kategory',
          style: TextStyle(color: colorGreen, fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Column(
          children: [
            Form(
              child: TextFormField(
                controller: _name,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukan Nama';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(colorGreen)),
                onPressed: () async {
                  var response = await Provider.of<CategoryProvider>(context,
                          listen: false)
                      .submitForm(nameC: _name.text);
                  // var resDecode = jsonDecode(response);
                  if (response == 'success') {
                    Navigator.pop(context, 'refresh');
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Berhasil Upload')));
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Gagal Upload')));
                  }
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
