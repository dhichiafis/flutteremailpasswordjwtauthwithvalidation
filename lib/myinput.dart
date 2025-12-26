import 'package:flutter/material.dart';

class MyInput extends StatelessWidget {
  final TextEditingController mycontroller;
  final bool obsecureText;
  final String? Function(String?) validate;
  final String labelText;
  final IconData icon;
  
  const MyInput({super.key,
  required this.icon,
  required this.labelText
  ,required this.validate,
  required this.mycontroller,
  required this.obsecureText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      controller:mycontroller,
      obscureText: obsecureText,
      validator:validate,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.black
          ),
          borderRadius: BorderRadius.circular(16)
        ),
        labelText: labelText,
        suffix: Icon(icon)
      ),
    );
  }
}