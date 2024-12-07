import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _attemptLogin(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception("Issue with Login: ${e.toString()}");
    }
  }

  Future<void> _attemptRegister(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception("Issue with Account registration: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        body: SafeArea(
            minimum: EdgeInsets.all(30.0),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 80.0,
                ),
                Column(
                  children: <Widget>[
                    Icon(Icons.login),
                    const SizedBox(height: 16.0),
                    const Text('LOGIN'),
                  ],
                ),
                const SizedBox(height: 200.0),
                TextField(
                  decoration: const InputDecoration(
                    filled: true,
                    labelText: 'Username',
                  ),
                  controller: _usernameController,
                ),
                SizedBox(height: 10.0),
                TextField(
                  decoration: const InputDecoration(
                    filled: true,
                    labelText: 'Password',
                  ),
                  controller: _passwordController,
                  obscureText: true,
                ),
                OverflowBar(
                  alignment: MainAxisAlignment.end,
                  // TODO: Add a beveled rectangular border to CANCEL (103)
                  children: <Widget>[
                    // TODO: Add buttons (101)
                    ElevatedButton(
                      child: const Text('REGISTER'),
                      onPressed: () async {
                        try {
                          await _attemptRegister(_usernameController.text,
                              _passwordController.text);
                        } on Exception catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())));
                        }
                      },
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    // TODO: Add an elevation to NEXT (103)
                    // TODO: Add a beveled rectangular border to NEXT (103)
                    ElevatedButton(
                      child: const Text('LOGIN'),
                      onPressed: () async {
                        try {
                          await _attemptLogin(_usernameController.text,
                              _passwordController.text);
                        } on Exception catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())));
                        }
                      },
                    ),
                  ],
                ),
              ],
            )));
  }
}
