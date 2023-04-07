// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../app/constants/baseurl.dart';

class AddTask extends StatelessWidget {
  const AddTask({super.key, required this.uid});
  final String uid;

  Future<int> AddtoList(String note) async {
    var url = "${baseURL}/insert/$uid";
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
