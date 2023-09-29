import "package:flutter/material.dart";
import "package:messageapp/login/login_page.dart";
import "package:messageapp/signup/Register.dart";

class AuthMethod extends StatefulWidget {
  const AuthMethod({super.key});

  @override
  State<AuthMethod> createState() => _AuthMethodState();
}

class _AuthMethodState extends State<AuthMethod> {
  //It is used to show login page if the condition is met
  bool showloginPage = true;
  void toggle(){
    setState(() {
      showloginPage = !showloginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showloginPage){
      return Login(ontap: toggle);
    }
    else{
      return Register(ontap: toggle);
    }
  }
}