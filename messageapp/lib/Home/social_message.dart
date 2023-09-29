
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messageapp/component/comment_comp.dart';
import 'package:messageapp/component/time.dart';
import '../component/like_button.dart';

class PostMessage extends StatefulWidget {
  final String user;
  final String mess;
  final String postid;
  final List<String> likes;

  const PostMessage(
      {Key? key,
      required this.user,
      required this.mess,
      required this.postid,
      required this.likes})
      : super(key: key);

  @override
  State<PostMessage> createState() => _PostMessageState();
}

class _PostMessageState extends State<PostMessage> {
  final current_user = FirebaseAuth.instance.currentUser!;
  bool like = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    like = widget.likes.contains(current_user.email);
  }

  void toggle() {
    setState(() {
      like = !like;
    });
    DocumentReference docref =
        FirebaseFirestore.instance.collection("Posts").doc(widget.postid);
    if (like) {
      docref.update({
        "Likes": FieldValue.arrayUnion([current_user.email])
      });
    } else {
      docref.update({
        "Likes": FieldValue.arrayRemove([current_user.email])
      });
    }
  }

  void addComment(String comment) {
    FirebaseFirestore.instance
        .collection("Posts")
        .doc(widget.postid)
        .collection("Comment")
        .add({
      "CommentName": current_user.email,
      "Comment": comment,
      "Timestamp": Timestamp.now()
    });
  }

  final comment_controller = TextEditingController();
  void showComment() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter the comment: "),
            content: TextField(
              controller: comment_controller,
              decoration: InputDecoration(
                  hintText: "Comment", border: InputBorder.none),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  addComment(comment_controller.text);
                  Navigator.pop(context);
                  comment_controller.clear();
                },
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  comment_controller.clear();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.user),
              Text(widget.mess),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  LikeButton(islike: like, ontap: toggle),
                  SizedBox(
                    height: 10,
                  ),
                  Text(widget.likes.length.toString())
                ],
              ),
              Column(
                children: [
                  IconButton(
                      onPressed: () => showComment(),
                      icon: Icon(Icons.message)),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text("0"),
                  )
                ],
              )
            ],
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Posts")
                  .doc(widget.postid)
                  .collection("Comment")
                  .orderBy("Timestamp", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: snapshot.data!.docs.map((docs) {
                      final commentData = docs.data() as Map<String, dynamic>;
                      return Comment_Component(
                          name: commentData["CommentName"],
                          comment: commentData["Comment"],
                          timestamp: formatData(commentData["Timestamp"]));
                    }).toList(),
                  );
                }
              })
        ],
      ),
    );
  }
}
