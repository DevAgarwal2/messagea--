import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:messageapp/Authentication/logorsign.dart";
import "package:messageapp/Home/home_page.dart";

class FormRegister extends StatelessWidget {
  const FormRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return const HomePage();
            }
            else{
              return const AuthMethod();
            }
          }),
    );
  }
}
