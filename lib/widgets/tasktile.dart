// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String text;
  final ValueChanged<bool?>? onChanged;
  final GestureLongPressCallback? onLongPress;
  TaskTile(
      {required this.text,
      required this.isChecked,
      required this.onChanged,
      required this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: onLongPress,
      title: Text(
        text,
        style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null),
      ),
      trailing: Checkbox(
        activeColor: Colors.yellow.shade800,
        value: isChecked,
        onChanged: onChanged,
      ),
    );
  }
}
