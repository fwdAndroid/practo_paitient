import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practo_paitient/bottompages/chats/screens/doctor_video_chat.dart';
import 'package:practo_paitient/widgets/firebase_api.dart';
import 'package:practo_paitient/bottompages/chats/screens/hospitak_video_chat.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

class DoctorChatRoom extends StatefulWidget {
  String doctorId;
  String doctorName;
  String paitientname;
  String paitientid;
  DoctorChatRoom({
    Key? key,
    required this.paitientid,
    required this.paitientname,
    required this.doctorId,
    required this.doctorName,
  }) : super(key: key);

  @override
  State<DoctorChatRoom> createState() => _DoctorChatRoomState();
}

class _DoctorChatRoomState extends State<DoctorChatRoom> {
  String groupChatId = "";
  ScrollController scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();
  File? imageUrl;
  PlatformFile? platformFile;
  UploadTask? task;
  File? file;

  TextEditingController messageController = TextEditingController();
  String? imageLink, fileLink;
  firebase_storage.UploadTask? uploadTask;

  @override
  void initState() {
    // TODO: implement initState
    if (FirebaseAuth.instance.currentUser!.uid.hashCode <=
        widget.doctorId.hashCode) {
      groupChatId =
          "${FirebaseAuth.instance.currentUser!.uid}-${widget.doctorId}";
    } else {
      groupChatId =
          "${widget.doctorId}-${FirebaseAuth.instance.currentUser!.uid}";
    }

    super.initState();
  }

  String myStatus = "";
  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
          title: Column(
            children: [
              Text(
                widget.doctorName,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                widget.paitientname,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => DoctorVideoCall(
                                callingId: widget.doctorId,
                                paitientname: widget.paitientname,
                              )));
                },
                icon: Icon(
                  Icons.video_call,
                  color: Colors.blue,
                ))
          ],
        ),
        body: Container(
          child: Stack(
            children: <Widget>[
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("messages")
                      .doc(groupChatId)
                      .collection(groupChatId)
                      .orderBy("timestamp", descending: false)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!.docs == 0
                          ? Center(child: Text("Empty "))
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
                                          ? Stack(
                                              children: [
                                                Column(children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 14,
                                                        right: 14,
                                                        top: 10,
                                                        bottom: 10),
                                                    child: Align(
                                                      alignment: (ds.get(
                                                                  "senderId") ==
                                                              FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid
                                                          ? Alignment
                                                              .bottomRight
                                                          : Alignment
                                                              .bottomLeft),
                                                      child: Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.2,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                ds.get("image"),
                                                              ),
                                                              fit: BoxFit.fill),
                                                          // color: (ds.get("senderId") == FirebaseAuth.instance.currentUser!.uid?Colors.grey.shade200:Colors.blue[200]),
                                                        ),
                                                        // padding: EdgeInsets.all(16),
                                                      ),
                                                    ),
                                                  ),
                                                  task != null
                                                      ? buildUploadStatus(task!)
                                                      : Container(),
                                                ]),
                                                Positioned(
                                                  top: 12,
                                                  right: 17,
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: InkWell(
                                                      onTap: () {
                                                        print("s");
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Colors
                                                                    .grey),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Icon(
                                                            Icons.download,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : ds.get("type") == 2
                                              ? Stack(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: 14,
                                                          right: 14,
                                                          top: 10,
                                                          bottom: 10),
                                                      child: Align(
                                                        alignment: (ds.get(
                                                                    "senderId") ==
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid
                                                            ? Alignment
                                                                .bottomRight
                                                            : Alignment
                                                                .bottomLeft),
                                                        child: Container(
                                                          height: 60,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            color: (ds.get(
                                                                        "senderId") ==
                                                                    FirebaseAuth
                                                                        .instance
                                                                        .currentUser!
                                                                        .uid
                                                                ? Colors.grey
                                                                    .shade200
                                                                : Colors
                                                                    .blue[200]),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              ds
                                                                  .get("file")
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    task != null
                                                        ? buildUploadStatus(
                                                            task!)
                                                        : Container(),
                                                    Positioned(
                                                      top: 12,
                                                      right: 17,
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: InkWell(
                                                          onTap: () {
                                                            print("object");
                                                          },
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Colors
                                                                        .grey),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4.0),
                                                              child: Icon(
                                                                Icons.download,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
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
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  height: 60,
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 100,
                                child: AlertDialog(
                                  title: new Text("Welcome Practo"),
                                  content: Container(
                                    height: 100,
                                    child: Column(
                                      children: [
                                        new TextButton(
                                            onPressed: addImage,
                                            child: Text("Upload Image")),
                                        new TextButton(
                                            onPressed: uploadFile,
                                            child: Text("Upload File")),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    new ElevatedButton(
                                      child: new Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          decoration: InputDecoration(
                              hintText: "Write message...",
                              hintStyle: TextStyle(color: Colors.black54),
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          sendMessage(messageController.text.trim(), 0);
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
        ));
  }
  //Functions

  void sendMessage(String content, int type) {
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') {
      messageController.clear();

      var documentReference = FirebaseFirestore.instance
          .collection('messages')
          .doc(groupChatId)
          .collection(groupChatId)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      FirebaseFirestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            "senderId": FirebaseAuth.instance.currentUser!.uid,
            "receiverId": widget.doctorId,
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

  Future uploadFile() async {
    print("clicked");
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
    if (file == null) return;

    var uuid = Uuid();

    final fileName = basename(file!.path);
    final destination = 'files/$fileName+${uuid.v4()}}';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {
      fileLink = fileName;
    });

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
    var documentReference = FirebaseFirestore.instance
        .collection('messages')
        .doc(groupChatId)
        .collection(groupChatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());
    FirebaseFirestore.instance.runTransaction((transaction) async {
      await transaction.set(
        documentReference,
        {
          "senderId": FirebaseAuth.instance.currentUser!.uid,
          "reciverId": widget.doctorId,
          // "content": messageController.text,
          "time": DateTime.now(),
          'image': "",
          'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
          // 'content': content,
          "file": fileLink,
          'type': 2,
        },
      );
    });
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w500,
              ),
            );
          } else {
            return Container();
          }
        },
      );

  Future uploadImageToFirebase() async {
    File? fileName = imageUrl;
    var uuid = Uuid();
    firebase_storage.Reference firebaseStorageRef = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('messages/images+${uuid.v4()}');
    firebase_storage.UploadTask uploadTask =
        firebaseStorageRef.putFile(fileName!);
    firebase_storage.TaskSnapshot taskSnapshot =
        await uploadTask.whenComplete(() async {
      print(fileName);
      String img = await uploadTask.snapshot.ref.getDownloadURL();
      setState(() {
        imageLink = img;
      });
    });
  }

  void addImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageUrl = File(image!.path);
    });
    await uploadImageToFirebase().then((value) {
      var documentReference = FirebaseFirestore.instance
          .collection('messages')
          .doc(groupChatId)
          .collection(groupChatId)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());
      FirebaseFirestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            "senderId": FirebaseAuth.instance.currentUser!.uid,
            "reciverId": widget.doctorId,
            // "content": messageController.text,
            "time": DateTime.now(),
            'image': imageLink,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            // 'content': content,
            "file": "",
            'type': 1,
          },
        );
      });
    }).then((value) {
      // FocusScope.of(context).unfocus();
      messageController.clear();
    });
  }
}
