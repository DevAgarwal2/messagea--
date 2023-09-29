import "package:flutter/material.dart";
class Text_Field extends StatelessWidget {
  final TextEditingController type;
  final String user;
  
  final bool obstrue;
  const Text_Field({super.key,required this.user,required this.obstrue,required this.type});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)
      ),
      child: TextField(
        controller: type,
        
        obscureText: obstrue,
        decoration: InputDecoration(
          hintText: user,
          border: InputBorder.none
        )
    
      ),
    );
  }
}