import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TodoTile extends StatelessWidget {
  const TodoTile(
      {super.key,
      required this.taskName,
      required this.isComplete,
      required this.onChanged,
      required this.taskDesc});

  final String taskName;
  final String taskDesc;
  final bool isComplete;
  final Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        padding: const EdgeInsets.all(25.0),
        decoration: BoxDecoration(
            color: Colors.yellow, borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Checkbox(value: isComplete, onChanged: onChanged),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(taskName,
                      style: TextStyle(
                          decoration: isComplete
                              ? TextDecoration.lineThrough
                              : TextDecoration.none)),
                  if (taskDesc != '') const SizedBox(height: 5),
                  if (taskDesc != '')
                    Text(
                      taskDesc,
                      style: TextStyle(
                          fontSize: 10,
                          decoration: isComplete
                              ? TextDecoration.lineThrough
                              : TextDecoration.none),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
