// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:instagram/screens/add_post_screen.dart';
// import 'package:instagram/screens/feed_screen.dart';
// import 'package:instagram/screens/profile_screen.dart';
// import 'package:instagram/screens/search_screen.dart';

import 'package:flutter/material.dart';
import 'package:practo_paitient/bottompages/appointment.dart';
import 'package:practo_paitient/bottompages/chats/screens/chat_page.dart';
import 'package:practo_paitient/bottompages/home.dart';
import 'package:practo_paitient/bottompages/profile.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  Home_Screen(),
  Appointment(),
  ChatPage(),
  Profile(),

  // Profile()
  //  Random(),
  //  ChatPage(),
  //  Profile(),
];
