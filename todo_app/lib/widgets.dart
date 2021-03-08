import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {

  final String title;
  final String description;
  TaskCardWidget ({this.title, this.description});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "Unnamed Task",
            style: TextStyle(
                color: Color(0xFF211551),
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 10
            ),
            child: Text(
              description ?? 'No description added.',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF86829D),
              height: 1.5
            ),),
          )
        ],
      ),
    );
  }
}

class TodoWidget extends StatelessWidget {

  final String text;
  final bool isDone;

  TodoWidget({this.text, this.isDone});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              margin: EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: isDone ? Color(0xFF7349FE) : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: isDone ? null : Border.all(
                  color: Color(0xFF86829D),
                  width: 1.5,
                )
              ),
              child: Image(
                  image: AssetImage(
                      "assets/images/check_icon.png")),
            ),
            Text(
              text ?? "Unnamed Todo",
            style: TextStyle(
              color: isDone ? Color(0xFF86829D) : Color(0xFF211551),
              fontSize: 16,
              fontWeight: isDone ? FontWeight.w500 : FontWeight.bold,
            ),)
          ],
        ),
      )
    );
  }
}

