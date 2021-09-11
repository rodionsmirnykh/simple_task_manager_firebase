import 'package:flutter/material.dart';
import 'package:simple_task_manager_firebase/net/flutterfirebase.dart';

class TodoTaskView extends StatelessWidget {
  final String taskLabel;
  final String taskDesc;

  TodoTaskView(this.taskLabel, this.taskDesc);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
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
              ],
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  takeTask(taskLabel);
                },
                child: Text('TAKE'),
              ),
              IconButton(
                  onPressed: () {
                    removeTask(taskLabel);
                  },
                  icon: Icon(Icons.close)),
            ],
          )
        ],
      ),
    );
  }
}
