import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/cubit/cubit.dart';
import 'package:graduation_project/cubit/states.dart';
import 'package:graduation_project/models/drawer/my_drawer_header.dart';
import 'package:graduation_project/shared/components/constants.dart';



class HomeLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectCubit,ProjectStates>(
      listener: (BuildContext context , ProjectStates state){},
      builder: (BuildContext context , ProjectStates state) {
    
        ProjectCubit cubit = ProjectCubit.get(context);

        return Scaffold(
        appBar: AppBar(
          title: Text("Follow Your Kid",
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.w400,
          ),
          ),
        ),
        drawer: MyDrawer(),
        body: cubit.childScreens[cubit.currentIndex],
    
    
        bottomNavigationBar: BottomNavigationBar(
          elevation: 100,
          selectedFontSize: 15,
          currentIndex: cubit.currentIndex,
          selectedItemColor: mainColor,
          iconSize: 20,
          onTap: (index){
            cubit.changeIndex(index);
          },
          items:[
            BottomNavigationBarItem(
              icon: Icon(Icons.home,size: 30,),
              label: "Home",
              ),
              BottomNavigationBarItem(
              icon: Icon(Icons.message,size: 30,),
              label: "Chat"
              ),
          ],
        )
    
        // bottomNavigationBar: BottomNavyBar(
        //   showElevation: true,
        //   iconSize: 20,
        //   selectedIndex: cubit.currentIndex,
        //   onItemSelected: (index){
        //     cubit.changeIndex(index);
        //   },
        //   items:[
        //     BottomNavyBarItem(
        //       icon: Icon(Icons.home),
        //       title: Text("Home"),inactiveColor: Colors.grey
        //       ),
        //       BottomNavyBarItem(
        //       icon: Icon(Icons.message),
        //       title: Text("Message"),inactiveColor: Colors.grey
        //       ),
        //       // BottomNavyBarItem(
        //       // icon: Icon(Icons.circle_notifications),
        //       // title: Text("Notifications"),inactiveColor: Colors.grey
        //       // ),
        //   ],
        // ),
      );
      },
    );
  }
}