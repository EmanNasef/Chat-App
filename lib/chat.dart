import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'constant.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat';
  final User users;
  ChatScreen({this.users});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _fire = FirebaseFirestore.instance;

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  Future<void> callback() async {
    if (messageController.text.length > 0) {
      await _fire.collection('Messages').add({
        'text': messageController.text,
        'from': widget.users.email,
        'date': DateTime.now().toIso8601String().toUpperCase(),
      });
    }
    messageController.clear();
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Chat App',
          style: textStyle.copyWith(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              _auth.signOut();
              Navigator.of(
                context,
              ).popUntil((route) => route.isFirst);
            },
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream:
                      _fire.collection('Messages').orderBy('date').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.green,
                        ),
                      );

                    List<DocumentSnapshot> member = snapshot.data.docs;

                    List<OurMessages> newMember = member
                        .map((e) => OurMessages(
                              from: e.data()['from'],
                              text: e.data()['text'],
                              me: widget.users.email == e.data()['from'],
                            ))
                        .toList();

                    return ListView(
                        controller: scrollController,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20.0),
                        children: newMember);
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.green, width: 1.5),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        onChanged: (value) => callback,
                        decoration: InputDecoration(
                          hintText: 'Type Your Messages',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SendButton(onPress: callback),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SendButton extends StatelessWidget {
  final Function onPress;

  SendButton({this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: IconButton(
      icon: Icon(Icons.send, color: Colors.green, size: 35.0),
      onPressed: onPress,
    ));
  }
}

class OurMessages extends StatelessWidget {
  final String from;
  final String text;
  final bool me;

  OurMessages({this.from, this.text, this.me});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            from,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54, fontFamily: 'Pacifico'),
          ),
          Material(
            color: me ? Colors.green : Color(0xffF8F9FA),
            borderRadius: me
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(25.0),
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0))
                : BorderRadius.only(
                    bottomRight: Radius.circular(25.0),
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0)),
            elevation: 5.0,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15.0,
                  color: me ? Colors.white : Colors.black87,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
