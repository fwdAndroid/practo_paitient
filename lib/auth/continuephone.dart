import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:practo_paitient/auth/verifyphone.dart';

class ContinuePhone extends StatelessWidget {
  const ContinuePhone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PhoneController controller;
    return SafeArea(
      child: Scaffold(
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
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              "We will send you a code for verification dont share \n anyone your code",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
              child: PhoneFormField(
                key: Key('phone-field'),
                shouldFormat: true, // default
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hintText: "Enter Phone Number",
                ),
                validator: PhoneValidator
                    .validMobile(), // default PhoneValidator.valid()
                countrySelectorNavigator:
                    CountrySelectorNavigator.bottomSheet(),
                showFlagInInput: true, // default
                flagSize: 16, // default
                autofillHints: [
                  AutofillHints.telephoneNumber
                ], // default to null
                enabled: true, // default
                autofocus: false, // default
                autovalidateMode: AutovalidateMode.onUserInteraction, // default
                onChanged: (p) => print('changed $p'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => VerifyPhone()));
                  },
                  child: Text('Get OTP'),
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      primary: Color(0xff1060D7).withOpacity(.5),
                      fixedSize: Size(300, 46))),
            ),
          ],
        ),
      ),
    );
  }
}
