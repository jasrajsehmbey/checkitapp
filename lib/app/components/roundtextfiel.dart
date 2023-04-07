import 'package:flutter/material.dart';

class RoundedField extends StatelessWidget {
  RoundedField(
      {super.key,
      required this.labelText,
      required this.hideText,
      required this.onChange});

  final String labelText;
  final bool hideText;
  dynamic onChange;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChange,
      obscureText: hideText,
      keyboardType: TextInputType.emailAddress,
      cursorColor: const Color(0xFF1CFFAD),
      decoration: InputDecoration(
        label: Text(labelText),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF4CABB2), width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF4CABB2), width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
    );
  }
}
