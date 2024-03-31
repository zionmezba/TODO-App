import 'package:hive_flutter/hive_flutter.dart';

class TodoDatabase {
  List<ToDoItem> toDoList = [];

  final _myBox = Hive.box('mybox');

  void createInitialData() {
    toDoList.addAll([
      ToDoItem(
          title: "Swipe right to left",
          description: "Swipe right to left to delete a task",
          isCompleted: false),
      ToDoItem(title: "Add as many as you want", isCompleted: false),
    ]);
  }

  void loadData() {
    toDoList = _myBox.get('TODOLIST');
  }

  void updateData() {
    _myBox.put('TODOLIST', toDoList);
  }
}

class ToDoItem {
  final String title;
  final String? description; // Optional description
  bool isCompleted;

  ToDoItem({required this.title, this.description, required this.isCompleted});
}
