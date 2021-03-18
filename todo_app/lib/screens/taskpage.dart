import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/database_helper.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/model/todo.dart';

import '../database_helper.dart';
import '../database_helper.dart';
import '../model/task.dart';
import '../model/task.dart';
import '../widgets.dart';
import '../widgets.dart';

class TaskPage extends StatefulWidget {
  final Task task;

  TaskPage({@required this.task});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  String _taskFile = "";
  int _taskID = 0;

  FocusNode _titleFocus;
  FocusNode _descriptionFocus;

  bool _contentVisible = false;

  DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void initState() {
    if (widget.task != null) {
      _contentVisible = true;
      _taskFile = widget.task.title;
      _taskID = widget.task.id;

      _titleFocus = FocusNode();
      _descriptionFocus = FocusNode();

    }
    super.initState();
  }

  @override
  void dispose() {
    _titleFocus?.dispose();
    _descriptionFocus?.dispose();
    super.dispose();
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
                            focusNode: _titleFocus,
                        autofocus: true,
                        onSubmitted: (value) async {
                          //Check if field is not empty
                          if (value != null) {
                            //Check if task is null
                            if (widget.task == null) {

                              Task _newTask = Task(title: value);
                              _taskID = await _dbHelper.insertTask(_newTask);
                              setState(() {
                                _contentVisible = true;
                                _taskFile = value;
                              });
                            } else {
                              await _dbHelper.updateTaskTitle(_taskID, value);
                              print("updated");
                            }

                            _descriptionFocus.requestFocus();
                          }
                          //print("No title, no save");
                        },
                        controller: TextEditingController()..text = _taskFile,
                        decoration: InputDecoration(
                            hintText: "Title", border: InputBorder.none),
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF211551),
                        ),
                      ))
                    ],
                  ),
                ),
                Visibility(
                  visible: _contentVisible,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: TextField(
                      focusNode: _descriptionFocus,
                      decoration: InputDecoration(
                          hintText: "Enter description",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 24)),
                    ),
                  ),
                ),
                Visibility(
                  visible: _contentVisible,
                  child: FutureBuilder(
                      initialData: [],
                      future: _dbHelper.retrieveTodo(_taskID),
                      builder: (context, snapshot) {
                        return Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    //Todo : swith todo completion state
                                  },
                                  child: TodoWidget(
                                    text: snapshot.data[index].title,
                                    isDone: snapshot.data[index].isDone == 0 ? false : true,
                                  ),
                                );
                              },),
                        );
                      }),
                ),
                Visibility(
                  visible: _contentVisible,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          margin: EdgeInsets.only(right: 16),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: Color(0xFF86829D),
                                width: 1.5,
                              )),
                          child: Image(
                              image:
                                  AssetImage("assets/images/check_icon.png")),
                        ),
                        Expanded(
                            child: TextField(
                          onSubmitted: (value) async {
                            //check if field is null
                            if (value != null) {
                              //check if the todoo is null
                              if (widget.task != null) {
                                DatabaseHelper _dbHelper = DatabaseHelper();
                                Todo _newTodo = Todo(
                                  title: value,
                                  isDone: 0,
                                  taskID: widget.task.id,
                                );
                                await _dbHelper.insertTodo(_newTodo);
                                setState(() {
                                });
                              }
                            }
                          },
                          decoration: InputDecoration(
                              hintText: "Enter item",
                              border: InputBorder.none),
                        ))
                      ],
                    ),
                  ),
                )
              ],
            ),
            Visibility(
              visible: _contentVisible,
              child: Positioned(
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
                  )),
            )
          ],
        )),
      ),
    );
  }
}
