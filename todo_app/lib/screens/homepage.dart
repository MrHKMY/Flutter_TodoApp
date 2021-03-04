import 'package:flutter/material.dart';
import 'package:todo_app/screens/taskpage.dart';
import 'package:todo_app/widgets.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
                    margin: EdgeInsets.only(top: 32, bottom: 32),
                    child: Image(image: AssetImage("assets/images/logo.png")),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        TaskCardWidget(
                          title: "Get Started!",
                          description:
                          "Edit or delete the description to get started.",
                        ),
                        TaskCardWidget(),
                        TaskCardWidget(),
                        TaskCardWidget(),
                        TaskCardWidget(),
                        TaskCardWidget(),
                        TaskCardWidget()
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 24.0,
                right: 0,
                child : GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) => TaskPage()
                      ),
                    );
                  },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Image(
                    image: AssetImage("assets/images/add_icon.png"),
                  ),
                ),
              )
              )
            ],
          ),
        ),
      ),
    );
  }
}
