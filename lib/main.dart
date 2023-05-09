import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_firebase/new_item_page.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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
  late ListView list = ListView.separated(
      itemBuilder: (context, index) => null,
      separatorBuilder: (context, index) => const Divider(),
      itemCount: 10);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(list: list),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
    required this.list,
  });

  final ListView list;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var db = FirebaseFirestore.instance;
  late ListView list = ListView.separated(
      itemBuilder: (context, index) => null,
      separatorBuilder: (context, index) => const Divider(),
      itemCount: 10);
  void register() async {
    final Map<String, String> itemdata = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewItemPage(),
        ));
    fb(itemdata);
  }

  void getToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);
  }

  void fb(Map<String, String> itemdata) {
    // Create a new user with a first and last name

// Add a new document with a generated ID
    db.collection("users").add(itemdata).then((DocumentReference doc) =>
        // ignore: avoid_print
        print('DocumentSnapshot added with ID: ${doc.id}'));
    showList();
  }

  void showList() {
    db.collection('users').where("name", isEqualTo: "홍길동").get().then((value) {
      setState(() {
        list = ListView.separated(
            itemBuilder: (context, index) {
              Map<dynamic, dynamic> doc = value.docs[index].data();
              return ListTile(
                isThreeLine: true,
                title: Text('${doc['title']}'),
                subtitle: Text('${doc['location']} \n ${doc['name']}'),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: value.docs.length);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // showList();
    print('----------');
    getToken();
    print('----------');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Malbob Market with Firebase'),
      ),
      body: Center(child: list),
      floatingActionButton: FloatingActionButton(
          onPressed: register, child: const Icon(Icons.play_arrow_outlined)),
    );
  }
}
