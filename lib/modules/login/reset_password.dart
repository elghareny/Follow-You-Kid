import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/components/constants.dart';
import 'package:graduation_project/shared/cubit/cubit.dart';
import 'package:graduation_project/shared/cubit/states.dart';



class ResetPassword extends StatelessWidget {
  ResetPassword({ Key key }) : super(key: key);

  var email = TextEditingController();
  var password = TextEditingController();
  var confirmPassword = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(listener: (context,state){},
      builder: (context,state){

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
            Container(
              padding: EdgeInsets.all(20.0),
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
                        text: 'New Password',
                        keyboardType: TextInputType.visiblePassword,
                        controller: password,
                        prefixIcon: Icons.vpn_key,
                        suffixIcon: cubit.suffix,
                        isPassword: cubit.isPassword,
                        textInputAction: TextInputAction.next,
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
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.grey[200],
                      ),
                      padding: EdgeInsets.only(left: 10, top: 3, bottom: 3),
                      child: textField(
                        isDefaultPassword: false,
                        text: 'Confirm Password',
                        keyboardType: TextInputType.visiblePassword,
                        controller: confirmPassword,
                        prefixIcon: Icons.vpn_key,
                        suffixIcon:
                            cubit.confirmSuffix,
                        isPassword: cubit.isConfirmPassword,
                        textInputAction: TextInputAction.go,
                        newSuffixPressed: () {
                          cubit.changeConfirmPasswordVisibilty();
                        },
                        validate: (value) {
                          if (confirmPassword.text.isEmpty) {
                            return 'Password Must Not Be Empty.';
                          }
                          else if (confirmPassword.text.length < 8 ) {
                            return 'Password Must Be Atleast 8 Characters.';
                          }
                          return null;
                        },
                        onSubmit: (value) {
                          print(confirmPassword.text);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 120,
                    ),
                    Container(
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
                            "Reset",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          onPressed: () {
                            //  cubit.Validate();                  
                          },
                        ))
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
    );
  }
}
