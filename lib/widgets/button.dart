// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool isLoading;

  const Button(
      {Key? key,
      required this.title,
      required this.onPressed,
      required this.backgroundColor,
      required this.foregroundColor,
      required this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            fixedSize: Size(size.width * 0.8, 60),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        child: isLoading == true
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : Text(title,
                style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'Gordita',
                    fontWeight: FontWeight.w500)));
  }
}
