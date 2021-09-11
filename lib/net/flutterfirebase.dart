import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:simple_task_manager_firebase/model/task.dart';

enum STATUS { todo, inWork, review, done }

Future<bool> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> register(String email, String password) async {
  try {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    addNewUser();
    return true;
  } on FirebaseException catch (e) {
    print(e.code);
  } catch (e) {
    print(e.toString());
  }
  return false;
}

Future<bool> addNewUser() async {
  try {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    String userEmail = FirebaseAuth.instance.currentUser!.email ?? '';

    final dbReference =
        FirebaseFirestore.instance.collection('users').doc(userId);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(dbReference);
      if (!snapshot.exists) {
        dbReference
            .set({'registered': DateTime.now().toString(), 'email': userEmail});
        return true;
      }
      transaction.update(dbReference,
          {'registered': DateTime.now().toString(), 'email': userEmail});
      return true;
    });
  } catch (e) {
    print(e.toString());
  }
  return false;
}

Future<bool> addNewTask(String taskName, String taskDesc) async {
  try {
    final dbReference = FirebaseFirestore.instance
        .collection('tasks')
        .doc(taskName.hashCode.toString());

    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(dbReference);
      if (!snapshot.exists) {
        dbReference.set({
          'name': taskName,
          'description': taskDesc,
          'worker': null,
          'createdBy': FirebaseAuth.instance.currentUser?.uid.toString(),
          'status': STATUS.todo.toString()
        });
        return true;
      }
      transaction.update(dbReference, {
        'name': taskName,
        'description': taskDesc,
        'isEnded': false,
        'worker': null,
        'createdBy': FirebaseAuth.instance.currentUser?.uid.toString(),
        'status': STATUS.todo.toString()
      });
      return true;
    });
  } catch (e) {
    print(e.toString());
  }
  return false;
}

Future<List<Task>> returnAllTasks() async {
  List<Task> taskList = [];
  try {
    FirebaseFirestore.instance
        .collection('tasks')
        .get()
        .then((value) => (value.docs.forEach((element) {
              taskList.add(Task(
                  element.data()['name'].toString(),
                  element.data()['description'].toString(),
                  element.data()['isEnded'] as bool));
            })));
  } catch (e) {
    print(e.toString());
  }
  return taskList;
}

Future<bool> removeTask(String taskName) async {
  try {
    final dbReference = FirebaseFirestore.instance
        .collection('tasks')
        .doc(taskName.hashCode.toString());

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.delete(dbReference);
    });
    return true;
  } catch (e) {
    print(e.toString());
  }
  return false;
}

Future<bool> takeTask(String taskName) async {
  try {
    final dbReference = FirebaseFirestore.instance
        .collection('tasks')
        .doc(taskName.hashCode.toString());
    dbReference.set({
      'worker': FirebaseAuth.instance.currentUser?.uid,
      'status': STATUS.inWork.toString()
    }, SetOptions(merge: true));

    return true;
  } catch (e) {
    print(e.toString());
  }
  return false;
}

Future<bool> refundTask(String taskName) async {
  try {
    final dbReference = FirebaseFirestore.instance
        .collection('tasks')
        .doc(taskName.hashCode.toString());
    dbReference.set({
      'status': STATUS.todo.toString(),
      'worker': null,
    }, SetOptions(merge: true));

    return true;
  } catch (e) {
    print(e.toString());
  }
  return false;
}

Future<bool> reviewTask(String taskName, String review) async {
  try {
    final dbReference = FirebaseFirestore.instance
        .collection('tasks')
        .doc(taskName.hashCode.toString());
    dbReference.set({'review': review}, SetOptions(merge: true));
    return true;
  } catch (e) {
    print(e.toString());
  }
  return false;
}

Future<bool> changeTaskStatus(String taskName, STATUS status) async {
  try {
    final dbReference = FirebaseFirestore.instance
        .collection('tasks')
        .doc(taskName.hashCode.toString());
    dbReference.set({'status': status.toString()}, SetOptions(merge: true));

    return true;
  } catch (e) {
    print(e.toString());
  }
  return false;
}
