import "package:flutter/material.dart";
import "package:todo_app/utils/dialogue_box.dart";
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
  final _controller = TextEditingController();
  final _descController = TextEditingController();

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
  void addNewItem() {
    final title = _controller.text;
    final description =
        _descController.text.isEmpty ? '' : _descController.text;

    if (title.isNotEmpty) {
      setState(() {
        toDoList.add(ToDoItem(
            title: title, description: description, isCompleted: false));
      });
    }
    Navigator.of(context).pop();
    _controller.clear();
    _descController.clear();
  }

  void checkboxChanged(bool? val, int index) {
    setState(() {
      toDoList[index].isCompleted = !toDoList[index].isCompleted;
    });
  }

  void createNewtask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: addNewItem,
            onCancel: () => Navigator.of(context).pop(),
            descController: _descController,
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
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
        floatingActionButton: FloatingActionButton(
          onPressed: createNewtask,
          backgroundColor: Colors.yellow,
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: toDoList.length,
          itemBuilder: (context, index) {
            return TodoTile(
              taskName: toDoList[index].title,
              isComplete: toDoList[index].isCompleted,
              onChanged: (val) => checkboxChanged(val, index),
              taskDesc: toDoList[index].description ?? '',
              deleteTask: (value) => deleteTask(index),
            );
          },
        ));
  }
}
