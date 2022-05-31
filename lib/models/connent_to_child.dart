import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/cubit/cubit.dart';
import 'package:graduation_project/cubit/states.dart';
import 'package:graduation_project/layout/home_layout.dart';
import 'package:graduation_project/models/maps/my_maps.dart';
import 'package:graduation_project/models/user_model.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/components/constants.dart';
import 'package:graduation_project/shared/cubit/states.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';

class ConnentToChild extends StatelessWidget {

 var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectCubit, ProjectStates>(
      listener: (context, ProjectStates state) {
        
      },
      builder: (context,  state) {

        ProjectCubit connectCubit = ProjectCubit.get(context);
    
    
        var Parent = ProjectCubit.get(context).Parent;
    
        cId = Parent.childId;
    
        var childId = TextEditingController();
        var formKey = GlobalKey<FormState>();
    
        return Scaffold(
          key: scaffoldKey ,
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(0.0),
            child: StreamBuilder(
              stream:
                  child.doc(cId).collection('location').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

    
                return MyMap(snapshot.data.docs[0].id);
    
                // return ListView.builder(
                //     itemCount: snapshot.data.docs.length,
                //     itemBuilder: (context, index) {
                //       return ListTile(
                //         title:
                //             Text(snapshot.data.docs[index]['name'].toString()),
                //         subtitle: Row(
                //           children: [
                //             Text(snapshot.data.docs[index]['latitude']
                //                 .toString()),
                //             SizedBox(
                //               width: 20,
                //             ),
                //             Text(snapshot.data.docs[index]['longitude']
                //                 .toString()),
                //           ],
                //         ),
                //         trailing: IconButton(
                //           icon: Icon(Icons.directions),
                //           onPressed: () {
                //             Navigator.of(context).push(MaterialPageRoute(
                //                 builder: (context) =>
                //                     MyMap(snapshot.data.docs[index].id)));
                //           },
                //         ),
                //       );
                //     });
              },
            ),
          ),
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
            floatingActionButton: FloatingActionButton(
              child: Icon(connectCubit.sheetIcon),
              onPressed: ()
              {
                if(connectCubit.isBottomSheetShown)
                {
                  toAdded = true;
                  connectCubit.changeBottomSheetState(isShow: false, icon: Icons.edit);
                  Navigator.pop(context);
                  toAdded = false;
                }else{
                  scaffoldKey.currentState.showBottomSheet(
                        (context)=>Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft:Radius.circular(10.0) ,
                            bottomLeft: Radius.zero,
                            bottomRight: Radius.zero,
                            topRight: Radius.circular(10.0)
                        ),
                        border: Border.all(
                            color: Colors.grey
                        ),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(20.0),

                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: 
                        [
                          Slider(
                      value: connectCubit.radius,
                      min: 0,
                      max: 10000,
                      divisions: 5000,
                      label: connectCubit.radius.round().toString(),
                       onChanged: (v){
                         connectCubit.changeSlider(v);
                       })
                        ],
                      ),
                    ),
                    elevation: 50.0,
                  ).closed.then((value)
                  {
                    connectCubit.changeBottomSheetState(isShow: false, icon: Icons.edit);
                  });
                  connectCubit.changeBottomSheetState(isShow: true, icon: Icons.done);
                  toAdded = true;
                }

              },
            ),
        );
      },
    );
  }
}
