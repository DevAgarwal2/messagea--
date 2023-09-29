import "package:flutter/material.dart";

class Comment_Component extends StatelessWidget {
  final String name;
  final String comment;
  final String timestamp;
  const Comment_Component(
      {super.key,
      required this.name,
      required this.comment,
      required this.timestamp});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name),

              Text(timestamp)
            ],
          ),
          SizedBox(height: 10,),
          Text(comment)
        ],
      ),
    );
  }
}
