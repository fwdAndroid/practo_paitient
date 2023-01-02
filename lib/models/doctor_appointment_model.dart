import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DoctorModel {
  final String status;
  final String id;
  final String doctorid;
  final String problem;
  final String name;
  final String age;
  final String? date;
  final String gender;
  String uuid;
  final String? time;
  final String doctorName;

  DoctorModel({
    required this.status,
    required this.uuid,
    required this.id,
    required this.problem,
    required this.name,
    required this.age,
    required this.date,
    required this.time,
    required this.doctorid,
    required this.doctorName,
    required this.gender,
  });

  ///Converting OBject into Json Object
  Map<String, dynamic> toJson() => {
        'status': status,
        'id': id,
        'doctorName': doctorName,
        'uuid': uuid,
        'problem': problem,
        'name': name,
        'age': age,
        'date': date,
        'time': time,
        'doctorid': doctorid,
        'gender': gender
      };

  static DoctorModel fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return DoctorModel(
        status: snapshot['status'] ?? '',
        doctorName: snapshot['doctorName'] ?? '',
        id: snapshot['id'] ?? '',
        problem: snapshot['problem'] ?? '',
        name: snapshot['name'] ?? '',
        age: snapshot['age'] ?? '',
        date: snapshot['date'] ?? '',
        time: snapshot['time'] ?? '',
        doctorid: snapshot['doctorid'] ?? '',
        gender: snapshot['gender'] ?? '',
        uuid: snapshot['uuid']);
  }
}
