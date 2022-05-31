import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduation_project/buttom.dart';
import 'package:graduation_project/cubit/cubit.dart';
import 'package:graduation_project/cubit/states.dart';
import 'package:graduation_project/layout/parent_home_layout.dart';
import 'package:graduation_project/layout/home_layout.dart';
import 'package:graduation_project/models/Verified.dart';
import 'package:graduation_project/modules/log/login.dart';
import 'package:graduation_project/modules/login/select_user.dart';
import 'package:graduation_project/modules/login/signin.dart';
import 'package:graduation_project/modules/login/splash_screen.dart';
import 'package:graduation_project/modules/on_boarding.dart';
import 'package:graduation_project/shared/components/constants.dart';
import 'package:graduation_project/shared/cubit/cubit.dart';
import 'package:graduation_project/shared/cubit/states.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await CacheHelper.init();

  Widget widget;
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');

  uId = CacheHelper.getData(key: 'uId');

  isChild = CacheHelper.getData(key: 'who');

  // circled = CacheHelper.getData(key: 'circled');

  if(onBoarding != null){
  if(isChild){
  if(uId != null)
  {
    widget =HomeLayout();
  }else
  {
    widget = SelectUser();
  }}else{
    if(uId != null)
  {
    widget =ParentHomeLayout();
  }else
  {
    widget = SelectUser();
  }
  }
  }else
  {
    widget = OnBoarding();
  }
  
  
  runApp( MyApp(widget,));
}

class MyApp extends StatelessWidget {

  final Widget startWidget;
  


   const MyApp(this.startWidget,);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>ProjectCubit()..getUserData()..getParentData()..getHome(),
      child: BlocConsumer<ProjectCubit,ProjectStates>(
        listener: (context, state) { },
        builder: (context,state)
        {
          
          return MaterialApp(
        title: 'Follow Your Kid',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: const TextTheme(
            bodyText1: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
              color: Colors.black
            ),
          ),
          appBarTheme: AppBarTheme(
            backwardsCompatibility: false,
            backgroundColor: mainColor,
            elevation: 0.0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light
            ),
      
          ),
          primarySwatch: Colors.deepPurple,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: mainColor,
          )
        ),
        themeMode:ThemeMode.light,
      
        home: startWidget);
        },
    ),
    );
      }
}