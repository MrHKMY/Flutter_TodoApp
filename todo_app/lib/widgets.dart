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
