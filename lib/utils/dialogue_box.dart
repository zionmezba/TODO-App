import 'package:flutter/material.dart';
import 'package:todo_app/utils/custom_button.dart';

class DialogBox extends StatelessWidget {
  const DialogBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel,
      required this.descController});

  final VoidCallback onSave;
  final VoidCallback onCancel;

  final TextEditingController controller;
  final TextEditingController descController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      content: Container(
        height: 220,
        child: Column(
          children: [
            TextField(
              controller: controller,
          
              decoration: InputDecoration(
                
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: 'Add new task',
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TextField(
                controller: descController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Description',
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(text: 'Save', onPressed: onSave),
                const SizedBox(width: 10),
                CustomButton(text: 'Cancel', onPressed: onCancel),
              ],
            )
          ],
        ),
      ),
    );
  }
}
