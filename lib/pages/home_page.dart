import "package:flutter/material.dart";
import "package:todo_app/utils/todo_tile.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class ToDoItem {
  final String title;
  final String? description; // Optional description
  bool isCompleted;

  ToDoItem({required this.title, this.description, required this.isCompleted});
}

class _HomePageState extends State<HomePage> {
  List<ToDoItem> toDoList = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      toDoList.addAll([
        ToDoItem(
            title: "Buy groceries",
            description: "Milk, bread, eggs",
            isCompleted: false),
        ToDoItem(title: "Finish report", isCompleted: true),
      ]);
    });
  }

  // Function to add a new item
  void addNewItem(String title, bool isCompleted, {String? description}) {
    setState(() {
      toDoList.add(ToDoItem(
          title: title, description: description, isCompleted: isCompleted));
    });
  }

  void checkboxChanged(bool? val, int index) {
    setState(() {
      toDoList[index].isCompleted = !toDoList[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          title: const Text('TO DO'),
          elevation: 0,
          backgroundColor: Colors.yellow,
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(onPressed: ,),
        body: ListView.builder(
          itemCount: toDoList.length,
          itemBuilder: (context, index) {
            return TodoTile(
              taskName: toDoList[index].title,
              isComplete: toDoList[index].isCompleted,
              onChanged: (val) => checkboxChanged(val, index),
              taskDesc: toDoList[index].description ?? '',
            );
          },
        ));
  }
}
