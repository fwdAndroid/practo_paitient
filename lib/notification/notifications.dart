import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          "Notification",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('appointments')
                    .doc("details")
                    .collection("records")
                    .where(
                      "id",
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid,
                    )
                    .where('status', isEqualTo: "start")
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('No UpComming Appointment'),
                    );
                  }
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height,
                          child: ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                final DocumentSnapshot documentSnapshot =
                                    snapshot.data!.docs[index];
                                return Column(
                                  children: [
                                    ListTile(
                                      // onTap: () {
                                      //   Navigator.push(
                                      //       context,
                                      //       MaterialPageRoute(
                                      //           builder: (builder) =>
                                      //               vIEWd(
                                      //                 age: documentSnapshot[
                                      //                     'age'],
                                      //                 id: documentSnapshot[
                                      //                     'id'],
                                      //                 date: documentSnapshot[
                                      //                     'date'],
                                      //                 name: documentSnapshot[
                                      //                     'name'],
                                      //                 problem: documentSnapshot[
                                      //                     'problem'],
                                      //               )));
                                      // },
                                      title: Text(documentSnapshot['name']),
                                      subtitle: Text(documentSnapshot['date']),
                                    ),
                                    Divider()
                                  ],
                                );
                              }),
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                })),
      ),
    );
  }
}
