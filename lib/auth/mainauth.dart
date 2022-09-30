import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:practo_paitient/auth/continuephone.dart';

class MainAuth extends StatefulWidget {
  const MainAuth({Key? key}) : super(key: key);

  @override
  State<MainAuth> createState() => _MainAuthState();
}

class _MainAuthState extends State<MainAuth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Image.asset(
              "asset/splash.png",
              width: 200,
              height: 200,
            )),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Welcome To Practo Paitent",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            margin: EdgeInsets.only(top: 40),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => ContinuePhone()));
              },
              child: Text(
                "Sign Up with Otp",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Color(0xff1060D7).withOpacity(.5),
                  fixedSize: Size(374, 60),
                  shape: StadiumBorder()),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "asset/google.png",
                  width: 73,
                  height: 71,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "OR",
                  style: TextStyle(color: Colors.black, fontSize: 22),
                ),
                SizedBox(
                  width: 10,
                ),
                Image.asset(
                  "asset/f.png",
                  width: 73,
                  height: 71,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
