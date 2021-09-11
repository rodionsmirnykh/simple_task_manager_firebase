import 'package:flutter/material.dart';
import 'package:simple_task_manager_firebase/net/flutterfirebase.dart';
import 'todo_task_view.dart';
import '../add_task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('tasks')
              .where('status', isEqualTo: STATUS.todo.toString())
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            return ListView(
              children: snapshot.data!.docs
                  .map((e) => TodoTaskView(e['name'], e['description']))
                  .toList(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTask()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
