// import 'package:college_meet/BottomNavigatonBar/Screens/Edit%20Profile/edit_profile.dart'
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:practo_paitient/notification/notifications.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);
  zisttile(String text, IconData icon, VoidCallback function) {
    return ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              color: Color(0xffE4ECFE),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              )),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              color: Color(0xff1060D7),
            ),
          ),
        ),
        title: Text(
          text,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
        ),
        trailing: IconButton(
          onPressed: function,
          icon: Icon(
            Icons.arrow_forward_ios,
            color: Colors.blue,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Container(
          margin: EdgeInsets.all(8),
          // padding: EdgeInsets.all(20),
          // margin: EdgeInsets.all(left: 10),
          width: 45,
          height: 45,

          child: Image.asset("asset/Vector.png"),
        ),
        title: Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
                // margin: EdgeInsets.symmetric(horizontal: 10),
                width: 50,
                height: 45,
                decoration: BoxDecoration(
                  color: Color(0xffE4ECFE),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Icon(
                  Icons.edit,
                  color: Color(0xff1060D7),
                )),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 110,
                // width: MediaQuery.of(context).size.width * 0.9,
                // width: 100,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundImage: AssetImage('asset/doctor.png'),
                    ),
                    Positioned(
                      top: 80,
                      left: 80,
                      // bottom: 20,
                      child: Container(
                        height: 10,
                        width: 10,
                        // width: 20,
                        // height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.redAccent,
                        ),
                        child: Center(
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.edit,
                                size: 15,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Text(
              'Adam Smith',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.grey,
              thickness: 0.5,
              indent: 15,
              endIndent: 15,
            ),
            // ListTile()
            zisttile('Edit Profile', Icons.person, () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (builder) => Edit_Profile()));
            }),
            Divider(
              color: Colors.grey,
              thickness: 0.5,
              indent: 15,
              endIndent: 15,
            ),
            zisttile('Notification', Icons.notifications, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => Notifications()));
            }),
            Divider(
              color: Colors.grey,
              thickness: 0.5,
              indent: 15,
              endIndent: 15,
            ),
            zisttile('Security', Icons.lock, () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (builder) => Invite_Friends()));
            }),
            Divider(
              color: Colors.grey,
              thickness: 0.5,
              indent: 15,
              endIndent: 15,
            ),
            zisttile('Invite Friends', Icons.people, () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (builder) => Invite_Friends()));
            }),
            Divider(
              color: Colors.grey,
              thickness: 0.5,
              indent: 15,
              endIndent: 15,
            ),
            zisttile('Logout', Icons.login_outlined, () {})
          ],
        ),
      ),
    );
  }
}
