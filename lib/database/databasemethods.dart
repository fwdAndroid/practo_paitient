import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practo_paitient/database/storage_methods.dart';
import 'package:practo_paitient/models/profile_model.dart';

class DatabaseMethods {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

//OTP Number Add
  Future<String> numberAdd() async {
    String res = 'Some error occured';
    try {
      //Add User to the database with modal
      ProfileModel userModel = ProfileModel(
        dob: '',
        gender: '',
        name: '',
        uid: FirebaseAuth.instance.currentUser!.uid,
        email: '',
        address: '',
        phoneNumber: FirebaseAuth.instance.currentUser!.phoneNumber.toString(),
        photoURL: '',
      );
      await firebaseFirestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(
            userModel.toJson(),
          );
      res = 'success';
      debugPrint(res);
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //Profile Details
  Future<String> profileDetail({
    required String email,
    required String uid,
    required String name,
    required String address,
    required String gender,
    required String dob,
    required Uint8List file,
  }) async {
    String res = 'Some error occured';

    try {
      if (email.isNotEmpty || name.isNotEmpty) {
        String photoURL = await StorageMethods()
            .uploadImageToStorage('ProfilePics', file, false);
        //Add User to the database with modal

        ProfileModel userModel = ProfileModel(
          dob: dob,
          gender: gender,
          name: name,
          address: address,
          uid: FirebaseAuth.instance.currentUser!.uid,
          email: email,
          phoneNumber:
              FirebaseAuth.instance.currentUser!.phoneNumber.toString(),
          photoURL: photoURL,
        );
        await firebaseFirestore
            .collection('users')
            .doc(uid)
            .update(userModel.toJson());
        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
