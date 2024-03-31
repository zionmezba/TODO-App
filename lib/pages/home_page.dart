import "package:flutter/material.dart";
import "package:hive_flutter/hive_flutter.dart";
import "package:todo_app/data/boxes/boxes.dart";
import "package:todo_app/utils/dialogue_box.dart";
import "package:todo_app/utils/todo_model.dart";
import "package:todo_app/utils/todo_tile.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final box = Boxes.getData();
  @override
  void initState() {
    print(box.get('title'));
    if (box.get('title') == null || box.get('title') == '') {
      box.addAll([
        ToDoItem(title: "Add as many as you want", isCompleted: false),
        ToDoItem(
            title: "Swipe right to left",
            description: "Swipe right to left to delete a task",
            isCompleted: false),
      ]);
    }
    super.initState();
  }

  final _controller = TextEditingController();
  final _descController = TextEditingController();

  // Function to add a new item
  void addNewItem() {
    final data =
        ToDoItem(title: _controller.text, description: _descController.text);

    if (data.title.isNotEmpty) {
      box.add(data);
      data.save();
    }
    Navigator.of(context).pop();
    _controller.clear();
    _descController.clear();
  }

  void updateItem(ToDoItem todos) {
    setState(() {
      todos.title = _controller.text.toString();
      todos.description = _descController.text.toString();
    });

    Navigator.of(context).pop();
    _controller.clear();
    _descController.clear();
  }

  void checkboxChanged(List<ToDoItem> data, int index) {
    setState(() {
      data[index].isCompleted = !data[index].isCompleted;
    });
  }

  void createNewtaskDialogueBox() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: addNewItem,
            onCancel: () => Navigator.of(context).pop(),
            descController: _descController,
            title: 'Add New',
          );
        });
  }

  void editTaskDialogueBox(ToDoItem todo) {
    _controller.text = todo.title;
    _descController.text = todo.description!;
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            title: 'Edit Todo',
            controller: _controller,
            onSave: () => updateItem(todo),
            onCancel: () => Navigator.of(context).pop(),
            descController: _descController,
          );
        });
    // db.updateData();
  }

  void deleteTask(ToDoItem todos) async {
    await todos.delete();
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
          onPressed: createNewtaskDialogueBox,
          backgroundColor: Colors.yellow,
          child: const Icon(Icons.add),
        ),
        body: ValueListenableBuilder<Box<ToDoItem>>(
            valueListenable: Boxes.getData().listenable(),
            builder: (context, box, _) {
              var data = box.values.toList().cast<ToDoItem>().reversed.toList();
              return ListView.builder(
                reverse: false,
                itemCount: box.length,
                itemBuilder: (context, index) {
                  return TodoTile(
                    taskName: data[index].title,
                    isComplete: data[index].isCompleted,
                    onChanged: (val) => checkboxChanged(data, index),
                    taskDesc: data[index].description ?? '',
                    deleteTask: (value) => deleteTask(data[index]),
                    onPressedEdit: () => editTaskDialogueBox(data[index]),
                  );
                },
              );
            }));
  }
}
