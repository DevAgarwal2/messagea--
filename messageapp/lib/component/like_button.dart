import "package:flutter/material.dart";
class LikeButton extends StatelessWidget {
  final bool islike;
  final Function()? ontap;
  const LikeButton({super.key,required this.islike,required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Icon(
        islike?Icons.favorite:Icons.favorite_border,
        color: islike?Colors.red:Colors.grey,
      ),
      
    );
  }
}