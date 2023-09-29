import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:messageapp/Home/profile_page.dart";

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  void signout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade900,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 70,
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 30,
                ),
                onTap: () => Navigator.pop(context),
                title: Text(
                  "H O M E",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage())),
                leading: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 30,
                ),
                title: Text(
                  "P R O F I L E",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: ListTile(
                  onTap: signout,
                  leading: Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 30,
                  ),
                  title: Text(
                    "L O G O U T",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
