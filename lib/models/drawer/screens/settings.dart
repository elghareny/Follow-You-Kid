import 'package:flutter/material.dart';

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Settings",
        style: TextStyle(
          fontSize: 40.0,
          fontWeight: FontWeight.bold
        ),),
      ),
    );
  }
}