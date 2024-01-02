import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter_chat/widget/show_snack_bar.dart';
import 'package:udemy_flutter_chat/widget/user_image_picker.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  var _email = '';
  var _password = '';
  bool _isLogin = true;
  File? _userImageFile;
  bool _isAuthenticating = false;
  var _username = '';

  void _submit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    if (_userImageFile == null && !_isLogin) {
      errorSnackBar(context, 'Please pick an image.');
      return;
    }
    _formKey.currentState!.save();
    try {
      setState(() {
        _isAuthenticating = true;
      });
      if (_isLogin) {
        await _firebase.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        );
      } else {
        await _firebase.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child('${_firebase.currentUser!.uid}.jpg');
        await storageRef.putFile(_userImageFile!);
        final url = await storageRef.getDownloadURL();
        FirebaseFirestore.instance
            .collection('users')
            .doc(_firebase.currentUser!.uid)
            .set({
          'username': _username,
          'email': _email,
          'image_url': url,
        });
      }
    } on FirebaseAuthException catch (error) {
      var message = 'An error occurred, please check your credentials!';
      if (error.message != null) {
        message = error.message!;
      }
      if (mounted) errorSnackBar(context, message);
      setState(() {
        _isAuthenticating = false;
      });
    } catch (error) {
      if (mounted) errorSnackBar(context, error.toString());
      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  void ondispose() {
    _email = '';
    _password = '';
    _username = '';
    _userImageFile = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        appBar: AppBar(
          title: const Text('Flutter Chat'),
        ),
        body: SingleChildScrollView(
          child: Center(
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
                Form(
                  key: _formKey,
                  child: Card(
                    margin: const EdgeInsets.all(15),
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          if (!_isLogin)
                            UserImagePicker(
                              imagePickFn: (pickedImageFile) {
                                _userImageFile = pickedImageFile;
                              },
                            ),
                          if (!_isLogin)
                            TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'UserName'),
                              textCapitalization: TextCapitalization.none,
                              enableSuggestions: false,
                              validator: (value) {
                                if (value!.isEmpty || value.trim().length < 4) {
                                  return 'Please enter at least 4 characters';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _username = value!;
                              },
                            ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            decoration:
                                const InputDecoration(labelText: 'Email'),
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value!.isEmpty || !value.contains('@')) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _email = value!;
                            },
                          ),
                          TextFormField(
                            obscureText: true,
                            decoration:
                                const InputDecoration(labelText: 'Password'),
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 7) {
                                return 'Password must be at least 7 characters long.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _password = value!;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (_isAuthenticating) const CircularProgressIndicator(),
                if (!_isAuthenticating)
                  ElevatedButton(
                    onPressed: _submit,
                    child: Text(_isLogin ? 'Login' : 'Signup'),
                  ),
                if (!_isAuthenticating)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(_isLogin
                        ? 'Create new account'
                        : 'I already have an account'),
                  ),
              ],
            ),
          ),
        ));
  }
}

