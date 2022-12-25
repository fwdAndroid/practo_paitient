import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:practo_paitient/bottompages/chats/screens/chat_page.dart';

class SeparateChatPage extends StatefulWidget {
  const SeparateChatPage({super.key});

  @override
  State<SeparateChatPage> createState() => _SeparateChatPageState();
}

class _SeparateChatPageState extends State<SeparateChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => ChatPage(
                          doctorid: "dctorid,",
                          userid: "userid",
                          name: "name")));
            },
            title: Text("Chat With Hospitals"),
            leading: CircleAvatar(
              backgroundImage: AssetImage("asset/hospital-building.png"),
            ),
          ),
          ListTile(
            title: Text("Chat With Doctors"),
            leading: CircleAvatar(
              backgroundImage: AssetImage("asset/hospital-building.png"),
            ),
          )
        ],
      ),
    );
  }
}
