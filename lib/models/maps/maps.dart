import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduation_project/models/user_model.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/components/constants.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {

  UserModel User;

  var toAdd = false;

  Position currentPosition;
  var getLocator = Geolocator();
  GoogleMapController newGoogleMapController;  


  List<Marker> myMarker =[];
  List<Marker> allMarkers =[];
  String inputaddr = '';

  
  
  Marker newMyMarker ;

  @override
  void initState(){
    super.initState();
  }

  void getCurrentLocation () async {
    var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition=position;
    LatLng latlngPosition = LatLng(position.latitude, position.latitude);
    CameraPosition cameraPosition = new CameraPosition(target: latlngPosition,zoom: 11.5);
    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

  }

  Completer<GoogleMapController> _controller = Completer();
  TextEditingController _searchController = TextEditingController();

  static final CameraPosition _HomeMarker = CameraPosition(
    target: LatLng(30.8254669, 30.8139165),
    zoom: 10.4746,
  );

  // static final Marker _MarkerOne = Marker(
  //   markerId: MarkerId('_MarkerOne'),
  //   infoWindow: InfoWindow(title: 'Marker One'),
  //   icon: BitmapDescriptor.defaultMarker,
  //   position: LatLng(30.8254669, 30.8139165),
  // );

  // static final CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(31.000376, 30.786509),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  // static final Marker _MarkerTwo = Marker(
  //   markerId: MarkerId('_MarkerTwo'),
  //   infoWindow: InfoWindow(title: 'Marker Two'),
  //   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  //   position: LatLng(31.000376, 30.786509),
  // );

  // static final Polyline _KPolyline = Polyline(
  //   polylineId: PolylineId('_KPolyline'),
  //   points: [
  //     LatLng(31.000376, 30.786509),
  //     LatLng(30.8254669, 30.8139165),
  //   ],
  //   width: 5,
  // );

  // static final Polygon _KPolygon =
  //     Polygon(polygonId: PolygonId('_KPolygon'), points: [
  //   LatLng(31.000376, 30.786509),
  //   LatLng(30.8254669, 30.8139165),
  // ]);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                controller: _searchController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  hintText: 'Search by city',
                  border: InputBorder.none
                  ),
                onChanged: (value) {
                    print(value);
                },
              ),
                  )),
              IconButton(icon: Icon(Icons.search), onPressed: () {})
            ],
          ),
          Expanded(
            child: GoogleMap(
              mapType: MapType.hybrid,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              onTap: toAdd ? _handelTap : null,
              markers: Set.from(allMarkers),
              // polylines: {
              //   _KPolyline,
              // },
              // polygons: {
              //   _KPolygon
              // },
              initialCameraPosition: _HomeMarker,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                newGoogleMapController = controller;
                getCurrentLocation();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()
        {
         setState(() {
          addMarker();
         }); 
        },
        label: Text('Add Location!'),
        icon: Icon(Icons.add),
      )

      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: Text('To the lake!'),
      //   icon: Icon(Icons.directions_boat),
      // ),
    );
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }


  _handelTap(LatLng tappedPoint)
  {
    setState(() {
      newMyMarker = Marker(markerId: MarkerId(tappedPoint.toString()),
      position: tappedPoint);
    });
  }




  void getUserData()
  {
      FirebaseFirestore.instance.collection('parent').doc(uId).get()
    .then((value)
    {
      User = UserModel.fromJson(value.data());
    })
    .catchError(((error)
    {
      print(error.toString());
    }));
  }



  void updateUser({
    @required GeoPoint coords,
    @required String place,
  }) {
    UserModel model = UserModel(
      name: User.name,
      email: User.email,
      image: User.image,
      phone: User.phone,
      uId: User.uId,
      // coords: coords,
      // place: place
    );
    
      FirebaseFirestore.instance
        .collection('parent')
        .doc(User.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).then((value){
    }).catchError((error) {
    });
}



 setMarkers()
  {
    return allMarkers;
  }

  addToList()async
  {
    final quary = inputaddr;
    var addresses = await Geocoder.local.findAddressesFromQuery(quary);
    var address = addresses.first;
    GeoPoint coords = new GeoPoint(address.coordinates.latitude, address.coordinates.longitude);
    String place = address.featureName;
    print('${coords}+${place}');
    setState(() {
      allMarkers.add(
      Marker(
         markerId: MarkerId('_Marker'),
        infoWindow: InfoWindow(title: 'First place'),
        icon: BitmapDescriptor.defaultMarker,
        position: LatLng(address.coordinates.latitude, address.coordinates.longitude),
      )
    );
    });
      
    
    
  }




  Future addMarker()async
  {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context)
      {
        return   SimpleDialog(
          title:  Text('Add Marker',
          style: TextStyle(fontSize: 20.0),
          ),
          children: [
            TextField(
              onChanged: (String value) {
                setState(() {
                  inputaddr = value;
                });
              },
            ),
            SimpleDialogOption(
              child: Text('Add',
              style: TextStyle(color: mainColor),),
              onPressed: (){
                addToList();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }


  

}
