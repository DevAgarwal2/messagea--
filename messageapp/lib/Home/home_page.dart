import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:messageapp/Home/social_message.dart";
import "package:messageapp/component/drawer.dart";
import "package:messageapp/component/like_button.dart";
import "package:messageapp/component/text_field.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void signout() async {
    await FirebaseAuth.instance.signOut();
  }

  final currentUser = FirebaseAuth.instance.currentUser!;
  final message = TextEditingController();
  void sendmessage() {
    if (message.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("Posts").add({
        "user": currentUser.email,
        "message": message.text,
        "Timestamp": Timestamp.now(),
        "Likes": []
      });
      message.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: Column(
          children: [
            Text("Welcome to the Home Page")
          ],
        ),
        actions: [
          IconButton(onPressed: signout, icon: Icon(Icons.logout))
        ],
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Posts")
                    .orderBy("Timestamp", descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final post = snapshot.data!.docs[index];
                          return PostMessage(
                            user: post["user"],
                            mess: post["message"],
                            postid: post.id,
                            //if there is like then show or if there is no display empty list
                            likes: List<String>.from(post["Likes"]??[]),
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("There is an erro${snapshot.error}"),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
          Row(
            children: [
              Column(
                children: [],
              ),
              Expanded(
                child: Text_Field(
                    user: "Enter the message", obstrue: false, type: message),
              ),
              IconButton(onPressed: sendmessage, icon: const Icon(Icons.send))
            ],
          ),
        ],
      ),
    );
  }
}
