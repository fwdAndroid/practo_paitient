import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;
import 'package:practo_paitient/bottom.dart';
import 'package:practo_paitient/models/reocords.dart';
import 'package:uuid/uuid.dart';

class MedicalRecords extends StatefulWidget {
  const MedicalRecords({Key? key}) : super(key: key);

  @override
  State<MedicalRecords> createState() => _MedicalRecordsState();
}

class _MedicalRecordsState extends State<MedicalRecords> {
  // var phoneNumberController = TextEditingController();
  // var utils = AppUtils();
  // List<bool> enabled = [false, false, false, false, false, false];

  bool uploading = false;
  double val = 0;
  CollectionReference? imgRef;
  firebase_storage.Reference? ref;

  List<File> _image = [];
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.0625,
                    height: 7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 45,
              ),
              // Text(
              //   "Add your photos",
              //   style: utils.largeHeadingTextStyle(
              //     color: Colors.black,
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),

              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Align(
                  alignment: Alignment.center,
                  child: Wrap(
                    children: [
                      SizedBox(
                        height: 350,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.all(4),
                              child: GridView.builder(
                                  itemCount: _image.length + 1,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3),
                                  itemBuilder: (context, index) {
                                    return index == 0
                                        ? Center(
                                            child: IconButton(
                                                icon: Icon(Icons.add),
                                                onPressed: () => !uploading
                                                    ? chooseImage()
                                                    : null),
                                          )
                                        : Container(
                                            margin: EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                image: DecorationImage(
                                                    image: FileImage(
                                                        _image[index - 1]),
                                                    fit: BoxFit.cover)),
                                          );
                                  }),
                            ),
                            uploading
                                ? Center(
                                    child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        child: Text(
                                          'uploading...',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CircularProgressIndicator(
                                        value: val,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.green),
                                      )
                                    ],
                                  ))
                                : Container(),
                          ],
                        ),
                      ),
                      // for (int i = 0; i < 6; i++)
                      //   utils.addPhotosWidget(
                      //     onTap: () async {
                      //       if (enabled[i] == true) {
                      //         enabled[i] = false;
                      //       } else {
                      //         await Navigator.pushNamed(
                      //             context, editPhotosScreenRoute);
                      //         enabled[i] = true;
                      //       }
                      //       setState(() {});
                      //     },
                      //     enabled: enabled[i],
                      //     width: width,
                      //   ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: width > 415
                    ? MediaQuery.of(context).size.height * 0.1
                    : MediaQuery.of(context).size.height * 0.15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Text(
                                "Tip: ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "ProximaNova",
                                  color: Colors.blue,
                                ),
                              ),
                              Text(
                                "Pick Medical Records",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "ProximaNova",
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            "in your photos.",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: "ProximaNova",
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      // if (enabled[0] == true ||
                      //     enabled[1] == true ||
                      //     enabled[2] == true ||
                      //     enabled[3] == true ||
                      //     enabled[4] == true ||
                      //     enabled[5] == true) {
                      //   Navigator.pushNamed(
                      //       context, onBoardingPhotoVerificationScreenRoute);
                      // }
                      if (_image.length <= 6) {
                        setState(() {
                          uploading = true;
                        });
                        uploadFile().whenComplete(() => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => MobileScreenLayout())));
                      }
                    },
                    child: Text(
                      "Done",
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  chooseImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile!.path));
    });
    if (pickedFile!.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
  }

  var uid;
  List images = [];

  Future uploadFile() async {
    int i = 1;

    for (var img in _image) {
      setState(() {
        val = i / _image.length;
      });
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('medicalrecords/${Path.basename(img.path)}');
      await ref!.putFile(img).whenComplete(() async {
        await ref!.getDownloadURL().then((value) {
          print("Start");
          // RecordsModel recordsModel =
          //     RecordsModel(id: , recordsPhotos: FieldValue.arrayUnion([value]));
          // imgRef!.add({'url': value});
          var uuid = Uuid().v1();
          FirebaseFirestore.instance
              .collection("medicalRecords")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("records")
              .doc(uuid)
              .set({
            "images": FieldValue.arrayUnion([value]),
          });
        });
        i++;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    imgRef = FirebaseFirestore.instance.collection('imageURLs');
  }

//

  Future<String> records(
      {required List<dynamic> photos, required String id}) async {
    RecordsModel recordsModel = RecordsModel(id: id, recordsPhotos: photos);

    String res = "Data Stored";
    if (res.isNotEmpty) {}

    return res;
  }
}
