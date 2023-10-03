import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final String? hintText;
  final Image? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final Function()? onTap;

  const TextInput(
      {Key? key,
      this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText = false,
      this.controller,
      this.keyboardType,
      this.onChanged,
      this.onTap})
      : super(key: key);

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextFormField(
        maxLines: widget.hintText == 'Description' ? 5 : 1,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        onChanged: widget.onChanged,
        onTap: widget.onTap,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Color(0xFFE4DEDE),
              width: 0.5,
            ),
          ),
          prefixIcon: widget.prefixIcon,
          suffixIcon: Icon(widget.suffixIcon),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: Color(0xFFB3B1B1),
            fontSize: 15,
            fontFamily: 'Airbnb Cereal App',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
