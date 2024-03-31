import 'package:hive_flutter/hive_flutter.dart';
part 'todo_model.g.dart';

@HiveType(typeId: 0)
class ToDoItem extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String? description;

  @HiveField(2)
  bool isCompleted;

  ToDoItem({required this.title, this.description, this.isCompleted = false});
}
