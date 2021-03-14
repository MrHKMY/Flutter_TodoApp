import 'package:flutter/material.dart';
import 'package:todo_app/database_helper.dart';
import 'package:todo_app/model/task.dart';

import '../model/task.dart';
import '../model/task.dart';
import '../widgets.dart';

class TaskPage extends StatefulWidget {
  final Task task;

  TaskPage({@required this.task});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  String _taskFile = "";

  @override
  void initState() {
    if (widget.task != null) {
      _taskFile = widget.task.title;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 6),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Image(
                            image:
                                AssetImage("assets/images/back_arrow_icon.png"),
                          ),
                        ),
                      ),
                      Expanded(
                          child: TextField(
                        onSubmitted: (value) async {
                          //Check if field is not empty
                          if (value != null) {
                            //Check if task is null
                            if (widget.task == null) {
                              DatabaseHelper _dbHelper = DatabaseHelper();
                              Task _hardcodedTask = Task(title: value);
                              await _dbHelper.insertTask(_hardcodedTask);
                            } else {
                              print("Update the existing task");
                            }
                          }
                        },
                        controller: TextEditingController()..text = _taskFile,
                        decoration: InputDecoration(
                            hintText: "Enter Title", border: InputBorder.none),
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF211551),
                        ),
                      ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Enter description",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 24)),
                  ),
                ),
                TodoWidget(
                  text: "First task",
                  isDone: false,
                ),
                TodoWidget(
                  isDone: true,
                )
              ],
            ),
            Positioned(
                bottom: 24.0,
                right: 24.0,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Image(
                      image: AssetImage("assets/images/delete_icon.png"),
                    ),
                  ),
                ))
          ],
        )),
      ),
    );
  }
}
