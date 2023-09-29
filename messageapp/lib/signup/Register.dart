import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:messageapp/component/button_comp.dart";
import "package:messageapp/component/text_field.dart";

class Register extends StatefulWidget {
  final Function()? ontap;
  const Register({super.key, required this.ontap});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final user = TextEditingController();
  final password = TextEditingController();
  final again = TextEditingController();
  void register() async {
    showDialog(context: context, builder: (context){
      return const CircularProgressIndicator();
    });

    if(password.text != again.text){
      Navigator.pop(context);
      alertbox("Password doesnt match");
      return;

    }
    try{
       UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.text, password: password.text);
        FirebaseFirestore.instance.collection("Posts").doc(userCredential.user!.email).set({
        "username":user.text.split("@")[0],
        "bio":"Empty Bio..."
        });
        if(context.mounted){
          Navigator.pop(context);
        }
    }
    on FirebaseAuthException catch(e){
      alertbox(e.code);
      Navigator.pop(context);
    }
  }
  void alertbox(String error){
    showDialog(context: context, builder: (context){
      return AlertDialog(title: Text(error),);

    });
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
                  padding: EdgeInsets.only(top: 100),
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
                  child: Text_Field(
                      user: "Enter the email", obstrue: false, type: user),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text_Field(
                      user: "Enter the Password",
                      obstrue: true,
                      type: password),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text_Field(
                      user: "Confirm Password", obstrue: true, type: again),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ButtonComp(ontap: register, name: "Submit"),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already  Registered"),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          onTap: widget.ontap,
                          child: const Text(
                            "Login now",
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
