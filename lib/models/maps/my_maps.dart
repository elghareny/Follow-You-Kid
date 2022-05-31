import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduation_project/cubit/cubit.dart';
import 'package:graduation_project/cubit/states.dart';
import 'package:graduation_project/models/user_model.dart';
import 'package:graduation_project/shared/components/constants.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoder/geocoder.dart' as geoCo;


class MyMap extends StatelessWidget {
  final String user_id;
  MyMap(this.user_id);


   final loc.Location location = loc.Location();
  GoogleMapController _controller;
  bool _added = false;

  

Map <MarkerId,Marker> markers = <MarkerId,Marker> {};

MarkerId mid = MarkerId('id');

String address;
String country;
String postalcode;

  Marker childMarker ;


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectCubit,ProjectStates>(
      listener: (context, state) {
        
      },
      builder: (context,state)
      {

       ProjectCubit mapCubit = ProjectCubit.get(context);

        var Parent = mapCubit.Parent;
        mapCubit.getHome();
        var Home = mapCubit.Home;

        cId = Parent.childId;

        LatLng center;
        

         homeTapped (LatLng tapped) async
  {
    if(toAdded)
    {
      final coordinated = new geoCo.Coordinates(tapped.latitude, tapped.longitude);
    var address = await geoCo.Geocoder.local.findAddressesFromCoordinates(coordinated);
    var firestAddress = address.first;
    mapCubit.HomeCreate(
      latitude: tapped.latitude,
       longitude: tapped.longitude,
        addressLine: firestAddress.addressLine,
         countryName: firestAddress.countryName,
          postalCode: firestAddress.postalCode);
          circled = true;
          CacheHelper.saveData(
                key : 'circled',
                value : circled = true,
              );
    }
    // await parent.doc(uId).collection('home location').doc('home').set({
    //   'latitude' : tapped.latitude,
    //   'longitude' : tapped.longitude,
    //   'Address' : firestAddress.addressLine,
    //   'country' : firestAddress.countryName,
    //   'postalcode' : firestAddress.postalCode,
    // });
  }

        Set<Circle> circles = Set.from([Circle(
    circleId: CircleId('circle'),
    center: LatLng(Home.latitude, Home.longitude),
    radius: mapCubit.radius,
    strokeWidth: 5,
    strokeColor: Colors.red
)]);

        Set<Circle> nonCircles = Set.from([Circle(
    circleId: CircleId('circle'),
    center: LatLng(0, 0),
    radius: 0,
    strokeWidth: 5,
    strokeColor: Colors.red
)]);



        return Scaffold(
        body: Scaffold(
          body: StreamBuilder(
              stream: child.doc(cId).collection('location').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (_added) {
            mymap(snapshot);
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return GoogleMap(
            onTap: homeTapped,
            // ((LatLng point) {
            //   center = point;
            // }),
            mapType: MapType.hybrid,
            // onTap:toAdded ? tapped : null,
            markers:
            // Set<Marker>.of(markers.values)
             { Marker(
                  position: LatLng(
                    snapshot.data.docs.singleWhere(
                        (element) => element.id == user_id)['latitude'],
                    snapshot.data.docs.singleWhere(
                        (element) => element.id == user_id)['longitude'],
                  ),
                  markerId: MarkerId('id'),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueMagenta)),
             }
            ,
            initialCameraPosition: CameraPosition(
                target: LatLng(
                  snapshot.data.docs.singleWhere(
                      (element) => element.id == user_id)['latitude'],
                  snapshot.data.docs.singleWhere(
                      (element) => element.id == user_id)['longitude'],
                ),
                zoom: 14.47),
            onMapCreated: (GoogleMapController controller) async {
                _controller = controller;
                _added = true;
            },
            circles:  circled ? circles : nonCircles
          );
              },
            ),
        ));
      },);
  }

  Future<void> mymap(AsyncSnapshot<QuerySnapshot> snapshot) async {

    // myMarkers.add(childMarker);
    await _controller
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(
              snapshot.data.docs.singleWhere(
                  (element) => element.id == user_id)['latitude'],
              snapshot.data.docs.singleWhere(
                  (element) => element.id == user_id)['longitude'],
            ),
            zoom: 15)));
  }


  void getMarkers(double lat, double long)
  {
    MarkerId markerId = MarkerId(lat.toString() + long.toString());
    Marker _marker = Marker(
      markerId: markerId,
      position: LatLng(lat,long),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
      infoWindow: InfoWindow(snippet: 'address')
    );
    markers[markerId] = _marker;
  }


  tapped (LatLng tapped) async
  {
    final coordinated = new geoCo.Coordinates(tapped.latitude, tapped.longitude);
    getMarkers(tapped.latitude, tapped.longitude);
    var address = await geoCo.Geocoder.local.findAddressesFromCoordinates(coordinated);
    var firestAddress = address.first;
    await parent.doc(uId).collection('home location').add({
      'latitude' : tapped.latitude,
      'longitude' : tapped.longitude,
      'Address' : firestAddress.addressLine,
      'country' : firestAddress.countryName,
      'postalcode' : firestAddress.postalCode,
    });
  }
    
 


}