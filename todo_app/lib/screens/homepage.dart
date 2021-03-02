import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
          padding: EdgeInsets.all(24),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 32),
                  ),
                  Image(image: AssetImage(
                    "assets/images/logo.png"
                  )),
                  TaskCardWidget(
                    title: "Get Started!",
                    description: "Edit or delete the description to get started.",
                  ),
                  TaskCardWidget()
                ],
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                  child: Image(
                    image: AssetImage("assets/images/add_icon.png"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
