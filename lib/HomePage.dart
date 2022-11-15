import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'List.dart';
import 'main.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                return ListTasks();
              } else if (snapshot.hasError) {
                return Center(child: Text('Algo deu errado!'));
              } else {
                return MyHomePage(title: "Log in",);
              }
            }),
      );
}
