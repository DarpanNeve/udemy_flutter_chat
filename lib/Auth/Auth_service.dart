import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:udemy_flutter_chat/screen/chat.dart';

import '../screen/auth.dart';

class AuthService {
  handlingAuthState() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (snapshot.hasData) {
          return const ChatScreen();
        }
        return const AuthScreen();
      },
    );
  }
}
