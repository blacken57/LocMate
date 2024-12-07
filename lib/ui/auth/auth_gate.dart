import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:flutter/material.dart';
import 'package:loc_mate/ui/auth/login_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LoginScreen();
          }
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            body: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("User is Logged in: "),
                    SizedBox(height: 60.0),
                    Text(FirebaseAuth.instance.currentUser!.email.toString()),
                    ElevatedButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                        },
                        child: Icon(Icons.logout_rounded))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
