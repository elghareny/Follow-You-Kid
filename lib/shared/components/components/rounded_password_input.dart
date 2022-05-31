import 'package:flutter/material.dart';
import 'package:graduation_project/shared/components/components/input_container.dart';
import 'package:graduation_project/shared/components/constants.dart';


class RoundedPasswordInput extends StatelessWidget {
  const RoundedPasswordInput({
    Key key,
     this.hint
  }) : super(key: key);

  final String hint;

  @override
  Widget build(BuildContext context) {
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
}