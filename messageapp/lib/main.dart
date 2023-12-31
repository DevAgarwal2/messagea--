import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messageapp/Authentication/auth.dart';
import 'package:messageapp/firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      
      
      home:  FormRegister(),
      debugShowCheckedModeBanner: false,
    );
  }
}

