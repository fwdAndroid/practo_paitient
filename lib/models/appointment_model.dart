import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Appointmentmodel {
  final String status;
  final String id;
  final String problem;
  final String name;
  final String age;
  final String date;
  final String time;
  final String phoneNumber;
  final List? medicalRecordsImages;

  Appointmentmodel(
      {required this.status,
      required this.id,
      required this.problem,
      required this.name,
      required this.age,
      required this.date,
      required this.time,
      required this.phoneNumber,
      required this.medicalRecordsImages});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'status': status,
      'id': id,
      'problem': problem,
      'name': name,
      'age': age,
      'date': date,
      'time': time,
      'medicalRecordsImages': medicalRecordsImages,
      'phoneNumber': phoneNumber
    };
  }

  static Appointmentmodel fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return Appointmentmodel(
      status: snapshot['status'],
      id: snapshot['id'],
      problem: snapshot['problem'],
      name: snapshot['name'],
      age: snapshot['age'],
      date: snapshot['date'],
      time: snapshot['time'],
      phoneNumber: snapshot['phoneNumber'],
      medicalRecordsImages: [],
    );
  }
}
