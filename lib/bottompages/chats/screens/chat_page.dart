import '../widgets/widgets.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final doctorid;
  final userid;
  final name;
  ChatPage(
      {Key? key,
      required this.doctorid,
      required this.userid,
      required this.name})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AllChats(
                doctorid: widget.doctorid,
                name: widget.name,
                userid: widget.userid,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
