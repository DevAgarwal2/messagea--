import "package:flutter/material.dart";

class ProfileComp extends StatelessWidget {
  final String type;
  final String name;
  final Function()? ontap;

  const ProfileComp({super.key,required this.type,required this.name,required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15)

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(type),
              IconButton(onPressed: ontap, icon: Icon(Icons.settings))
            ],
          ),
          Text(name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
        ],
      ),

    );
  }
}