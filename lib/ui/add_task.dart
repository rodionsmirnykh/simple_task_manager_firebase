import 'package:flutter/material.dart';
import 'package:simple_task_manager_firebase/net/flutterfirebase.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final taskNameController = TextEditingController();
  final taskDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: taskNameController,
              decoration: InputDecoration(
                hintText: 'Task name',
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              child: TextFormField(
                maxLines: 10,
                controller: taskDescriptionController,
                decoration: InputDecoration(
                  hintText: 'Task description',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await addNewTask(
                    taskNameController.text, taskDescriptionController.text);
                // something
                Navigator.of(context).pop();
              },
              child: Text('Add this task'),
            ),
          ],
        ),
      ),
    );
  }
}
