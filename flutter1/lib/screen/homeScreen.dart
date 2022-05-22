import 'package:flutter/material.dart';
import 'package:flutter1/helpers/drawerNavigation.dart';
import 'package:flutter1/models/todo.dart';
import 'package:flutter1/screen/todoScreen.dart';
import 'package:flutter1/services/todo_service.dart';

class HomeScreen extends StatefulWidget {
  static String category = '';

  const HomeScreen({Key? key}) : super(key: key);


  @override
  State<HomeScreen> createState() => _HomeScreenState(category);
}

class _HomeScreenState extends State<HomeScreen> {
  static String category = '';

  _HomeScreenState(String c){
    category = c;
  }

  var _TodoService = TodoService();
  List<Todo> _TodoList = List<Todo>.empty(growable: true);

  getAllCategories() async{
    var data = await _TodoService.readTodo(category);
    data.forEach((category) {
      setState(() {
        var todo = Todo();
        todo.title = category["title"];
        todo.category = category["category"];
        todo.todoDate = category["todoDate"];
        todo.id = category["id"];
        _TodoList.add(todo);
      });
    });
  }


  @override
  void initState(){
    super.initState();
    getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("todo list"),
      ),
      drawer: DrawerNavigation(),
      body: ListView.builder(
          itemCount: _TodoList.length,
          itemBuilder: (context,index){
            return Padding(padding: const EdgeInsets.only(top:8.0,left:16.0,right:16.0),
              child: Card(
                elevation: 8.0,
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(_TodoList[index].title.toString()),
                      Text(_TodoList[index].todoDate.toString()),
                    ],
                  ),
                  subtitle: Text(_TodoList[index].category.toString()),
                ),
              ),
            );}),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {Navigator.of(context).push(MaterialPageRoute(builder: (contex)=>TodoScreen()));},
        child: Icon(Icons.add),
      ),
    );
  }
}
