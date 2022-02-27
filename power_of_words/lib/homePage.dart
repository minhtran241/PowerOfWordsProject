import 'package:flutter/material.dart';
import 'package:power_of_words/authentication_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthenticationService>(context);
    return Scaffold(
        body: Column(children: [
      Text(''),
      Center(
        child: ElevatedButton(
          child: Text('Logout'),
          onPressed: () async {
            await authService.signOut();
          },
        ),
      ),
    ]));
  }
}
