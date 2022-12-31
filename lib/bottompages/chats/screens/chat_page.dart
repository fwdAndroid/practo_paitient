import 'package:practo_paitient/bottompages/chats/widgets/all_doctor_chat.dart';

import '../widgets/widgets.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  ChatPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Image.asset(
              "asset/splash.png",
              height: 300,
            ),
            SizedBox(
              height: 15,
            ),
            // ignore: prefer_const_constructors
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => AllHospitalChat()));
                  },
                  // ignore: prefer_const_constructors
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("asset/hospital-building.png"),
                  ),
                  title: Text("Chat With Hospitals"),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),

            // ignore: prefer_const_constructors
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => AllDoctorChat()));
                  },
                  // ignore: prefer_const_constructors
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("asset/teeth.png"),
                  ),
                  title: Text("Chat With Doctors"),
                ),
              ),
            ),
            // AllChats(
            //   doctorid: widget.doctorid,
            //   name: widget.name,
            //   userid: widget.userid,
            // ),
          ],
        ),
      ),
    );
  }
}
