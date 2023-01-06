import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practo_paitient/bottompages/chat_appointments/doctor_past_room.dart';
import 'package:practo_paitient/bottompages/chats/app_theme.dart';
import 'package:practo_paitient/bottompages/chats/screens/chat_doctor_room.dart';
import 'package:uuid/uuid.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PastDoctor extends StatefulWidget {
  @override
  State<PastDoctor> createState() => _PastDoctorState();
}

class _PastDoctorState extends State<PastDoctor> {
  @override
  Widget build(BuildContext context) {
    var uuid = Uuid().v1();
    print("fawad");
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("doctor_appointment")
                      .doc("details")
                      .collection("records")
                      .where("id",
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .where("status", isEqualTo: "complete")
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DoctorPastRoom(
                                      doctorName:
                                          documentSnapshot['doctorName'],
                                      paitientid: documentSnapshot['id'],
                                      doctorId: documentSnapshot['doctorid'],
                                      paitientname: documentSnapshot['name'],
                                    ),
                                  ),
                                );
                                // Navigator.push(context,
                                //     CupertinoPageRoute(builder: (context) {
                                //   return DoctorChatRoom(
                                //     doctorName: documentSnapshot['doctorName'],
                                //     paitientId: documentSnapshot['id'],
                                //     doctorId: documentSnapshot['doctorid'],
                                //     paitientName: documentSnapshot['name'],
                                //     // user : widget.doctorid,
                                //   );
                                // }));
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
                                                documentSnapshot['doctorName']
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
