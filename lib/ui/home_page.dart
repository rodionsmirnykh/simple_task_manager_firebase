import 'package:flutter/material.dart';
import 'package:simple_task_manager_firebase/ui/done_view/done_tab_view.dart';
import 'package:simple_task_manager_firebase/ui/inwork_view/inwork_tab_view.dart';
import 'package:simple_task_manager_firebase/ui/review_view/review_tab_view.dart';
import 'package:simple_task_manager_firebase/ui/todo_view/todo_tab_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static List<Widget> _tabs = [
    Tab(text: 'TODO'),
    Tab(text: 'IN WORK'),
    Tab(text: 'REVIEW'),
    Tab(text: 'DONE'),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              flexibleSpace: SafeArea(
                child: TabBar(tabs: _tabs),
              ),
            ),
            body: TabBarView(
              children: [
                TodoTabView(),
                InWorkTabView(),
                ReviewTabView(),
                DoneTabView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
