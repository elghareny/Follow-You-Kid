
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/models/chat/screens/home_chat_screen.dart';
import 'package:graduation_project/models/drawer/screens/profile_screen%20copy.dart';
import 'package:graduation_project/models/drawer/screens/profile_screen.dart';
import 'package:graduation_project/models/maps/start.dart';
import 'package:graduation_project/models/user_model.dart';
import 'package:graduation_project/models/connent_to_child.dart';
import 'package:graduation_project/models/maps/maps.dart';
import 'package:graduation_project/models/parent_model.dart';
import 'package:graduation_project/shared/components/constants.dart';
import 'package:graduation_project/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(InitialState());
  static AppCubit get(context)=>BlocProvider.of(context);



////////////////////////////////////////////////////////////   password text form fild   //////////////////

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


///////////////////////////////////////////////////////////////////////////////////  user login and register  //////////////


void userRegister ({
  @required String name,
  @required String email,
  @required String phone,
  @required String password,
  String childId,
})
{
  emit(UserRegisterLoadingState());
  FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
    password: password).then((value) {
      print(value.user.email);
      print(value.user.uid);
      userCreate(
        email: email,
        name: name,
        phone: phone,
        uId: value.user.uid,
        childId: childId
      );
      emit(UserRegisterSuccessState(value.user.uid));
    }).catchError((error){
      emit(UserRegisterErrorState(error.toString()));
    });

}


void userLogin ({
  @required String email,
  @required String password,
})
{
  emit(UserLoginLoadingState());
  FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email, 
    password: password).then((value){
      print(value.user.email);
      print(value.user.uid);
      emit(UserLoginSuccessState(value.user.uid));
    }).catchError((error){
      print('error here here here here here');
      emit(UserLoginErrorState(error.toString()));
    });
}



void userCreate ({
   @required String name,
  @required String email,
  @required String phone,
  @required String uId,
  String childId,
})
{

  UserModel model = UserModel(
    name: name,
    email: email,
    phone: phone,
    uId: uId,
    image: 'assets/images/profile.jpg',
  );
    FirebaseFirestore.instance
  .collection('child')
  .doc(uId)
  .set(model.toMap())
  .then((value)
  {
    emit(UserCreateSuccessState(uId));
  })
  .catchError((error)
  {
    emit(UserCreateErrorState(error.toString()));
  });
  
}



///////////////////////////////////////////////////////////////////////////////////////   logout   ////////////


void logout ()
{
  FirebaseAuth.instance.signOut().then((value) {
     emit(LogoutSuccessState());
  });
 
}



///////////////////////////////////////////////////////////////////////////////////////////////  Parent  //////////




void parentRegister ({
  @required String name,
  @required String email,
  @required String phone,
  @required String password,
  @required String childId,
})
{
  emit(ParentRegisterLoadingState());
  FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
    password: password).then((value) {
      print(value.user.email);
      print(value.user.uid);
      parentCreate(
        email: email,
        name: name,
        phone: phone,
        uId: value.user.uid,
        childId: childId
      );
      emit(ParentRegisterSuccessState(value.user.uid));
    }).catchError((error){
      emit(ParentRegisterErrorState(error.toString()));
    });

}


void parentLogin ({
  @required String email,
  @required String password,
})
{
  emit(ParentLoginLoadingState());
  FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email, 
    password: password).then((value){
      print(value.user.email);
      print(value.user.uid);
      emit(ParentLoginSuccessState(value.user.uid));
    }).catchError((error){
      print('error here here here here here');
      emit(ParentLoginErrorState(error.toString()));
    });
}



void parentCreate ({
   @required String name,
  @required String email,
  @required String phone,
  @required String uId,
  @required String childId,
})
{

  ParentModel model = ParentModel(
    name: name,
    email: email,
    phone: phone,
    uId: uId,
    image: 'assets/images/profile.jpg',
    isEmailVerified: false,
    childId: childId
  ); 
    FirebaseFirestore.instance
  .collection('parent')
  .doc(uId)
  .set(model.toMap())
  .then((value)
  {
    emit(ParentCreateSuccessState(uId));
  })
  .catchError((error)
  {
    emit(ParentCreateErrorState(error.toString()));
  });
}




// void parentRegister ({
//   @required String name,
//   @required String email,
//   @required String phone,
//   @required String password,
// })
// {
//   emit(ParentRegisterLoadingState());
//   FirebaseAuth.instance.createUserWithEmailAndPassword(
//     email: email,
//     password: password).then((value) {
//       print(value.user.email);
//       print(value.user.uid);
//       parentCreate(
//         email: email,
//         name: name,
//         phone: phone,
//         uId: value.user.uid,
//       );
//       emit(ParentRegisterSuccessState(value.user.uid));
//     }).catchError((error){
//       emit(ParentRegisterErrorState(error.toString()));
//     });

// }


// void parentLogin ({
//   @required String email,
//   @required String password,
// })
// {
//   emit(ParentLoginLoadingState());
//   FirebaseAuth.instance.signInWithEmailAndPassword(
//     email: email, 
//     password: password).then((value){
//       print(value.user.email);
//       print(value.user.uid);
//       emit(ParentLoginSuccessState(value.user.uid));
//     }).catchError((error){
//       print('error here here here here here');
//       emit(ParentLoginErrorState(error.toString()));
//     });
// }



// void parentCreate ({
//    @required String name,
//   @required String email,
//   @required String phone,
//   @required String uId,
// })
// {

//   ParentModel model = ParentModel(
//     name: name,
//     email: email,
//     phone: phone,
//     uId: uId,
//     image: 'assets/images/profile.jpg',
//     isEmailVerified: false,
//     );

//   FirebaseFirestore.instance
//   .collection('parent')
//   .doc(uId)
//   .set(model.toMap())
//   .then((value)
//   {
//     emit(ParentCreateSuccessState(uId));
//   })
//   .catchError((error)
//   {
//     emit(ParentCreateErrorState(error.toString()));
//   });
// }




/////////////////////////////////////////////////////////////////



// ChildModel model;

//   void getUserData()
//   {
//     emit(ProjectGetUserLoadingState());
//     FirebaseFirestore.instance.collection('child').doc(uId).get()
//     .then((value)
//     {
//       print(value.data());
//       model = ChildModel.fromJson(value.data());
//       emit(ProjectGetUserSuccessState());
//     })
//     .catchError(((error)
//     {
//       print(error.toString());
//       emit(ProjectGetUserErrorState(error.toString()));
//     }));
//   }

}