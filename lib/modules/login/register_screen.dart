import 'package:flutter/material.dart';
import 'package:graduation_project/modules/login/child/register_child_screen.dart';
import 'package:graduation_project/modules/login/parent/register_parent_screen.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/components/constants.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  @override
  Widget build(BuildContext context) {
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
                          setState(() {
                            navigateTo(context, ParentRegister());
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
                          setState(() {
                            navigateTo(context, ChildRegister());
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
                        color: Colors.deepOrangeAccent),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
