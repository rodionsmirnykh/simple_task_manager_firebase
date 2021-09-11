import 'package:flutter/material.dart';
import 'package:simple_task_manager_firebase/net/flutterfirebase.dart';
import 'review_task_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('tasks')
              .where('status', isEqualTo: STATUS.review.toString())
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            return ListView(
              children: snapshot.data!.docs
                  .map((e) => ReviewTaskView(
                      e['name'], e['description'], e['worker'], e['createdBy']))
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
