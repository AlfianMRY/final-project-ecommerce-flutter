// import 'package:final_project_provider/pages/category_add_page.dart';
// import 'package:final_project_provider/pages/category_edit_page.dart';
// import 'package:final_project_provider/providers/category_provider.dart';
// import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/category_provider.dart';
import '../utils/color.dart';
import 'category_add_page.dart';
import 'category_edit_page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});
  static final routeName = 'categoryPage';

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CategoryProvider>(context, listen: false).getAllCategory();
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
          'Semua Kategory',
          style: TextStyle(color: colorGreen, fontWeight: FontWeight.w700),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, CategoryAddPage.routeName);
        },
        backgroundColor: colorGreen,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Consumer<CategoryProvider>(
        builder: (context, value, child) {
          if (value.isLoading == true) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (value.category.length == 0) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var category = value.category;
            return ListView.separated(
              itemCount: category.length,
              separatorBuilder: (context, index) => Divider(
                thickness: 2,
              ),
              itemBuilder: (context, index) => ListTile(
                title: Text(category[index].name.toString()),
                trailing: PopupMenuButton(
                  onSelected: (val) {
                    if (val == 'edit') {
                      print('${category[index].id}');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryEditPage(
                              category: category[index],
                            ),
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
                            Provider.of<CategoryProvider>(context,
                                    listen: false)
                                .deleteCategory(
                              id: category[index].id.toString(),
                            )
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
                        child: Text('Edit'),
                        value: 'edit',
                      ),
                      PopupMenuItem(
                        child: Text('Delete'),
                        value: 'delete',
                      ),
                    ];
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
