class Todo{
  String? title;
  String? category;
  String? todoDate;
  String? description;
  int? id;


  todoMap(){
    var mapping =Map<String,dynamic>();
    mapping["id"]=id;
    mapping["category"]=category;
    mapping["todoDate"]=todoDate;
    mapping["title"]=title;
    mapping["description"]=description;
    return mapping;
  }
}