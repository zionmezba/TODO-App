import "package:flutter/material.dart";
import "package:hive/hive.dart";
import "package:todo_app/data/database.dart";
import "package:todo_app/utils/dialogue_box.dart";
import "package:todo_app/utils/todo_tile.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('mybox');
  TodoDatabase db = TodoDatabase();
  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();
  final _descController = TextEditingController();

  // Function to add a new item
  void addNewItem() {
    final title = _controller.text;
    final description =
        _descController.text.isEmpty ? '' : _descController.text;

    if (title.isNotEmpty) {
      setState(() {
        db.toDoList.add(ToDoItem(
            title: title, description: description, isCompleted: false));
      });
    }
    Navigator.of(context).pop();
    _controller.clear();
    _descController.clear();
    db.updateData();
  }

  void checkboxChanged(bool? val, int index) {
    setState(() {
      db.toDoList[index].isCompleted = !db.toDoList[index].isCompleted;
    });
    db.updateData();
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
    db.updateData();
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
      db.updateData();
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
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return TodoTile(
              taskName: db.toDoList[index].title,
              isComplete: db.toDoList[index].isCompleted,
              onChanged: (val) => checkboxChanged(val, index),
              taskDesc: db.toDoList[index].description ?? '',
              deleteTask: (value) => deleteTask(index),
            );
          },
        ));
  }
}
