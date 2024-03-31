import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/utils/custom_button.dart';

class DialogBox extends StatelessWidget {
  const DialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      content: Container(
        height: 220,
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: 'Add new task',
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Description',
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                CustomButton(text: 'Save', onPressed: () {}),
                const SizedBox(width: 10),
                CustomButton(text: 'Cancel', onPressed: () {}),
              ],
            )
          ],
        ),
      ),
    );
  }
}
