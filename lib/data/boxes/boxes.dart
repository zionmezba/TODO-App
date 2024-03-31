import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/utils/todo_model.dart';

class Boxes {
  static Box<ToDoItem> getData() => Hive.box('todos');
}
