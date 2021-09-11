import 'package:flutter/material.dart';
import 'package:simple_task_manager_firebase/net/flutterfirebase.dart';

class InWorkTaskView extends StatelessWidget {
  final String taskLabel;
  final String taskDesc;
  final String taskTaken;
  final String taskCreated;

  InWorkTaskView(
      this.taskLabel, this.taskDesc, this.taskTaken, this.taskCreated);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Container(
              width: MediaQuery.of(context).size.width / 1.5,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskLabel,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    taskDesc,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Task created by: ' + taskCreated,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Task taken: ' + taskTaken,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  changeTaskStatus(taskLabel, STATUS.review);
                },
                child: Text('TO REVIEW'),
              ),
              TextButton(
                onPressed: () {
                  refundTask(taskLabel);
                },
                child: Text('REFUND'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
