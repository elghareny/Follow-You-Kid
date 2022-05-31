import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/cubit/states.dart';
import 'package:graduation_project/layout/home_layout.dart';
import 'package:graduation_project/models/Verified.dart';
import 'package:graduation_project/models/user_model.dart';
import 'package:graduation_project/modules/child/register_child_screen.dart';
import 'package:graduation_project/modules/login/select_user.dart';
import 'package:graduation_project/modules/login/reset_password.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/components/constants.dart';
import 'package:graduation_project/shared/cubit/cubit.dart';
import 'package:graduation_project/shared/cubit/states.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';



class ChildLogin extends StatelessWidget {
  ChildLogin({ Key key }) : super(key: key);

  var email = TextEditingController();
  var password = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocProvider(
        create: (BuildContext context)=>AppCubit(),
        child: BlocConsumer<AppCubit,AppStates>(
          listener: ( context,  state){
    
            
    
            if(state is UserLoginSuccessState)
            {
              CacheHelper.saveData(
                key : 'uId',
                value : state.uId,
              ).then((value)
              {
               
              navigateAndFinis(context, HomeLayout());
              showToast(
                text: 'Login Successful',
                state: ToastStates.SUCCESS);
            
                
              }).catchError((error){});
            }
             else if(state is UserLoginErrorState)
            {
              print('error here here here here here');
              showToast(
                text: state.error,
                state: ToastStates.ERROR);
            }
    
          },
          builder: (BuildContext context,AppStates state)
          {
    
            AppCubit cubit = AppCubit.get(context);

            UserModel userModel ;
    
    
            return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [mainColor, secondColor],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(100))),
                child: Center(
                  child: Icon(
                    Icons.family_restroom_rounded,
                    size: 100,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                height: 580,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.grey[200],
                        ),
                        padding: EdgeInsets.only(left: 10, top: 3, bottom: 3),
                        child: textField(
                          text: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          controller: email,
                          prefixIcon: Icons.email,
                          validate: (value) {
                            if (email.text.isEmpty) {
                              return 'Email Must Not Be Empty.';
                            }
                            else if (! email.text.contains('@')) {
                              return 'Email Is Not Valid.';
                            }
                            else if (! email.text.contains('.com')) {
                              return 'Email Is Not Valid.';
                            }
                            return null;
                          },
                          onSubmit: (value) {
                            print(email.text);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.grey[200],
                        ),
                        padding: EdgeInsets.only(left: 10, top: 3, bottom: 3),
                        child: textField(
                          isDefaultPassword: true,
                          text: 'Password',
                          keyboardType: TextInputType.visiblePassword,
                          controller: password,
                          prefixIcon: Icons.vpn_key,
                          suffixIcon: cubit.suffix,
                          isPassword: cubit.isPassword,
                          textInputAction: TextInputAction.go,
                          suffixPressed: () {
                            cubit.changePasswordVisibilty();
                          },
                          validate: (value) {
                            if (password.text.isEmpty ) {
                              return 'Password Must Not Be Empty.';
                            }
                            else if (password.text.length < 8 ) {
                              return 'Password Must Be Atleast 8 Characters.';
                            }
                            return null;
                          },
                          onSubmit: (value) {
                            print(password.text);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Text(
                              "Forgot Password ?",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, ResetPassword());
                                },
                                child: Text(
                                  "Reset Password",
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w400,
                                      color: mainColor),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      ConditionalBuilder(
                        condition: state is ! UserLoginLoadingState,
                        builder: (context)=>Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [mainColor, secondColor],
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                            child: TextButton(
                              child: Text(
                                "LOGIN",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              onPressed: () {
               
                                if (formKey.currentState.validate())
                                 {
                                   cubit.userLogin(
                                     email: email.text, 
                                     password: password.text);

                                     if(state is UserLoginSuccessState)
            {
              CacheHelper.saveData(
                key : 'uId',
                value : state.uId,
              ).then((value)
              {
            //     if (childModel.isEmailVerified == true)
            // {
              navigateAndFinis(context, HomeLayout());
            // }else
            // {
            //   navigateAndFinis(context, Verified());
            // }
              });
            }
             else if(state is UserLoginErrorState)
            {
              print('error here here here here here');
              showToast(
                text: state.error,
                state: ToastStates.ERROR);
            }                                    
                  }
                              },
                            )),
                            fallback: (context)=> Center(child: CircularProgressIndicator()),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 100.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don\'t have an account ?",
                                style: Theme.of(context).textTheme.bodyText1
                              ),
                              TextButton(
                                  onPressed: () {
                                    navigateTo(context, ChildRegister());
                                  },
                                  child: Text(
                                    "REGISTER A NEW ACCOUNT",
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w400,
                                        color: mainColor),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
          },
          ),
      ),
    );
  }
}


Widget _textInput({controller, hint, prefixIcon, suffixIcon, type}) {
  Function suffixPressed;
  bool isPassword = false;
  return Container(
    margin: EdgeInsets.only(
      top: 10,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: Colors.grey[200],
    ),
    padding: EdgeInsets.only(left: 10),
    child: TextFormField(
      controller: controller,
      keyboardType: type,
      textAlignVertical: TextAlignVertical.center,
      obscureText: isPassword,
      decoration: InputDecoration(
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: () {
                  SetState(value) {
                    isPassword = !isPassword;
                  }
                },
                icon: Icon(suffixIcon))
            : null,
        border: InputBorder.none,
        hintText: hint,
        prefixIcon: Icon(prefixIcon),
      ),
    ),
  );
}
