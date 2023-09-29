import "package:flutter/material.dart";

class ButtonComp extends StatelessWidget {
  final Function()? ontap;
  final String name;
  const ButtonComp({super.key,required this.ontap,required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.brown.shade900
        ),
        child: Center(child: Text(name,style: const TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),)),
        
      ),
    );
  }
}