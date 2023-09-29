import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:messageapp/Home/profile_comp.dart";

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  Future<void> editChange(String edit) async {
    String newEdit = "";
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Edit Button"),
              content: TextField(
                decoration: InputDecoration(
                    hintText: "Enter the  $edit", border: InputBorder.none
                    ,),
                    onChanged: (value) {
                      newEdit = value;
                    },
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(newEdit),
                  child: Text(
                    "Yes",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green)),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "No",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red)),
                ),
              ],
            ));
    if (newEdit.trim().length > 0) {
      await FirebaseFirestore.instance
          .collection("Posts")
          .doc(currentUser.email)
          .update({edit: newEdit});
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
              Text("Profile Page"),
            ],
          ),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Posts")
                .doc(currentUser.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final userData = snapshot.data!.data() as Map<String, dynamic>;
                return ListView(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Icon(
                      Icons.person,
                      size: 70,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      currentUser.email!,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40),
                      child: Text(
                        "My Profile",
                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                    ProfileComp(
                      type: "Username",
                      name: userData["username"],
                      ontap: () => editChange("username"),
                    ),
                    ProfileComp(
                        type: "Bio",
                        name: userData["bio"],
                        ontap: () => editChange("bio"))
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
// ListView(
//           children: [
//             SizedBox(
//               height: 50,
//             ),
//             Icon(
//               Icons.person,
//               size: 70,
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Text(
//               currentUser.email!,
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 40),
//               child: Text(
//                 "My Profile",
//                 style: TextStyle(fontSize: 19),
//               ),
//             ),
//             ProfileComp(
//               type: "Username",
//               name: "Dev",
//               ontap: () => editChange("username"),
//             ),
//             ProfileComp(
//                 type: "Bio", name: "Empty Bio", ontap: () => editChange("bio"))
//           ],
//         )