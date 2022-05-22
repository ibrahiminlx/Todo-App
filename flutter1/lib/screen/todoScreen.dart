import 'package:flutter/material.dart';
import 'package:flutter1/screen/homeScreen.dart';
import 'package:intl/intl.dart';
import 'package:clock/clock.dart';
import '../services/category_service.dart';
import '../services/todo_service.dart';
import '../models/Todo.dart';


class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var todoTitleController = TextEditingController();
  var todoDescriptionController = TextEditingController();
  var todoDateController = TextEditingController();
  var _categoryService = CategoryService();

  var _selectedValue;
  Todo _todo =  Todo();
  TodoService _todoService = TodoService();




  List<DropdownMenuItem<String>> dropdownItems = List<DropdownMenuItem<String>>.empty(growable: true);

  getAllCategories() async{
    var categories = await _categoryService.readCategories();
    //print(categories);

    categories.forEach((value) {
      //print(value['name']);
      dropdownItems.add(DropdownMenuItem(child: Text(value['name']),value: value['name']));
      setState(() {});
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
        title: const Text("Create Todo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: todoTitleController,
              decoration: const InputDecoration(
                labelText: "title",
                hintText: "write todo title"
              ),
            ),
            TextField(
              controller: todoDescriptionController,
              decoration: const InputDecoration(
                  labelText: "Description",
                  hintText: "write todo description"
              ),
            ),
            TextField(
              controller: todoDateController,
              decoration: InputDecoration(
                  labelText: "Date",
                  hintText: "Pick a date",
                prefixIcon: InkWell(
                  onTap: () async{
                    DateTime selectedDate = clock.now();


                    final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2015, 8),
                        lastDate: DateTime(2101)
                    );
                    if (picked != null && picked != selectedDate) {
                      setState(() {
                        selectedDate = picked;
                        todoDateController.value = todoDateController.value.copyWith(
                          text: DateFormat('yyyy/MM/dd').format(selectedDate)
                        );

                      });
                    }

                  },

                  child: const Icon(Icons.calendar_today),
                )
              ),
            ),

            DropdownButtonFormField(
                items: dropdownItems,
                value: _selectedValue,
                onChanged: (value){
                setState(() {
                  _selectedValue = value;
                });
              }),const SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () async{
                    _todo.title = todoTitleController.text;
                    _todo.description = todoDescriptionController.text;
                    _todo.todoDate = todoDateController.text;
                    _todo.category = _selectedValue;
                    var result = await _todoService.saveTodo(_todo);
                    //print(result);

                    if (result>0){
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                          HomeScreen()
                      ),(Route<dynamic> route) => false);
                    }
              },
              color: Colors.blue,
              child: Text("Save",style: const TextStyle(color:Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
