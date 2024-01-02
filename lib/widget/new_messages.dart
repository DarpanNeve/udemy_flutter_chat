import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({super.key});

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  final _messageController = TextEditingController();

  void _sendMessage() async {
    final enteredMessage = _messageController.text;
    if (enteredMessage.trim().isEmpty) {
      return;
    }
    if (mounted) {
      FocusScope.of(context).unfocus();
    }
    _messageController.clear();
    final user = FirebaseAuth.instance.currentUser!;
    final userData =
        await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    await FirebaseFirestore.instance.collection('chat').add({
      'text': enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData.data()!['username'],
      'userImage': userData.data()!['image_url'],
    });

  }

  @override
  void dispose() {
    _messageController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              autocorrect: true,
              enableSuggestions: true,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(labelText: 'Send a message...'),
            ),
          ),
          IconButton(
              onPressed: _sendMessage,
              icon: const Icon(Icons.send),
              color: Theme.of(context).colorScheme.primary),
        ],
      ),
    );
  }
}
