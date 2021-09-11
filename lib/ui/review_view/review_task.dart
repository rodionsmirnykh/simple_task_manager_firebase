import 'package:flutter/material.dart';
import 'package:simple_task_manager_firebase/net/flutterfirebase.dart';

class ReviewTask extends StatefulWidget {
  final String taskName;
  ReviewTask(this.taskName);

  @override
  _ReviewTaskState createState() => _ReviewTaskState();
}

class _ReviewTaskState extends State<ReviewTask> {
  final taskReviewController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.taskName),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              child: TextFormField(
                maxLines: 10,
                controller: taskReviewController,
                decoration: InputDecoration(
                  hintText: 'Review',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await changeTaskStatus(widget.taskName, STATUS.done);
                Navigator.of(context).pop();
              },
              child: Text('End this task'),
            ),
            ElevatedButton(
              onPressed: () async {
                await reviewTask(widget.taskName, taskReviewController.text);
                // something
                Navigator.of(context).pop();
              },
              child: Text('Review this task'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
