// import 'dart:convert';

// ignore_for_file: must_be_immutable

import 'package:final_project_provider/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/category.dart';

import '../utils/color.dart';

class CategoryEditPage extends StatefulWidget {
  CategoryEditPage({super.key, required this.category});
  Category category;
  static final routeName = 'addCategory';

  @override
  State<CategoryEditPage> createState() => _CategoryEditPageState();
}

class _CategoryEditPageState extends State<CategoryEditPage> {
  // var name = widget.category.name.toString();

  @override
  Widget build(BuildContext context) {
    TextEditingController _name =
        TextEditingController(text: widget.category.name);
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
          'Edit Kategory',
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
                      .editForm(
                          nameC: _name.text, id: widget.category.id.toString());
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
