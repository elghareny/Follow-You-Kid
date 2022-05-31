// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:conditional_builder/conditional_builder.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:graduation_project/cubit/cubit.dart';
// import 'package:graduation_project/cubit/states.dart';
// import 'package:graduation_project/layout/home_layout.dart';
// import 'package:graduation_project/shared/components/components.dart';
// import 'package:graduation_project/shared/components/constants.dart';
// import 'package:graduation_project/shared/cubit/cubit.dart';
// import 'package:graduation_project/shared/cubit/states.dart';

// class Verified extends StatelessWidget {
//   const Verified({ Key key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ProjectCubit,ProjectStates>(
//       listener: (context, state) 
//       {
//         if(state is VerifiedSuccessState)
//                                  {
                                   
//                                    navigateAndFinis(context, HomeLayout());
//                                    showToast(
//                                 text: 'Verified Successful',
//                                  state: ToastStates.SUCCESS);
//                                  }
//       },
//       builder: (context,state)
//       {
//         return Scaffold(
//           backgroundColor: Colors.white,
//           appBar: AppBar(
//             backgroundColor: Colors.white,
//             title: Text('Verified',
//             style: TextStyle(
//               color: mainColor,
//               fontSize: 30
//             ),),
//           ),
//           body: ConditionalBuilder(
//             condition: ProjectCubit.get(context).User != null,
//             builder: (context)
//             {

//               ProjectCubit verifiedCubit =ProjectCubit.get(context);

//               var User = ProjectCubit.get(context).User;


//               return Column(
//               children: [

//                 if(!User.isEmailVerified )
//                 Container(
//                   color: Colors.amber.withOpacity(.7),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                     child: Row(
//                       children: [
//                         Icon(Icons.info_outline),
//                          SizedBox(
//                           width: 15.0,
//                         ),
//                         Expanded(child: Text('Please Verify Your Email',
//                         style: TextStyle(
//                         fontSize: 20
//                          ),
//                          )),
//                         SizedBox(
//                           width: 15.0,
//                         ),
//                         TextButton(
//                           onPressed: ()
//                           {
//                             verifiedCubit.verified();

//                             if(FirebaseAuth.instance.currentUser.emailVerified)
//     {
//       User.isEmailVerified = true;
//       FirebaseFirestore.instance
//   .collection('child')
//   .doc(uId)
//   .set(User.toMap());
  
//   navigateAndFinis(context, HomeLayout());
//                                    showToast(
//                                 text: 'Verified Successful',
//                                  state: ToastStates.SUCCESS);
//     }
                            
//                             // .then((value)
//                             // {
//                             //   showToast(
//                             //     text: 'Check your mail',
//                             //      state: ToastStates.SUCCESS);
//                             //      if(FirebaseAuth.instance.currentUser.emailVerified)
//                             //      {
//                             //        showToast(
//                             //     text: 'Verified Successful',
//                             //      state: ToastStates.SUCCESS);
//                             //        navigateAndFinis(context, HomeLayout());
//                             //        childModel.isEmailVerified=true;
//                             //         parentModel.isEmailVerified=true;
//                             //      }
//                             // })
//                             // .catchError(((error)
//                             // {
//                             //   print(error.toString());
//                             // }));
//                           },
//                            child: Text('SEND',
//                            style: TextStyle(
//                              fontSize: 20
//                            ),))
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             );
//             },
//             fallback: (context)=> Center(child: CircularProgressIndicator()),
//           ),
//         );
//       },
      
//     );
//   }
// }