import 'package:flutter/material.dart';
import 'package:graduation_project/shared/components/components/input_container.dart';
import 'package:graduation_project/shared/components/constants.dart';

class RoundedInput extends StatelessWidget {
  const RoundedInput({
    Key key,
     this.icon,
     this.hint
  }) : super(key: key);

  final IconData icon;
  final String hint;

  @override
  Widget build(BuildContext context) {
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
}