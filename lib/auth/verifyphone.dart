// import 'package:college_meet/Screens/authphone/selectinterest.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:practo_paitient/bottom.dart';
import 'package:practo_paitient/database/databasemethods.dart';
import 'package:practo_paitient/profile/profile.dart';

import 'continuephone.dart';

class VerifyPhone extends StatefulWidget {
  final String phone;
  final String codeDigits;
  const VerifyPhone({Key? key, required this.codeDigits, required this.phone})
      : super(key: key);

  @override
  State<VerifyPhone> createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  final GlobalKey<ScaffoldState> _scalfoldkey = GlobalKey<ScaffoldState>();
  final TextEditingController controllerpin = TextEditingController();
  final FocusNode pinOTPFocusNode = FocusNode();

  String? verificationCode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verificationPhone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "asset/splash.png",
            width: 150,
            height: 200,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "OTP Verification",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          ),
          SizedBox(
            height: 6,
          ),
          Text("verification: ${widget.codeDigits}-${widget.phone}"),
          SizedBox(height: 50),
          Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
              child: PinCodeTextField(
                focusNode: pinOTPFocusNode,
                controller: controllerpin,
                appContext: context,
                pastedTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                length: 6,
                onSubmitted: (pin) async {
                  try {
                    await FirebaseAuth.instance
                        .signInWithCredential(PhoneAuthProvider.credential(
                            verificationId: verificationCode!, smsCode: pin))
                        .then((value) {
                      if (value.user != null) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (builder) => MobileScreenLayout()));
                      }
                    });
                  } catch (e) {
                    FocusScope.of(context).unfocus();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Invalide Code"),
                      duration: Duration(seconds: 12),
                    ));
                  }
                },
                animationType: AnimationType.fade,
                validator: (v) {
                  if (v!.length < 3) {
                    return "I'm from validator";
                  } else {
                    return null;
                  }
                },
                pinTheme: PinTheme(),
                animationDuration: const Duration(milliseconds: 300),
                keyboardType: TextInputType.number,
                onCompleted: (v) {
                  debugPrint("Completed");
                },
                onChanged: (value) {
                  debugPrint(value);
                  setState(() {});
                },
                beforeTextPaste: (text) {
                  debugPrint("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
              )),
          SizedBox(height: 60),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => Profile()));
                },
                child: Text('Continue'),
                style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    primary: Color(0xfff0092E1),
                    fixedSize: Size(330, 50))),
          ),
        ],
      ),
    );
  }

  void verificationPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "${widget.codeDigits + widget.phone}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) {
            if (value.user != null) {
              // Customdialog.showDialogBox(context);
              addPhone();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (builder) => Profile(),
                ),
              );
              // Customdialog.closeDialog(context);
            } else {}
          });
        },
        verificationFailed: (FirebaseException e) {
          FocusScope.of(context).unfocus();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.message.toString()),
            duration: Duration(seconds: 12),
          ));
        },
        codeSent: (String VID, int? resentToken) {
          setState(() {
            verificationCode = VID;
          });
        },
        codeAutoRetrievalTimeout: (String VID) {
          setState(() {
            verificationCode = VID;
          });
        },
        timeout: Duration(seconds: 50));
  }

  void addPhone() async {
    await DatabaseMethods().numberAdd();
    // .then((value) => Customdialog.closeDialog(context));
  }
}
