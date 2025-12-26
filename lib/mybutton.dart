import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key,required this.text,required this.onPress,required this.width,required this.height});
  final void Function() onPress;
  final double width;
  final double height;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(  
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: 1,color: Colors.black
          )
        ),
        height: height,
        width: width,
        child: Center(child: Text(text)),
      ),
    );
  }
}