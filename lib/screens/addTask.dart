// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '../app/constants/baseurl.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key, required this.uid});
  final String uid;

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  Future<int> AddtoList(String note) async {
    var url = "${baseURL}/insert/${widget.uid}";
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'note': note,
        'isChecked': 0,
      }),
    );
    int code = response.statusCode;
    return code;
  }

  String convert24To12HourFormat(String time24) {
    final format = DateFormat.jm();
    final DateTime dateTime = DateTime.parse('2022-01-01 $time24');
    return format.format(dateTime);
  }

  // TextEditingController timeInput = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String message = '';

    return Container(
      color: Color(
          0xff757575), //to match the left out curved part as same color that of background
      child: Container(
        padding: EdgeInsets.all(40.00),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.00),
            topRight: Radius.circular(40.00),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'Add Task',
                style: TextStyle(
                  color: Colors.yellow.shade800,
                  fontSize: 30.00,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              children: [
                TextField(
                  autofocus: true, //automatically opens up keyboard
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Write task...',
                    hintStyle: TextStyle(
                      color: Colors.black45,
                    ),
                  ),
                  onChanged: (value) {
                    message = value;
                  },
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 15, right: 180),
                //   child: TextFormField(
                //     controller: timeInput,
                //     style: TextStyle(
                //       color: Colors.black,
                //     ),
                //     decoration: InputDecoration(
                //       icon: Icon(
                //         Icons.access_time_filled,
                //         color: Colors.yellow[800],
                //       ),
                //       labelText: "Time",
                //       labelStyle: TextStyle(
                //         color: Colors.black38,
                //         fontSize: 15,
                //       ),
                //       enabledBorder: UnderlineInputBorder(
                //         borderSide: BorderSide(
                //           width: 0.9,
                //           color: Colors.black38,
                //         ),
                //       ),
                //       focusedBorder: UnderlineInputBorder(
                //         borderSide: BorderSide(
                //           width: 0.9,
                //           color: Colors.brown,
                //         ),
                //       ),
                //     ),
                //     readOnly: true,
                //     onTap: () async {
                //       TimeOfDay? pickedTime = await showTimePicker(
                //         context: context,
                //         initialTime: TimeOfDay.now(),
                //         builder: (context, child) {
                //           return Theme(
                //             data: Theme.of(context).copyWith(
                //               colorScheme: ColorScheme.light(
                //                 primary: Colors.yellow.shade800,
                //                 onPrimary: Colors.white,
                //                 onSurface: Colors.black,
                //               ),
                //               textButtonTheme: TextButtonThemeData(
                //                 style: TextButton.styleFrom(
                //                   primary: Colors.black54,
                //                 ),
                //               ),
                //             ),
                //             child: child!,
                //           );
                //         },
                //       );
                //       DateTime parsedTime;
                //       if (pickedTime != null) {
                //         parsedTime = DateFormat.jm()
                //             .parse(pickedTime.format(context).toString());
                //         String formattedTime =
                //             DateFormat('HH:mm').format(parsedTime);
                //         String newTime = convert24To12HourFormat(formattedTime);
                //         setState(() {
                //           timeInput.text = newTime;
                //         });
                //         var startTime = DateTime(
                //             DateTime.now().year,
                //             DateTime.now().month,
                //             DateTime.now().day,
                //             parsedTime.hour,
                //             parsedTime.minute);
                //         var endTime = DateTime.now();
                //         var diff = endTime.difference(startTime);
                //         log(diff.toString());
                //       }
                //     },
                //   ),
                // ),
              ],
            ),
            SizedBox(
              height: 30.00,
            ),
            MaterialButton(
              onPressed: () async {
                int success = await AddtoList(message);
                if (success == 200) {
                  print("added");
                  Navigator.of(context).pop();
                }
              },
              child: Container(
                width: double.infinity,
                height: 50.00,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30.00)),
                  color: Colors.yellow.shade800,
                ),
                child: Center(
                  child: Text(
                    'ADD',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
