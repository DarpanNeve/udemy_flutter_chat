import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, streamSnapshot) {
        if (streamSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!streamSnapshot.hasData || streamSnapshot.data!.docs == null) {
          return const Center(child: Text('No data found!'));
        }
        if (streamSnapshot.hasError) {
          return const Center(child: Text('An error occurred!'));
        }
        final documents = streamSnapshot.data!.docs;
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          reverse: true,
          itemCount: documents.length,
          itemBuilder: (ctx, index) {
            final chatMessage = documents[index].data();
            final nextChatMessage = index < documents.length - 1
                ? documents[index + 1].data()
                : null;
            final currentMessageUserId = chatMessage['userId'];
            final nextMessageUserId =
                nextChatMessage != null ? nextChatMessage['userId'] : null;
            final nextUserIsSame = currentMessageUserId == nextMessageUserId;
            if (nextUserIsSame) {
              return MessageBubble.next(
                message: chatMessage['text'],
                isMe: currentMessageUserId ==
                    FirebaseAuth.instance.currentUser!.uid,
              );
            }
            return MessageBubble.first(
              userImage: chatMessage['userImage'],
              username: chatMessage['username'],
              message: chatMessage['text'],
              isMe: currentMessageUserId ==
                  FirebaseAuth.instance.currentUser!.uid,
            );
          },
        );
      },
    );
  }
}
