import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TimeSelction extends StatefulWidget {
  final id;
  const TimeSelction({super.key, required this.id});

  @override
  State<TimeSelction> createState() => _TimeSelctionState();
}

class _TimeSelctionState extends State<TimeSelction> {
  List<String> _texts = [
    "InduceSmile.com",
    "Flutter.io",
    "google.com",
    "youtube.com",
    "yahoo.com",
    "gmail.com"
  ];

  late List<bool> _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = List<bool>.filled(_texts.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("doctorTime")
                .doc("doctorname")
                .collection(widget.id)
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              return ListView.builder(
                itemCount: _texts.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(_texts[index]),
                    value: _isChecked[index],
                    onChanged: (val) {
                      setState(
                        () {
                          _isChecked[index] = val!;
                        },
                      );
                    },
                  );
                },
              );
            }));
  }
}
