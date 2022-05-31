import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/shared/components/constants.dart';

Widget CancelButton(
  {
  final bool isLogin,
  final Duration animationDuration,
  final Size size,
  final AnimationController animationController,
  final GestureTapCallback tapEvent,
  }
)
{
  return AnimatedOpacity(
      opacity: isLogin ? 0.0 : 1.0,
      duration: animationDuration,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: size.width,
          height: size.height * 0.1,
          alignment: Alignment.bottomCenter,

          child: IconButton(
            icon: Icon(Icons.close),
            onPressed: tapEvent,
            color: kPrimaryColor,
          ),
        ),
      ),
    );
}



////////////////////////////////////////////////////////


Widget InputContainer(
  {
    final Widget child,
    Size size,
  }
)
{
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: kPrimaryColor.withAlpha(50)
      ),

      child: child
    );
}



////////////////////////////////////////////////////////


Widget LoginForm(
  {
    final bool isLogin,
  final Duration animationDuration,
  final Size size,
  final double defaultLoginSize,
  }
)
{
  return AnimatedOpacity(
      opacity: isLogin ? 1.0 : 0.0,
      duration: animationDuration * 4,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: size.width,
          height: defaultLoginSize,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                  ),
                ),

                SizedBox(height: 40),

                SvgPicture.asset('assets/images/login.svg'),

                SizedBox(height: 40),

                RoundedInput(icon: Icons.mail, hint: 'Username'),

                RoundedPasswordInput(hint: 'Password'),

                SizedBox(height: 10),

                RoundedButton(title: 'LOGIN'),

                SizedBox(height: 10),

              ],
            ),
          ),
        ),
      ),
    );
}



////////////////////////////////////////////////////////


Widget RegisterForm(
  {
final bool isLogin,
  final Duration animationDuration,
  final Size size,
  final double defaultLoginSize,
  }
)
{
return AnimatedOpacity(
      opacity: isLogin ? 0.0 : 1.0,
      duration: animationDuration * 5,
      child: Visibility(
        visible: !isLogin,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: size.width,
            height: defaultLoginSize,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  SizedBox(height: 10),

                  Text(
                    'Welcome',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24
                    ),
                  ),

                  SizedBox(height: 40),

                  SvgPicture.asset('assets/images/register.svg'),

                  SizedBox(height: 40),

                  RoundedInput(icon: Icons.mail, hint: 'Username'),

                  RoundedInput(icon: Icons.face_rounded, hint: 'Name'),

                  RoundedPasswordInput(hint: 'Password'),

                  SizedBox(height: 10),

                  RoundedButton(title: 'SIGN UP'),

                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
}



////////////////////////////////////////////////////////


Widget RoundedButton(
  {
    final String title,
    Size size,
  }
)
{
  return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: kPrimaryColor,
        ),

        padding: EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18
          ),
        ),
      ),
    );
}



////////////////////////////////////////////////////////


Widget RoundedInput(
  {
    final IconData icon,
  final String hint,
  }
)
{
  return InputContainer(
      child: TextField(
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(icon, color: kPrimaryColor),
          hintText: hint,
          border: InputBorder.none
        ),
      ));
}



////////////////////////////////////////////////////////


Widget RoundedPasswordInput(
  {
    final String hint,
  }
)
{
  return InputContainer(
      child: TextField(
        cursorColor: kPrimaryColor,
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock, color: kPrimaryColor),
          hintText: hint,
          border: InputBorder.none
        ),
      ));
}



////////////////////////////////////////////////////////


