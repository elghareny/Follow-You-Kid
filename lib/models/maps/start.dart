import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/models/maps/my_maps.dart';
import 'package:graduation_project/models/user_model.dart';
import 'package:graduation_project/shared/components/constants.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';

class Start extends StatefulWidget {
  Start(String id);

  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {

  UserModel User;
  

  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData> _locationSubscription;

  @override
  void initState() {
    super.initState();
    _requestPermission();
    location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
    location.enableBackgroundMode(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  _getLocation();

                },
                child: Text('add my location',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w400
                  ),
                  )),
                  SizedBox(height: 20,),
            TextButton(
                onPressed: () {
                  _listenLocation();
                },
                child: Text('enable live location',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w400
                  ),
                
                )),
                SizedBox(height: 20,),
            // TextButton(
            //     onPressed: () {
            //       _stopListening();
            //     },
            //     child: Text('stop live location')),
            Expanded(
                child: StreamBuilder(
              stream:
                  child.doc(uId).collection('location').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title:
                            Text(snapshot.data.docs[index]['name'].toString()),
                        subtitle: Row(
                          children: [
                            Text(snapshot.data.docs[index]['latitude']
                                .toString()),
                            SizedBox(
                              width: 20,
                            ),
                            Text(snapshot.data.docs[index]['longitude']
                                .toString()),
                          ],
                        ),
                        // trailing: IconButton(
                        //   icon: Icon(Icons.directions),
                        //   onPressed: () {
                        //     Navigator.of(context).push(MaterialPageRoute(
                        //         builder: (context) =>
                        //             MyMap(snapshot.data.docs[index].id)));
                        //   },
                        // ),
                      );
                    });
              },
            )),
          ],
        ),
      ),
    );
  }

  _getLocation() async {
    try {
      final loc.LocationData _locationResult = await location.getLocation();
      await child.doc(uId).collection('location').doc('user').set({
        'latitude': _locationResult.latitude,
        'longitude': _locationResult.longitude,
        'name': 'Child'
      }, SetOptions(merge: true)).then((value) 
      {
        _listenLocation();
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _listenLocation() async {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubscription.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((loc.LocationData currentlocation) async {
      await child.doc(uId).collection('location').doc('user').set({
        'latitude': currentlocation.latitude,
        'longitude': currentlocation.longitude,
        'name': 'Child'
      }, SetOptions(merge: true));
    });
  }

  // _stopListening() {
  //   _locationSubscription?.cancel();
  //   setState(() {
  //     _locationSubscription = null;
  //   });
  // }

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
