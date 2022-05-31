import 'dart:ui';

import 'package:graduation_project/shared/components/constants.dart';

import 'chat_screen.dart';
import 'package:flutter/material.dart';

class HomeChatScreen extends StatefulWidget {
  const HomeChatScreen({ Key key }) : super(key: key);

  @override
  _HomeChatScreenState createState() => _HomeChatScreenState();
}

class _HomeChatScreenState extends State<HomeChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Recent Chat',
            style: TextStyle(
              color: mainColor,
              fontSize: 30.0,
              fontWeight: FontWeight.w400,
            ),),
            SizedBox(height: 10.0,),
            Expanded(
              child: ListView.separated(
                itemCount: 20,
                separatorBuilder: (context, index)
                 { 
                   return Divider(
              color: Colors.grey,
              height: 4.0,
              indent: 10.0,
              endIndent: 10.0,
              thickness: 1.0,
            );
                 },
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const ChatScreen()));
                    },
                    horizontalTitleGap: 3.0,
                    contentPadding: EdgeInsets.symmetric(horizontal: 0.0,vertical: 8.0),
                    leading: CircleAvatar(backgroundImage: AssetImage('assets/images/profile.jpg'),
                    radius: 38.0,),
                    title: Text('Mohamed Said',
                    style: TextStyle(
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                    ),),
                    subtitle: Text('How are you Mohamed ?',
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontWeight: FontWeight.normal,
                    ),),
                  );
                },
              ))
          ],
        ),
      ),
    );
  }
}