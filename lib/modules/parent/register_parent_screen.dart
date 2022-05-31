import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/home_layout.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/components/constants.dart';
import 'package:graduation_project/shared/cubit/cubit.dart';
import 'package:graduation_project/shared/cubit/states.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';


class ParentRegister extends StatelessWidget {
  ParentRegister({ Key key }) : super(key: key);

  var email = TextEditingController();
  var phone = TextEditingController();
  var parentName = TextEditingController();
  var password = TextEditingController();
  var childId = TextEditingController();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ((BuildContext context) => AppCubit()),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: ((BuildContext context , AppStates state){

          if (state is UserRegisterSuccessState)
          {
            CacheHelper.saveData(
                key : 'pId',
                value : state.uId,
              ).then((value)
              {
                showToast(
              text: 'Registration Successful',
              state: ToastStates.SUCCESS);
                navigateAndFinis(context, HomeLayout());
              });

              CacheHelper.saveData(
                key : 'cId',
                value : childId,
              ).then((value)
              {
                showToast(
              text: 'Registration Successful',
              state: ToastStates.SUCCESS);});
              
          }
          else if(state is UserRegisterErrorState)
            {
              showToast(
                text: state.error,
                state: ToastStates.ERROR);
            }

        }),
        builder: (BuildContext context , AppStates state){

          AppCubit cubit = AppCubit.get(context);

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
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              height: 560,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.grey[200],
                      ),
                      padding: EdgeInsets.only(left: 10, top: 3, bottom: 3),
                      child: textField(
                        text: 'Parent Name',
                        keyboardType: TextInputType.name,
                        controller: parentName,
                        prefixIcon: Icons.person,
                        validate: (value) {
                          if (parentName.text.isEmpty) {
                            return 'Name Must Not Be Empty.';
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
                        text: 'Phone Number',
                        keyboardType: TextInputType.number,
                        controller: phone,
                        prefixIcon: Icons.phone,
                        textInputAction: TextInputAction.go,
                        validate: (value) {
                          if (phone.text.isEmpty) {
                            return 'Phone Must Not Be Empty.';
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
                          if (password.text.isEmpty) {
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
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.grey[200],
                      ),
                      padding: EdgeInsets.only(left: 10, top: 3, bottom: 3),
                      child: textField(
                        text: 'Child Id',
                        controller: childId,
                        prefixIcon: Icons.child_care_outlined,
                        validate: (value) {
                          if (childId.text.isEmpty) {
                            return 'Child Id Must Not Be Empty.';
                          }
                          return null;
                        },
                        onSubmit: (value) {
                          print(childId.text);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ConditionalBuilder(
                      condition: state is ! UserRegisterLoadingState,
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
                            "REGISTRATION",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          onPressed: () {
                            if (formKey.currentState.validate())
                               {
                                 cubit.userRegister(
                                   name: parentName.text, 
                                   email: email.text, 
                                   phone: phone.text, 
                                   password: password.text,
                                   childId: childId.text);
                                   }
                                   if (state is UserRegisterSuccessState)
          {
            CacheHelper.saveData(
                key : 'pId',
                value : state.uId,
              ).then((value)
              {
                
                navigateAndFinis(context, HomeLayout());
              });
          }else if(state is UserRegisterErrorState)
            {
              showToast(
                text: state.error,
                state: ToastStates.ERROR);
            }
                          },
                        )),
                        fallback: (context)=> Center(child: CircularProgressIndicator()),
                        
                        )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
        },),
      );
  }
}
