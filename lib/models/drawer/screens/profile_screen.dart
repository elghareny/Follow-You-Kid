import 'dart:io';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/cubit/cubit.dart';
import 'package:graduation_project/cubit/states.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/components/constants.dart';



class ProfileScreen extends StatelessWidget {
  const ProfileScreen({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectCubit,ProjectStates>(
      listener: (context, state) 
      {
        if(state is EaditDataSuccessState)
                                   {
                                     Navigator.pop(context);
                                     showToast(
                text: 'Update Successful',
                state: ToastStates.SUCCESS);               
                                   }
      },
      builder: (context, state) 
      {

        ProjectCubit profileCubit = ProjectCubit.get(context);

        // ImageSource source;

        // var profileImage = ProjectCubit.get(context).getImage(source);

        var User = ProjectCubit.get(context).User;

       


        ///////////////////////////// choose image ///////////////////////////

  //  File _selectedImage;

  //  Future getImage(ImageSource source)async
  // {
  //   final pickedImage = await ImagePicker().getImage(source: source);
    

  //     try{
  //     if(pickedImage != null)
  //     {
  //       final cropped = await ImageCropper().cropImage(
  //     sourcePath: pickedImage.path,
  //     aspectRatio: CropAspectRatio(ratioX: 1 , ratioY: 1),
  //     compressQuality: 100,
  //     maxWidth: 700,
  //     maxHeight: 700,
  //     androidUiSettings: AndroidUiSettings(
  //       toolbarColor: mainColor,
  //       toolbarTitle: 'Crop',
  //       statusBarColor: mainColor,
  //       backgroundColor: Colors.white
  //     )
  //     );

  // _selectedImage = File(cropped.path);

  //     }
  //     }on PlatformException catch(e)
  //   {
  //     print('Faild to pick image: $e');
  //   }
  // }

  // Future <ImageSource> showImageSource(BuildContext context)async
  // {
  //   if(Platform.isIOS)
  //   {
  //     return showCupertinoModalPopup<ImageSource>(context: context, builder: (context)=>
  //     CupertinoActionSheet(
  //       actions: [
  //         CupertinoActionSheetAction(
  //           child: Text('Camera'),
  //           onPressed: ()=>profileCubit.getImage(ImageSource.camera),
  //         ),
  //         CupertinoActionSheetAction(
  //           child: Text('Gallery'),
  //           onPressed: ()=>profileCubit.getImage(ImageSource.gallery),
  //         ),
  //       ],
  //     )
  //     );
  //   }else{
  //     return showModalBottomSheet(context: context,
  //      builder: (context)=>Column(
  //        mainAxisSize: MainAxisSize.min,
  //        children: [
  //          ListTile(leading: Icon(Icons.camera_alt),
  //          title: Text('Camera'),
  //          onTap: () => profileCubit.getImage(ImageSource.camera),),
  //          ListTile(leading: Icon(Icons.image),
  //          title: Text('Gallery'),
  //          onTap: () => profileCubit.getImage(ImageSource.gallery),),
  //        ],
  //      )
  //      );
  //   }
  // }

  ////////////////////////////////////////////////////////////////////////////////////
  


  var email = TextEditingController();
  var uId = TextEditingController();
  var phone = TextEditingController();
  var fullName = TextEditingController();
  var password = TextEditingController();
  // var childId = TextEditingController();
  var formKey = GlobalKey<FormState>();


   uId.text = User.uId;
   phone.text = User.phone;
   fullName.text = User.name;
  //  childId.text = User.childId;


        return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 270,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [mainColor, secondColor],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(100))),
              child: 
                  Center(
                    child: Stack(
                      children: [ CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 82,
                        child: CircleAvatar(
                          child: profileCubit.selectedImage == null ? Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(80),

                            ),
                            width: 160,
                            height: 160,
                            child: Icon(CupertinoIcons.camera,
                            color: Colors.grey,),
                          ) : Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(80),
                            ),
                            width: 160,
                            height: 160,
                            child: Image.file(profileCubit.selectedImage)
                          ),
                          radius: 80,
                        ),
                      ),
                    Positioned(
                      child: CircleAvatar(
                        child: IconButton(
                          onPressed: () {
                            profileCubit.showImageSource(context);
                          },
                          icon: Icon(
                            Icons.camera_alt,
                            color: mainColor,
                            size: 28,
                          ),
                        ),
                        radius: 23,
                        backgroundColor: Colors.white,
                      ),
                      bottom: 5,
                      right: 12,
                    ),]
              ),
                  ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              height: 600,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    isChild ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.grey[200],
                      ),
                      padding: EdgeInsets.only(left: 10, top: 3, bottom: 3),
                      child: textField(
                        text: 'uId',
                        keyboardType: TextInputType.name,
                        controller: uId,
                        prefixIcon: Icons.perm_contact_calendar_outlined,
                        validate: (value) {
                          if (fullName.text.isEmpty) {
                            return 'Name Must not be Empty';
                          }
                          return null;
                        },
                        onSubmit: (value) {
                          print(email.text);
                        },
                      ),
                    ) : Text('User Id : "${User.uId}"',style: TextStyle(fontSize: 23),),
                    SizedBox(height: 20,),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.grey[200],
                      ),
                      padding: EdgeInsets.only(left: 10, top: 3, bottom: 3),
                      child: textField(
                        text: 'Name',
                        keyboardType: TextInputType.name,
                        controller: fullName,
                        prefixIcon: Icons.person,
                        validate: (value) {
                          if (fullName.text.isEmpty) {
                            return 'Name Must not be Empty';
                          }
                          return null;
                        },
                        onSubmit: (value) {
                          print(email.text);
                        },
                      ),
                    ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.all(Radius.circular(20)),
                    //     color: Colors.grey[200],
                    //   ),
                    //   padding: EdgeInsets.only(left: 10, top: 3, bottom: 3),
                    //   child: textField(
                    //     text: 'Email',
                    //     keyboardType: TextInputType.emailAddress,
                    //     controller: email,
                    //     prefixIcon: Icons.email,
                    //     validate: (value) {
                    //       if (email.text.isEmpty) {
                    //         return 'Email Must not be Empty';
                    //       }
                    //       return null;
                    //     },
                    //     onSubmit: (value) {
                    //       print(email.text);
                    //     },
                    //   ),
                    // ),
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
                        text: 'Phone',
                        keyboardType: TextInputType.number,
                        controller: phone,
                        prefixIcon: Icons.phone,
                        validate: (value) {
                          if (phone.text.isEmpty) {
                            return 'Phone Must not be Empty';
                          }
                          return null;
                        },
                        onSubmit: (value) {
                          print(phone.text);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // isChild ? null : Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.all(Radius.circular(20)),
                    //     color: Colors.grey[200],
                    //   ),
                    //   padding: EdgeInsets.only(left: 10, top: 3, bottom: 3),
                    //   child: textField(
                    //     text: 'Child Id',
                    //     controller: childId,
                    //     prefixIcon: Icons.child_care,
                    //     textInputAction: TextInputAction.go,
                    //     validate: (value) {
                    //       if (childId.text.isEmpty) {
                    //         return 'Child Id Must not be Empty';
                    //       }
                    //       return null;
                    //     },
                    //     onSubmit: (value) {
                    //       print(childId.text);
                    //     },
                    //   ),
                    // ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.all(Radius.circular(20)),
                    //     color: Colors.grey[200],
                    //   ),
                    //   padding: EdgeInsets.only(left: 10, top: 3, bottom: 3),
                    //   child: textField(
                    //     isDefaultPassword: true,
                    //     text: 'Password',
                    //     keyboardType: TextInputType.visiblePassword,
                    //     controller: password,
                    //     prefixIcon: Icons.vpn_key,
                    //     suffixIcon: profileCubit.suffix,
                    //     isPassword: profileCubit.isPassword,
                    //     textInputAction: TextInputAction.go,
                    //     suffixPressed: () {
                    //       profileCubit.changePasswordVisibilty();
                    //     },
                    //     validate: (value) {
                    //       if (password.text.isEmpty) {
                    //         return 'Password Must Not Be Empty.';
                    //       }
                    //       else if (password.text.length < 8 ) {
                    //         return 'Password Must Be Atleast 8 Characters.';
                    //       }
                    //       return null;
                    //     },
                    //     onSubmit: (value) {
                    //       print(password.text);
                    //     },
                    //   ),
                    // ),
                    SizedBox(
                      height: 50,
                    ),
                    ConditionalBuilder(
                      condition: state is ! EaditDataLoadingState,
                      builder:(context)=> Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 50,
                              width: 200,
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
                                  "Update",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                onPressed: () {

                                  if (formKey.currentState.validate())
                                 {
                                   profileCubit.updateUser(
                                     name: fullName.text,
                                     phone: phone.text,
                                    //  childId: childId.text,
                                   );

                                   if(state is EaditDataSuccessState)
                                   {
                                     Navigator.pop(context);
                                   }                                   
                                  }

                                },
                              )),
                    
                              SizedBox(
                                width: 20.0,
                              ),
                    
                              Container(
                              height: 50,
                              width: 200,
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
                                  "Cancel",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                onPressed: () 
                                {
                                  Navigator.pop(context);
                                },
                              )),
                        ],
                      ),
                      fallback: (context)=> Center(child: CircularProgressIndicator()),
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
    );
  }
}