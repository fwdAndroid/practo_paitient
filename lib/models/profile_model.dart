import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel {
  String uid;
  String address;
  String email;
  String name;
  String gender;
  String phoneNumber;
  String dob;
  String photoURL;
  List<dynamic> likes;

  ProfileModel({
    required this.likes,
    required this.uid,
    required this.gender,
    required this.email,
    required this.photoURL,
    required this.address,
    required this.name,
    required this.dob,
    required this.phoneNumber,
  });

  ///Converting OBject into Json Object
  Map<String, dynamic> toJson() => {
        'name': name,
        'uid': uid,
        'email': email,
        'phoneNumber': phoneNumber,
        'photoURL': photoURL,
        'gender': gender,
        'address': address,
        'dob': dob,
        'likes': likes
      };

  ///
  static ProfileModel fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return ProfileModel(
        likes: snapshot['likes'],
        gender: snapshot['gender'],
        name: snapshot['name'],
        uid: snapshot['uid'],
        email: snapshot['email'],
        photoURL: snapshot['photoURL'],
        phoneNumber: snapshot['phoneNumber'],
        dob: snapshot['dob'],
        address: snapshot['address']);
  }
}
