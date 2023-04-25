import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var db = FirebaseFirestore.instance;

  void fb() {
    // Create a new user with a first and last name
    final user = <String, dynamic>{
      "first": "Ada",
      "last": "Lovelace",
      "born": 1815
    };

// Add a new document with a generated ID
    db.collection("users").add(user).then((DocumentReference doc) =>
        // ignore: avoid_print
        print('DocumentSnapshot added with ID: ${doc.id}'));
    db.collection("users").get().then((value) {
      for (var doc in value.docs) {
        print('${doc.id} - ${doc.data()}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: fb, child: const Icon(Icons.play_arrow_outlined)),
      ),
    );
  }
}
