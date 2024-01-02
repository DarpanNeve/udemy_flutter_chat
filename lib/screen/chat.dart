import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../widget/chat_messages.dart';
import '../widget/new_messages.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void _setUpFirebaseMessaging()async {
    await FirebaseMessaging.instance.getToken().then((value) {
      print(value);
      return;
    });
    FirebaseMessaging.onMessage.listen((message) {
      print(message);
      return;
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(message);
      return;
    });
  }
  @override
  void initState() {
    super.initState();
    _setUpFirebaseMessaging();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Chat'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body:const SafeArea(
        child: Column(
          children: [
            Expanded(child: ChatMessages()),
            NewMessages(),
          ],
        ),
      )
    );
  }
}
