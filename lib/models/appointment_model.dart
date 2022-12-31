import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Appointmentmodel {
  final String status;
  final String id;
  final String problem;
  final String name;
  final String age;
  final String? date;
  String uuid;
  final String? hospitalid;
  final String? hospitalemail;
  final String? hospitalAddress;
  final String? hospitalName;
  final String? time;

  Appointmentmodel({
    required this.hospitalid,
    required this.hospitalemail,
    required this.hospitalName,
    required this.hospitalAddress,
    required this.status,
    required this.uuid,
    required this.id,
    required this.problem,
    required this.name,
    required this.age,
    required this.date,
    required this.time,
  });

  ///Converting OBject into Json Object
  Map<String, dynamic> toJson() => {
        'hospitalid': hospitalid,
        'hospitalemail': hospitalemail,
        'hospitalName': hospitalName,
        'hospitalAddress': hospitalAddress,
        'status': status,
        'id': id,
        'uuid': uuid,
        'problem': problem,
        'name': name,
        'age': age,
        'date': date,
        'time': time,
      };

  static Appointmentmodel fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return Appointmentmodel(
        hospitalAddress: snapshot['hospitalAddress'] ?? '',
        hospitalName: snapshot['hospitalName'],
        hospitalemail: snapshot['hospitalemail'],
        hospitalid: snapshot['hospitalid'],
        status: snapshot['status'] ?? '',
        id: snapshot['id'] ?? '',
        problem: snapshot['problem'] ?? '',
        name: snapshot['name'] ?? '',
        age: snapshot['age'] ?? '',
        date: snapshot['date'] ?? '',
        time: snapshot['time'] ?? '',
        uuid: snapshot['uuid']);
  }
}
