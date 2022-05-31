import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/models/user_model.dart';


Color mainColor = Color(0xFF673AB7);
Color secondColor = Color(0xFFAB47BC);
Color primaryGreen = Color(0xff416d6d);

// const kBackgroundColor = Color(0xFF202020);
// const kPrimaryColor = Color(0xFFFFBD73);

const kPrimaryColor = Color(0XFF6A62B7);
const kBackgroundColor = Color(0XFFE5E5E5);


String firebaseMapKey = "AIzaSyDOJl0kMBDX_VVJ7iktjZMs1ejM0dVsOYc";

String mapKey = "AIzaSyCj8rSRY2xsnz0kLEH8pDIFKUUdEMZAD5s";

String uId = '';

String pId = '';

String userCollection = '';

String cId;

bool isChild = false;

bool who = false;

bool toAdded = false;

bool circled = false;



CollectionReference child = FirebaseFirestore.instance.collection('child');
CollectionReference parent = FirebaseFirestore.instance.collection('parent');