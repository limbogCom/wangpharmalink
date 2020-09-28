import 'package:flutter/material.dart';
import 'package:flutter_demo/button/text_field_container.dart';
import 'package:flutter_demo/constants.dart';

class RoundedPasswordField extends StatelessWidget{
  final ValueChanged<String> onChange;
  const RoundedPasswordField({
    Key key,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChange,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(Icons.visibility,color: kPrimaryColor,
          ),   //eye
          border: InputBorder.none,
        ),
      ),
    );
  }
}



