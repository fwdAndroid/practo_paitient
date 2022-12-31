import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TimeSelction extends StatefulWidget {
  const TimeSelction({super.key});

  @override
  State<TimeSelction> createState() => _TimeSelctionState();
}

class _TimeSelctionState extends State<TimeSelction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("doctorTime")
                .doc("doctorname")
                .collection("collectionPath")
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              return ListView.builder(itemBuilder: (context, index) {
                return ListTile();
              });
            }));
  }
}
