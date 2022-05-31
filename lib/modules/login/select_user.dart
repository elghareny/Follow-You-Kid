import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/login/child/login_child_screen.dart';
import 'package:graduation_project/modules/login/parent/login_parent_screen.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/components/constants.dart';
import 'package:graduation_project/shared/cubit/cubit.dart';
import 'package:graduation_project/shared/cubit/states.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';


class SelectUser extends StatelessWidget {
  const SelectUser({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {
          
        },
        builder: (context,stata)
        {
    
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 500,
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
                height: 100.0,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [mainColor, secondColor],
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(100))),
                        child: TextButton(
                          child: Text(
                            "Parent",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          onPressed: () {
                            
                            isChild =false;
                              
                              CacheHelper.saveData(
                               key : 'who',
                                 value : isChild=false,
                                 ).then((value) {
                                   navigateTo(context, ParentLogin());
                                 });
                            
                          },
                        )),
                    SizedBox(
                      height: 50.0,
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
                            borderRadius: BorderRadius.all(Radius.circular(100))),
                        child: TextButton(
                          child: Text(
                            "Child",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          onPressed: () {
                            
                            isChild = true;
                            CacheHelper.saveData(
                               key : 'who',
                                 value : isChild=true,
                                 ).then((value){
                                   navigateTo(context, ChildLogin());
                                 });
                           
                          },
                        )),
                    SizedBox(
                      height: 50.0,
                    ),
                    Text(
                      "Choose Who Will Make Account...?",
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w400,
                          color: mainColor),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
        },
      ),
    );
  }
}
