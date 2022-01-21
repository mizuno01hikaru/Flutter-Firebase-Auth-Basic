import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_shop_app/screens/profile_screen.dart';
import 'package:firebase_shop_app/screens/screen.dart';
import 'package:firebase_shop_app/screens/search_screen.dart';
import 'package:flutter/material.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const Screen(),
  const SearchScreen(),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
