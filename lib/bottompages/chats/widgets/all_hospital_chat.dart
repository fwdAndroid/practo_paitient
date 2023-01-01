import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../screens/chat_hospital_room.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_theme.dart';

class AllHospitalChat extends StatefulWidget {
  final hospitalid;
  AllHospitalChat({required this.hospitalid});
  @override
  State<AllHospitalChat> createState() => _AllHospitalChatState();
}

class _AllHospitalChatState extends State<AllHospitalChat> {
  @override
  Widget build(BuildContext context) {
    print(widget.hospitalid);
    var uuid = Uuid().v1();
    print("fawad");
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 1,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Mesasages",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("hospital_appointment")
                      .doc("details")
                      .collection("records")
                      .where("id",
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .where("hospitalid", isEqualTo: widget.hospitalid)
                      // .where("hospitalid",
                      //     isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)

                      //  .where("hospitalid", isEqualTo: )
                      .snapshots(includeMetadataChanges: true),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('No Data Found'),
                      );
                    }

                    if (snapshot.hasData) {
                      print(FirebaseAuth.instance.currentUser!.uid);

                      return ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, int index) {
                            final DocumentSnapshot documentSnapshot =
                                snapshot.data!.docs[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    CupertinoPageRoute(builder: (context) {
                                  return HospitalChatRoom(
                                    hospitalName:
                                        documentSnapshot['hospitalName'],
                                    paitientid: documentSnapshot['id'],
                                    hospitalId: documentSnapshot['hospitalid'],
                                    paitientname: documentSnapshot['name'],
                                    // user : widget.doctorid,
                                  );
                                }));
                              },
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      child: Row(children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                documentSnapshot['hospitalName']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Color(0xff858585),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            Text(
                                              documentSnapshot['name']
                                                  .toString(),
                                              style: MyTheme.heading2.copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ]))),
                            );
                          });
                    } else {
                      return Center(
                          child: CircularProgressIndicator.adaptive());
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
