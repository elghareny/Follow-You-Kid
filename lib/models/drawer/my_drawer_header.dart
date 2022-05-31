import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/cubit/cubit.dart';
import 'package:graduation_project/cubit/states.dart';
import 'package:graduation_project/models/connent_to_child.dart';
import 'package:graduation_project/models/drawer/screens/profile_screen%20copy.dart';
import 'package:graduation_project/models/drawer/screens/profile_screen.dart';
import 'package:graduation_project/modules/login/select_user.dart';
import 'package:graduation_project/modules/on_boarding.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/components/constants.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';


class MyDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectCubit,ProjectStates>(
      listener: (context,state)
      {
        if(state is LogoutSuccessState)
              {
                CacheHelper.removeData(
                key : 'uId',
              ).then((value)
              {
                navigateAndFinis(context, SelectUser());
              });
              }
      }, 
      builder: (context,state)
      {
        ProjectCubit drawerCubit = ProjectCubit.get(context);

        var User = ProjectCubit.get(context).User;

        var Parent = ProjectCubit.get(context).Parent;
    
        return SizedBox(
    width: MediaQuery.of(context).size.width*.7,
    child: Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: mainColor,
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      width: 80.0,
                      height: 80.0,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/profile.jpg'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("${isChild ? User.name :Parent.name}",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white
                  ),),
                  SizedBox(
                    height: 3.0,
                  ),
                  Text("${isChild ? User.email :Parent.email}",
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey[300]
                  ),),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Profile"),
            onTap: () {
              if(isChild)
              {
                navigateTo(context, ProfileScreen());
              }else
              {
                navigateTo(context, ParentProfileScreen());
              }
              
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: () 
            {
              toAdded =true;
              navigateTo(context, ConnentToChild());
            },
          ),
          Divider(
            color: Colors.grey,
            height: 4.0,
            indent: 20.0,
            endIndent: 20.0,
            thickness: 1.0,
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Logout"),
            onTap: ()
            {
              drawerCubit.logout();
              if(state is LogoutSuccessState)
              {
                CacheHelper.removeData(
                key : 'uId',
              ).then((value)
              {
                navigateAndFinis(context, SelectUser());

                showToast(
                text: 'Logout Successful',
                state: ToastStates.SUCCESS);
              });
              }
              
            },
          )
        ],
      ),
    ),
    );
    
      }
      );
    
  }
}

































// import 'package:flutter/material.dart';

// class MyHeaderDrawer extends StatefulWidget {

//   @override
//   _MyHeaderDrawerState createState() => _MyHeaderDrawerState();
// }

// class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.green[700],
//       width: double.infinity,
//       height: 200,
//       padding: EdgeInsets.only(top: 20),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CircleAvatar(
//               radius: 48,
//               backgroundColor: Colors.white,
//               child: CircleAvatar(
//                 backgroundImage: AssetImage('assets/images/profile.jpg'),      
//                 radius: 45,     
//                 ),
//             ),
//           // Container(
//           //   margin: EdgeInsets.only(bottom: 10),
//           //   height: 70,
//           //   decoration: BoxDecoration(
//           //     shape: BoxShape.circle,
//           //     image: DecorationImage(
//           //       image: AssetImage('assets/images/profile.jpg')
//           //     ),
//           //   ),
//           // ),
//           Text('Mohamed Said',
//           style: TextStyle(
//             fontSize: 20,
//             color: Colors.white,
//           ),)
//         ],
//       ),
//     );
//   }
// }