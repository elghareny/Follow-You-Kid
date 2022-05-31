import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduation_project/cubit/states.dart';
import 'package:graduation_project/models/chat/screens/home_chat_screen.dart';
import 'package:graduation_project/models/connent_to_child.dart';
import 'package:graduation_project/models/drawer/screens/profile_screen%20copy.dart';
import 'package:graduation_project/models/maps/maps.dart';
import 'package:graduation_project/models/maps/my_maps.dart';
import 'package:graduation_project/models/maps/start.dart';
import 'package:graduation_project/models/parent_model.dart';
import 'package:graduation_project/models/start_parent.dart';
import 'package:graduation_project/models/user_model.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/components/constants.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProjectCubit extends Cubit<ProjectStates>{
  ProjectCubit() : super(ProjectInitialState());
  static ProjectCubit get(context)=>BlocProvider.of(context);
  


  double radius = 0;

void changeSlider(double value)
{
  radius = value;
  emit(ChangeSliderState());
}


  int currentIndex = 0;


List <Widget> childScreens =
[
Start(uId),
HomeChatScreen(),
];

List <Widget> parentScreens =
[
ParentStart(),
HomeChatScreen(),
];

List <String> titles = 
[
  'Home',
  'Message',
  'Profile',
];


void changeIndex(int index)
{
  currentIndex = index;
  emit(ChangeBottomNavBarState());
}



  ////////////////////////  Fab Icon   ////////////////////////////////////


  bool isBottomSheetShown = false;
  IconData sheetIcon = Icons.edit;

  void changeBottomSheetState({
  @required bool isShow,
    @required IconData icon,
})
  {
    isBottomSheetShown = isShow;
    sheetIcon = icon;

    emit(ChangeBottomSheetState());
  }



///////////////////////////////////////////////////////////////////////////  get data  ////////////


  UserModel User;

  ParentModel Parent;

  HomeModel Home;


  void getUserData()
  {
    
    emit(ProjectGetUserLoadingState());
      FirebaseFirestore.instance.collection('child').doc(uId).get()
    .then((value)
    {
      User = UserModel.fromJson(value.data());
      emit(ProjectGetUserSuccessState());
    })
    .catchError(((error)
    {
      emit(ProjectGetUserErrorState(error.toString()));
    }));
    
      
  }

  void getParentData()
  {
    emit(ProjectGetParentLoadingState());
    FirebaseFirestore.instance.collection('parent').doc(uId).get()
    .then((value)
    {
      Parent = ParentModel.fromJson(value.data());
      emit(ProjectGetParentSuccessState());
    })
    .catchError(((error)
    {
      emit(ProjectGetParentErrorState(error.toString()));
    }));

  }




void getHome()
{
  parent.doc(uId).collection('home location').doc('home').get()
  .then((value) 
  {
    Home = HomeModel.fromJson(value.data());
    emit(ProjectGetHomeSuccessState());
  }
  ).catchError(((error){
    emit(ProjectGetHomeErrorState(error.toString()));
  }));
}


void HomeCreate ({
  @required double latitude,
  @required double longitude,
  @required String addressLine,
  @required String countryName,
  @required String postalCode,
})
{

  HomeModel model = HomeModel(
    latitude: latitude,
    longitude: longitude,
    addressLine: addressLine,
    countryName: countryName,
    postalCode: postalCode,
  );
  if(isChild == false ){
    parent
  .doc(uId).collection('home location').doc('home')
  .set(model.toMap())
  .then((value)
  {
    emit(HomeCreateSuccessState(uId));
  })
  .catchError((error)
  {
    emit(HomeCreateErrorState(error.toString()));
  });}

}

// void getParentData()
// {
//     emit(ProjectGetParentLoadingState());
//     FirebaseFirestore.instance.collection('parent').doc(uId).get()
//     .then((value)
//     {
//       print(value.data());
//       parentModel = ParentModel.fromJson(value.data());
//       emit(ProjectGetParentSuccessState());
//     })
//     .catchError(((error)
//     {
//       print(error.toString());
//       emit(ProjectGetParentErrorState(error.toString()));
//     }));
// }



////////////////////////////////////////////////////////////////////////////////////////////  save data   ///////////


// void saveData(
//   {
//   @required String name,
//   @required String email,
//   @required String phone,
//   @required String password,
//   }
// )
// {
//  emit(EaditDataLoadingState());
//  ChildModel model = ChildModel(
//     name: name,
//     email: email,
//     phone: phone,
//     uId: uId,
//     image: 'assets/images/profile.jpg',
//     isEmailVerified: false,
//   );

//   FirebaseFirestore.instance
//   .collection('child')
//   .doc(uId)
//   .set(model.toMap())
//   .then((value)
//   {
//     emit(EaditDataSuccessState(uId));
//   })
//   .catchError((error)
//   {
//     emit(EaditDataErrorState(error.toString()));
//   });
// }







// String uIdLogout;

void logout ()
{
  FirebaseAuth.instance.signOut()
  .then((value){
    emit(LogoutSuccessState());
  })
  .catchError(((error){
    emit(LogoutErrorState(error.toString()));
  }));
  
}







// void verified ()
// {

//   bool isEmailVerified = User.isEmailVerified;
//   FirebaseAuth.instance.currentUser.sendEmailVerification().then((value) 
//   {
//     showToast(
//       text: 'Check your mail',
//       state: ToastStates.SUCCESS);
    
//     emit(VerifiedSuccessState());
//   }).catchError(((error)
//   {
//     emit(VerifiedErrorState(error.toString()));
//   }));
// }



////////////////////////////////////////////////////////////////////////////////////////////  Image Picker ////////////





File selectedImage;

   Future getImage(ImageSource source)async
  {
    final pickedImage = await ImagePicker().getImage(source: source);
    

      try{
      if(pickedImage != null)
      {
        final cropped = await ImageCropper().cropImage(
      sourcePath: pickedImage.path,
      aspectRatio: CropAspectRatio(ratioX: 1 , ratioY: 1),
      compressQuality: 100,
      maxWidth: 700,
      maxHeight: 700,
      androidUiSettings: AndroidUiSettings(
        toolbarColor: mainColor,
        toolbarTitle: 'Crop',
        statusBarColor: mainColor,
        backgroundColor: Colors.white
      )
      );

  selectedImage = File(cropped.path);
  emit(ProfileImageSuccessState());

      }
      }on PlatformException catch(e)
    {
      print('Faild to pick image: $e');
      emit(ProfileImageErrorState(e.toString()));
    }
  }




Future <ImageSource> showImageSource(BuildContext context)async
  {
    if(Platform.isIOS)
    {
      return showCupertinoModalPopup<ImageSource>(context: context, builder: (context)=>
      CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text('Camera'),
            onPressed: ()=>getImage(ImageSource.camera),
          ),
          CupertinoActionSheetAction(
            child: Text('Gallery'),
            onPressed: ()=>getImage(ImageSource.gallery),
          ),
        ],
      )
      );
    }else{
      return showModalBottomSheet(context: context,
       builder: (context)=>Column(
         mainAxisSize: MainAxisSize.min,
         children: [
           ListTile(leading: Icon(Icons.camera_alt),
           title: Text('Camera'),
           onTap: () => getImage(ImageSource.camera),),
           ListTile(leading: Icon(Icons.image),
           title: Text('Gallery'),
           onTap: () => getImage(ImageSource.gallery),),
         ],
       )
       );
    }
  }




//////////////////////////////////////////////////////////////////////////////////   update data   //////////////////////


void uploadProfile({
  @required String name,
    @required String phone,
}) {
    FirebaseStorage.instance
        .ref()
        .child('child/${Uri.file(selectedImage.path).pathSegments.last}')
        .putFile(selectedImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(name: name, phone: phone, image: value);
        emit(UploadProfileSuccessState());
      }).catchError((error) {
        emit(UploadProfileErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(UploadProfileErrorState(error.toString()));
    });
  }



   void updateUser({
    @required String name,
    @required String phone,
    String childId,
    String image,
  }) {

    emit(EaditDataLoadingState());

    UserModel model = UserModel(
      name: name,
      email: User.email,
      image: image ?? User.image,
      phone: phone,
      uId: User.uId
    );
    
      FirebaseFirestore.instance
        .collection('child')
        .doc(User.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).then((value){
      emit(EaditDataSuccessState());
    }).catchError((error) {
      emit(EaditDataErrorState(error.toString()));
    });
    
      FirebaseFirestore.instance
        .collection('parent')
        .doc(User.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).then((value){
      emit(EaditDataSuccessState());
    }).catchError((error) {
      emit(EaditDataErrorState(error.toString()));
    });
}




 void updateParent({
    @required String name,
    @required String phone,
    @required String childId,
    String image,
  }) {

    emit(EaditDataLoadingState());

    ParentModel model = ParentModel(
      name: name,
      email: Parent.email,
      image: image ?? Parent.image,
      phone: phone,
      isEmailVerified: Parent.isEmailVerified,
      childId: childId,
      uId: Parent.uId
    );
    
      FirebaseFirestore.instance
        .collection('parent')
        .doc(Parent.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).then((value){
      emit(EaditDataSuccessState());
    }).catchError((error) {
      emit(EaditDataErrorState(error.toString()));
    });
}
    
  





//////////////////////////////////////////////////////////////////////////////////////////////////////////////////






IconData suffix =Icons.lock_open;
IconData confirmSuffix =Icons.lock_open;
bool isPassword = true;
bool isConfirmPassword = true;
void changePasswordVisibilty()
{
  isPassword = ! isPassword;
  suffix = isPassword ? Icons.lock_open : Icons.lock;
  emit(ChangePasswordVisiblityState());
}
void changeConfirmPasswordVisibilty()
{
  isConfirmPassword = ! isConfirmPassword;
  confirmSuffix = isConfirmPassword ? Icons.lock_open : Icons.lock;
  emit(ChangeConfirmPasswordVisiblityState());
}





  // int currentIndex=0;
  // List<BottomNavigationBarItem> bottomItems=
  // [
  //   BottomNavigationBarItem(
  //     icon:Icon(Icons.home_outlined),
  //     label: 'Home',
  //   ),
  //   BottomNavigationBarItem(
  //     icon:Icon(Icons.chat_rounded),
  //     label: 'Chats',
  //   ),
  //   BottomNavigationBarItem(
  //     icon:Icon(Icons.settings),
  //     label: 'Settings',
  //   ),
  // ];

  // List<Widget>screens=
  // [
  // ];

  // void changenavbar(int index)
  // {
  //   currentIndex=index;
  //   emit(BottomNavState());
  // }

  // bool switchval=true;
  // void switchBotton (bool value)
  // {
  //   switchval=value;
  //   emit(SwitchState());
  // }



void connectTOChild ({
  @required String childId,
})
{

  UserModel model = UserModel(
    name: User.name,
    email: User.email,
    phone: User.phone,
    uId: User.uId,
    image: User.image,
  );

  emit(ConnectTOChildLoadingState());

    parent
  .doc(User.uId)
  .update(model.toMap())
  .then((value)
  {
    emit(ConnectTOChildSuccessState(uId));
  })
  .catchError((error)
  {
    emit(ConnectTOChildErrorState(error.toString()));
  });

  
}


}