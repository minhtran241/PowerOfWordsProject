import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class WriteUser extends StatefulWidget{
  @override
  _WriteUserState createState() => _WriteUserState();
}

class _WriteUserState extends State<WriteUser>{
  final database = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context){
    final userData = database.child('user');
    return Scaffold(
      appBar: AppBar(
        title: Text('Testing WRITE FILE'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  print('Welcome!');
                }, child: Text('HELLO'),
              ),
            ],
          ),
        ),
      )
    );
  }

}