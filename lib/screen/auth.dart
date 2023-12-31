import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        appBar: AppBar(
          title: const Text('Flutter Chat'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Image.asset(
                  'assets/images/chat.png',
                  width: 150,
                  height: 150,
                ),
              ),
              const Text('Welcome to Flutter Chat'),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Login'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Register'),
              ),
            ],
          ),
        )
    );
  }
}

