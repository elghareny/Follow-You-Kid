import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/models/user_model.dart';
import 'package:graduation_project/modules/log/states.dart';
import 'package:graduation_project/shared/components/constants.dart';

class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit() : super(InitialState());
  static LoginCubit get(context)=>BlocProvider.of(context);



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
    // childId: childId
  );

  if(isChild == true )
  {
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
  }else
  {
    FirebaseFirestore.instance
  .collection('parent')
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

  
}


///////////////////////////////////////////////////////////////////////////////////////   logout   ////////////


void logout ()
{
  FirebaseAuth.instance.signOut().then((value) {
     emit(LogoutSuccessState());
  });
 
}


  }