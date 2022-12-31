import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practo_paitient/auth/continuephone.dart';
import 'package:practo_paitient/bottom.dart';
import 'package:practo_paitient/database/storage_methods.dart';
import 'package:practo_paitient/models/appointment_model.dart';
import 'package:practo_paitient/models/profile_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class DatabaseMethods {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future checkDocuement(String docID) async {
    final snapShot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid) // varuId in your case
        .get();

    if (snapShot == null || !snapShot.exists) {
      // docuement is not exist
      print('id is not exist');
    } else {
      print("id is really exist");
    }
  }

//Add Google
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

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
    required String phoneNumber,
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
          email: FirebaseAuth.instance.currentUser!.email ?? email,
          phoneNumber: phoneNumber,
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

  //Appointment_hospital
  Future<String> makeAppointment({
    String? name,
    String? age,
    String? problem,
    String? gender,
    String? date,
    String? time,
    String? hospitalId,
    String? hospitalName,
    String? hospitalAddress,
    String? hospitalEmail,
    String? uid,
  }) async {
    String res = 'Some error occured';
    var dooc = Uuid().v1();

    try {
      Appointmentmodel userModel = Appointmentmodel(
        hospitalid: hospitalId,
        hospitalAddress: hospitalAddress,
        hospitalName: hospitalName,
        hospitalemail: hospitalEmail,
        id: uid!,
        uuid: dooc,
        name: name.toString(),
        status: "pending",
        age: age.toString(),
        problem: problem.toString(),
        date: date.toString(),
        time: time.toString(),
      );

      await firebaseFirestore
          .collection('hospital_appointment')
          .doc("details")
          .collection("records")
          .doc(dooc)
          .set(userModel.toJson());
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //Save SHared Preferenc

}
