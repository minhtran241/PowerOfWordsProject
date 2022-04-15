import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:power_of_words/auth/authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:sentiment_dart/sentiment_dart.dart';
import '../model/database.dart';
import '../extension/string_extension.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    String name;
    String uid;
    final FirebaseAuth _ath = FirebaseAuth.instance;
    final User? user = _ath.currentUser;
    uid = user!.uid;
    print(uid);
    TextEditingController messageController = new TextEditingController();
    double windowHeight = MediaQuery.of(context).size.height;
    double windowWidth = MediaQuery.of(context).size.width;
    //authentication serrivce proivde logout
    final authService = Provider.of<AuthenticationService>(context);
    // documentReference for user information
    DocumentReference doc_ref =
        FirebaseFirestore.instance.collection("UserID").doc(uid);
    //stream for old input journey
    final Stream<QuerySnapshot> mess = FirebaseFirestore.instance
        .collection("Message")
        .doc(uid)
        .collection('message')
        .snapshots();
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          Container(
            child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection("UserID")
                  .doc(uid)
                  .snapshots(),
              builder: (_, snapshot) {
                if (snapshot.hasError) return Text('Error = ${snapshot.error}');
                if (snapshot.hasData) {
                  var output = snapshot.data!.data();
                  String first = output!['firstName'];
                  String last = output['lastName'];
                  String capfirst = first.capitalize();
                  String caplast = last.capitalize();
                  return Text("Welcome $capfirst $caplast");
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          TextField(
              controller: messageController,
              decoration:
                 //text for user's input 
                  InputDecoration(hintText: "What do you have in mind?")),
          ElevatedButton(
              onPressed: (() async {
                //puts recorded input into the database with date and time inputted
                DatabaseService(uid: uid)
                    .updateMessage(messageController.text, DateTime.now());
              }),
              child: Text("Submit")),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: mess,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("something wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  final data = snapshot.requireData;

                  //displays the inputted message with the date and time
                  print(data.docs[0]['date']);
                  print(data.docs[0]['message']);
                  print(data.docs[0]['sentimental analysis']);
                  
                  return ListView.builder(
                      itemCount: data.size,
                      itemBuilder: (contex, index) {
                        String userinput = data.docs[index]['message'];
                        DateTime dateinput = data.docs[index]['date'].toDate();
                        String dateToString = dateinput.toString();
                        double sentianalysis = getSentimentalAnalysis(userinput);
                        return Text("$dateToString \n $userinput \n $sentianalysis");
                      });
                }),
          ),
          Center(
            child: ElevatedButton(
              child: Text('Logout'),
              onPressed: () async {
                await authService.signOut();
              },
            ),
          ),
        ]),
      ),
    ));
  }
    double getSentimentalAnalysis(String message){
        double tot = 0;
        message.replaceAll(new RegExp(r'[^\w\s]+'),'');
        message.toLowerCase();

        tot = Sentiment.analysis(message).score;
        return tot;  
    }
}
