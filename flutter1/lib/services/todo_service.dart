import 'package:flutter1/repositories/repository.dart';
import '../models/Todo.dart';

class TodoService{
  Repository? _repository;
  TodoService(){
    _repository=Repository();
  }
  saveTodo(Todo todo) async{
    return await _repository?.insertData("todos",todo.todoMap());
  }
  readTodo(String category) async{
    if(category == ''){
      return await _repository?.readData("todos");
    }else {
      return await _repository?.readDataByCategory("todos",category);
   }
  }
  readTodoById(Id) async{
    return await _repository?.readDataById("todos",Id);
  }
  updateTodo(Todo todo) async{
    return await _repository?.updateData("todos",todo.todoMap());
  }
  deleteTodo(TodoId) async{
    return await _repository?.deleteDate("todos",TodoId);
  }
}