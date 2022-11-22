import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RecordsModel {
  // final String doctorid;
  final String id;
  final List<dynamic> recordsPhotos;

  RecordsModel({
    required this.id,
    required this.recordsPhotos,
  });

  ///Converting OBject into Json Object
  Map<String, dynamic> toJson() => {'id': id, 'recordsPhotos': recordsPhotos};

  static RecordsModel fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return RecordsModel(
      id: snapshot['id'],
      recordsPhotos: snapshot['recordsPhotos'],
    );
  }
}
