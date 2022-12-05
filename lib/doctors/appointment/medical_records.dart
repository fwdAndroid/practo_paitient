import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:practo_paitient/bottom.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:uuid/uuid.dart';

class MedicalRecords extends StatefulWidget {
  const MedicalRecords({Key? key}) : super(key: key);

  @override
  _MedicalRecordsState createState() => _MedicalRecordsState();
}

class _MedicalRecordsState extends State<MedicalRecords> {
  List<File> images = [];

  TextEditingController nameController = TextEditingController();
  PlatformFile? filePicked;
  bool uploading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload multiple files")),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  getMultipImage();
                },
                child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Center(
                      child: Icon(
                        Icons.upload_file,
                        size: 50,
                      ),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 150,
                height: 150,
                child: images.length == 0
                    ? Center(
                        child: Text("No Images found"),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, i) {
                          return CachedNetworkImage(
                            imageUrl: images[i].path,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                        Colors.red, BlendMode.colorBurn)),
                              ),
                            ),
                            placeholder: (context, url) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset("asset/file.png"),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          );
                        },
                        itemCount: images.length,
                        // images[i].path.
                      ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Your name'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  // if (enabled[0] == true ||
                  //     enabled[1] == true ||
                  //     enabled[2] == true ||
                  //     enabled[3] == true ||
                  //     enabled[4] == true ||
                  //     enabled[5] == true) {
                  //   Navigator.pushNamed(
                  //       context, onBoardingPhotoVerificationScreenRoute);
                  // }

                  setState(() {
                    uploading = true;
                  });
                  for (int i = 0; i < images.length; i++) {
                    String url = await uploadFile(images[i]);
                    downloadUrls.add(url);

                    if (i == images.length - 1) {
                      storeEntry(downloadUrls, nameController.text);
                    }
                  }
                },
                child: uploading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Text(
                        "Done",
                        style: TextStyle(color: Colors.blue),
                      ),
              )
            ],
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 20),
          //   child: MaterialButton(
          //     color: Colors.blue,
          //     minWidth: double.infinity,
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(8)),
          //     height: 50,
          //     onPressed: () async {
          // for (int i = 0; i < images.length; i++) {
          //   String url = await uploadFile(images[i]);
          //   downloadUrls.add(url);

          //   if (i == images.length - 1) {
          //     storeEntry(downloadUrls, nameController.text);
          //   }
          // }
          //     },
          //     child: isloading
          //         ? Center(child: CircularProgressIndicator())
          //         : Text("Upload"),
          //   ),
          // )
        ),
      ),
    );
  }

  List<String> downloadUrls = [];

  getMultipImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'docx', 'doc'],
    );
    List<File> files =
        result!.paths.map((path) => File(path.toString())).toList();

    // final List<File>? pickedImages = _picker.map((path) => File(path)).toList();
    ;

    if (files != null) {
      files.forEach((e) {
        images.add(File(e.path));
      });

      setState(() {});
    }
  }

  Future<String> uploadFile(File file) async {
    //  final metaData = SettableMetadata(contentType: 'image/jpeg');
    final storageRef = FirebaseStorage.instance.ref();
    Reference ref = storageRef.child(
        'pictures/${DateTime.now().microsecondsSinceEpoch}/${FirebaseAuth.instance.currentUser!.uid}');
    final uploadTask = ref.putFile(file);

    final taskSnapshot = await uploadTask.whenComplete(() => null);
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }

  storeEntry(List<String> imageUrls, String name) {
    var uuid = Uuid().v1();
    FirebaseFirestore.instance
        .collection("medicalRecords")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("records")
        .doc(uuid)
        .set({'image': imageUrls, 'name': name}).then((value) =>
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (builder) => MobileScreenLayout())));
    // FirebaseFirestore.instance
    //     .collection('story')
    //     .add({'image': imageUrls, 'name': name}).then((value) {
    //   Navigator.push(context,
    //       MaterialPageRoute(builder: (builder) => MobileScreenLayout()));
    //   // Get.snackbar('Success', 'Data is stored successfully');
    // });
  }
}
