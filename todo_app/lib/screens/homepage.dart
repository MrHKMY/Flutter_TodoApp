import 'package:flutter/material.dart';
import 'package:todo_app/database_helper.dart';
import 'package:todo_app/screens/taskpage.dart';
import 'package:todo_app/widgets.dart';

import 'taskpage.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DatabaseHelper _dbHelper = DatabaseHelper();
  bool _contentvisible = false;

  @override
  void initState() {
    // String a = _dbHelper.retrieveTask().toString();
    // if(a == null){
    //   _contentvisible = false;
    // } else {
    //   _contentvisible = true;
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.grey[100],
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    margin: EdgeInsets.only(top: 16, bottom: 32),
                    child: Image(
                        image: AssetImage(
                            "assets/images/tick_icon.png",)),
                  ),
                  Visibility(
                    visible: _contentvisible,
                    child: Container(
                          child: EmptyWidget(),
                        ),
                  ),
                  Expanded(
                      child: FutureBuilder(
                    initialData: [],
                    future: _dbHelper.retrieveTask(),
                    builder: (context, snapshot) {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => TaskPage(
                                    task: snapshot.data[index],
                                  )),
                                ).then((value) {
                                  setState(() {});
                                });
                              },
                              child: TaskCardWidget(
                                title: snapshot.data[index].title,
                                description: snapshot.data[index].description,
                              ),
                            );
                          });
                    },
                  )
                      // TaskCardWidget(
                      //   title: "Get Started!",
                      //   description:
                      //   "Edit or delete the description to get started.",
                      // ),
                      ),
                ],
              ),
              Positioned(
                  bottom: 24.0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TaskPage(task: null,)),
                      ).then((value) => setState(() {}));
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.green[800], Colors.green[600]],
                              begin: Alignment(0.0, -1),
                              end: Alignment(0, 1)),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Image(
                        image: AssetImage("assets/images/add_icon.png"),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
