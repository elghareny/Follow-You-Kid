import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/cubit/cubit.dart';
import 'package:graduation_project/cubit/states.dart';
import 'package:graduation_project/models/connent_to_child.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/components/constants.dart';

class ParentStart extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectCubit,ProjectStates>(
      listener: (context, state) { },
      builder: (context, state) 
      {

        ProjectCubit cubit = ProjectCubit.get(context);

        return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                      onPressed: () {
                        navigateTo(context,ConnentToChild());
                      },
                      child: Text('Show Your Child Location',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400
                        ),
                      
                      )),
                      TextButton(
                      onPressed: () {
                        navigateTo(context,ConnentToChild());
                        toAdded = true;
                      },
                      child: Text('Add Safe Zone',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400
                        ),
                      
                      )),
                      TextButton(
                      onPressed: () {
                        navigateTo(context,ConnentToChild());
                        
                      },
                      child: Text('Edit The Distance',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400
                        ),
                      
                      )),
                      // Slider(
                      //   value: cubit.radius,
                      //   min: 0,
                      //   max: 10000,
                      //   divisions: 5000,
                      //   label: cubit.radius.round().toString(),
                      //    onChanged: (v){
                      //      cubit.changeSlider(v);
                      //    })
              ],
            ),
          ),
        ),
      );
       },
    );
  }
}