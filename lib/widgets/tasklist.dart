// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../app/constants/baseurl.dart';
import '../app/routes.dart';
import '../core/notifiers.dart';
import 'tasktile.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class TaskList extends StatefulWidget {
  const TaskList({required this.uid});
  final String uid;
  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ToDoItems>(context, listen: false).getListDetail(widget.uid);
    });
    super.initState();
  }

  void _reloadPage() {
    setState(() {
      // empty setState body triggers a rebuild
      Provider.of<ToDoItems>(context, listen: false).getListDetail(widget.uid);
    });
  }

  Future<int> removeItem(String note) async {
    var url = "${baseURL}/delete/${widget.uid}";
    final http.Response response = await http.delete(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'note': note,
      }),
    );
    int code = response.statusCode;
    return code;
  }

  Future<int> updateItem(String note) async {
    var url = "${baseURL}/update/${widget.uid}";
    final http.Response response = await http.patch(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'note': note,
      }),
    );
    int code = response.statusCode;
    return code;
  }

  bool loader = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ToDoItems>(
      builder: (context, value, child) {
        final list = value.data;
        return !loader
            ? ListView.builder(
                itemBuilder: (context, index) {
                  final task = list[index];
                  return TaskTile(
                    text: task.note,
                    isChecked: task.isChecked == 1 ? true : false,
                    onLongPress: () async {
                      setState(() {
                        loader = true;
                      });
                      int success = await removeItem(task.note);
                      setState(() {
                        loader = false;
                      });
                      if (success == 200) {
                        print("removed");
                        _reloadPage();
                      }
                      // taskData.removeTask(task);
                    },
                    onChanged: (bool? newValue) async {
                      setState(() {
                        loader = true;
                      });
                      int success = await updateItem(task.note);
                      setState(() {
                        loader = false;
                      });
                      if (success == 200) {
                        print("changed");
                        _reloadPage();
                      }
                      // taskData.updateTask(task);
                    },
                  );
                },
                itemCount: list.length,
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
