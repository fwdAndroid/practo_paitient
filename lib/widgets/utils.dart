import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//Image Picker Code
pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);

  if (file != null) {
    return await file.readAsBytes();
  }
  print('No Image Selected');
}

/// SnakBar Code
showSnakBar(String contexts, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(contexts)));
}

// // Send e-mail
// class Utils {
//   static Future<void> sendEmail({
//     required String email,
//     required String subject,
//     required String body,
//   }) async {
//     String mail = "mailto:$email?subject=$subject&body=${Uri.encodeFull(body)}";
//     if (await UL.canLaunch(mail)) {
//       await UL.launch(mail);
//     } else {
//       throw Exception("Unable to open the email");
//     }
//   }
// }
