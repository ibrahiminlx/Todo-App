import 'package:flutter/material.dart';
import 'package:flutter1/screen/categoriesScreen.dart';
import 'package:flutter1/screen/homeScreen.dart';

import '../models/category.dart';
import '../services/category_service.dart';

class DrawerNavigation extends StatefulWidget {
  const DrawerNavigation({Key? key}) : super(key: key);

  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}


class _DrawerNavigationState extends State<DrawerNavigation> {
  var _category =Category();
  var _categoryService = CategoryService();
  List<Category> _categoryList = List<Category>.empty(growable: true);
  @override
  void initState(){
    super.initState();
    getAllCategories();
  }
  List<ListTile> categoryList = List<ListTile>.empty(growable: true);

  getAllCategories() async{
    var categories = await _categoryService.readCategories();
    //print(categories);

    categories.forEach((value) {
      //print(value['name']);
      categoryList.add( ListTile(
        title: Text(value['name']),
        onTap: ()=> {
            HomeScreen.category = value['name'],
            Navigator.of(context).push(MaterialPageRoute( builder: (context) => HomeScreen())),
        }
      ));

      setState(() {

      });
    });
  }


  var image='http://cdn.onlinewebfonts.com/svg/img_524503.png';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children:  <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(image),
              ),
              accountName: Text("test"),
              accountEmail: Text("admin@admin.com"),
              decoration: BoxDecoration(color: Colors.pinkAccent),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("home"),
              onTap: ()=>{
                HomeScreen.category = '',
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()))
             }),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text("Categories"),
              onTap: ()=>Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CategoriesScreen())
              ),
            ),
            ...categoryList.toList()


          ],
        ),
      ),
    );
  }
}
