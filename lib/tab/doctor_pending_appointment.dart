import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DoctorPendingAppointment extends StatefulWidget {
  const DoctorPendingAppointment({super.key});

  @override
  State<DoctorPendingAppointment> createState() =>
      _DoctorPendingAppointmentState();
}

class _DoctorPendingAppointmentState extends State<DoctorPendingAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FirebaseAuth.instance.currentUser != null
            ? StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('doctor_appointment')
                    .doc("details")
                    .collection("records")
                    // .where(
                    //   'status',
                    //   isNotEqualTo: 'DoctorPendingAppointment',
                    // )
                    .where(
                      'status',
                      isEqualTo: "pending",
                    )
                    .where('id',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Something went wrong'),
                    );
                  }
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Text(
                        //     '29 Decemeber 2002',
                        //     textAlign: TextAlign.start,
                        //     style:
                        //         TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
                        //   ),
                        // ),
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
                                      onTap: () {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (builder) =>
                                        //         AppointCurrentDetail(),
                                        //   ),
                                        // );
                                      },
                                      title: Text(documentSnapshot['name']),
                                      subtitle:
                                          Text(documentSnapshot['problem']),
                                      trailing: IconButton(
                                          onPressed: () async {
                                            await FirebaseFirestore.instance
                                                .collection(
                                                    'doctor_appointment')
                                                .doc("details")
                                                .collection("records")
                                                .doc(documentSnapshot.id)
                                                .delete();
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          )),
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
                })
            : const Center(
                child: Text('No Appointment DoctorPendingAppointment'),
              ),
      ),
    );
  }
}
