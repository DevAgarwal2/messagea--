import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:messageapp/component/button_comp.dart";
import "package:messageapp/component/text_field.dart";

class Login extends StatefulWidget {
  final Function()? ontap;
  const Login({super.key, required this.ontap});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final user = TextEditingController();
  final password = TextEditingController();
  void login() async {
    showDialog(context: context, builder: (context){
      return const CircularProgressIndicator();
    });
    try{
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: user.text, password: password.text);
        if(context.mounted){
          Navigator.pop(context);
        }
    }
    on FirebaseAuthException catch(e){
      print(e.code);
      Navigator.pop(context);
      alertbox(e.code);
    }
    
    
    
  }
  void alertbox(String message){
    showDialog(context: context, builder:(context) {
      return AlertDialog(title: Text(message),);
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 130),
                  child: Icon(
                    Icons.person,
                    size: 100,
                  ),
                ),
                const Text("Ar Social Media App"),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text_Field(user: "Enter the user", obstrue: false, type: user),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text_Field(user: "Enter the Password", obstrue: true, type: password),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ButtonComp(ontap: login, name: "Submit"),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Not Registered"),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          onTap: widget.ontap,
                          child: const Text(
                            "SignUp now",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          )),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
