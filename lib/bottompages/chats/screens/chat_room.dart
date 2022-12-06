import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practo_paitient/bottompages/chats/videochat/meeting_screen.dart';

import '../app_theme.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  final paitentname;
  final doctorid;
  final doctorName;
  final userid;
  const ChatRoom(
      {Key? key,
      required this.doctorid,
      required this.userid,
      required this.doctorName,
      required this.paitentname})
      : super(key: key);

  @override
  _ChatRoomState createState() => _ChatRoomState();
  // final User user;
}

class _ChatRoomState extends State<ChatRoom> {
  String chatId = "";
  ScrollController scrollController = ScrollController();
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    if (FirebaseAuth.instance.currentUser!.uid.hashCode <=
        widget.userid.hashCode) {
      chatId = "${widget.userid}-${widget.doctorid}";
    } else {
      chatId = "${widget.userid}-${widget.doctorid}";
    }
    FirebaseFirestore.instance
        .collection("users")
        .doc(widget.userid)
        .get()
        .then((value) {
      // setState(() {
      //   receiverName=value.get("UserName");
      // });
    });
    var a = FirebaseFirestore.instance.collection("collectionPath");
    FirebaseFirestore.instance
        .collection("users")
        .doc(widget.userid)
        .get()
        .then((value) {
      setState(() {
        // myStatus= value.get("status");
        // receiverName=value.get("UserName");
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
        title: Column(
          children: [
            Text(
              widget.doctorName,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.black),
            ),
            Text(
              widget.paitentname,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.black),
            ),
          ],
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => MeetingScreen()));
                },
                icon: Icon(
                  Icons.video_call,
                  color: Colors.blue,
                ),
              )),
        ],
      ),
      backgroundColor: MyTheme.kPrimaryColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("messages")
                      .doc(chatId)
                      .collection(chatId)
                      .orderBy("timestamp", descending: false)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!.docs == 0
                          ? Center(child: Text("No Communication Start"))
                          : SingleChildScrollView(
                              child: ListView.builder(
                                controller: scrollController,
                                itemCount: snapshot.data!.docs.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var ds = snapshot.data!.docs[index];
                                  return ds.get("type") == 0
                                      ? Container(
                                          padding: EdgeInsets.only(
                                              left: 14,
                                              right: 14,
                                              top: 10,
                                              bottom: 10),
                                          child: Align(
                                            alignment: (ds.get("senderId") ==
                                                    FirebaseAuth.instance
                                                        .currentUser!.uid
                                                ? Alignment.bottomRight
                                                : Alignment.bottomLeft),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: (ds.get("senderId") ==
                                                        FirebaseAuth.instance
                                                            .currentUser!.uid
                                                    ? Colors.grey.shade200
                                                    : Colors.blue[200]),
                                              ),
                                              padding: EdgeInsets.all(16),
                                              child: Text(
                                                ds.get("content"),
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            ),
                                          ),
                                        )
                                      : ds.get("type") == 1
                                          ? Container(
                                              padding: EdgeInsets.only(
                                                  left: 14,
                                                  right: 14,
                                                  top: 10,
                                                  bottom: 10),
                                              child: Align(
                                                alignment:
                                                    (ds.get("receiverId") ==
                                                            widget.doctorid
                                                        ? Alignment.bottomRight
                                                        : Alignment.bottomLeft),
                                                child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.2,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                          ds.get("image"),
                                                        ),
                                                        fit: BoxFit.fill),
                                                    // color: (ds.get("senderId") == firebaseAuth.currentUser!.uid?Colors.grey.shade200:Colors.blue[200]),
                                                  ),
                                                  // padding: EdgeInsets.all(16),
                                                ),
                                              ),
                                            )
                                          : Container();
                                },
                              ),
                            );
                    } else if (snapshot.hasError) {
                      return Center(child: Icon(Icons.error_outline));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              color: Colors.white,
              height: 100,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      height: 60,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller,
                              decoration: InputDecoration(
                                suffixIcon: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween, // added line
                                  mainAxisSize: MainAxisSize.min, // added line
                                  children: <Widget>[
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.attach_file)),
                                  ],
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  // width: 0.0 produces a thin "hairline" border
                                  borderSide: const BorderSide(
                                      color: Colors.blue, width: 0.0),
                                ),
                                border: const OutlineInputBorder(),
                                fillColor: Color(0xffF1F1F1),
                                filled: true,
                                hintText: 'Type Something.....',
                                hintStyle: TextStyle(color: Colors.grey[500]),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              sendMessage(controller.text.trim(), 0);
                            },
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 18,
                            ),
                            backgroundColor: Colors.blue,
                            elevation: 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
            // buildChatComposer()
          ],
        ),
      ),
    );
  }

  void sendMessage(String content, int type) {
    if (content.trim() != '') {
      controller.clear();

      var documentReference = FirebaseFirestore.instance
          .collection('messages')
          .doc(chatId)
          .collection(chatId)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      FirebaseFirestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            "senderId": FirebaseAuth.instance.currentUser!.uid,
            "receiverId": widget.userid,
            "time": DateTime.now(),
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'content': content,
            'type': type
          },
        );
      });
      scrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      // Fluttertoast.showToast(msg: 'Nothing to send');
    }
  }
}
