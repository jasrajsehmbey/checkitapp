// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last
import 'package:checkit/screens/product_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/constants/baseurl.dart';
import '../core/notifiers.dart';
import '../widgets/tasklist.dart';
import 'addTask.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  String? uid;
  bool loader = false;
  bool action = false;

  Future<void> createdatabase(String uid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    action = prefs.getBool('createdatabase')!;
    if (action == true) {
      try {
        print("im in");
        http.Response response = await http.get(Uri.parse('${baseURL}/$uid'));
        int code = response.statusCode;
        print(code);
        print(response.body);
        if (code == 200) {
          print("${uid} table created successfully");
          prefs.setBool('createdatabase', false);
          print("gone false");
        } else if (code == 404) {
          prefs.setBool('createdatabase', false);
          print("404 error");
        }
      } catch (e) {
        print(e);
        prefs.setBool('createdatabase', false);
      }
    }
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    uid = FirebaseAuth.instance.currentUser!.uid;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loader = true;
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ToDoItems>(context, listen: false)
          .getListDetail(uid!)
          .whenComplete(() => loader = false);
    });
    setState(() {
      loader = true;
    });
    await prefs.setString('id', uid!);
    await createdatabase(uid!);
    setState(() {
      loader = false;
    });
    super.didChangeDependencies();
  }

  Future<int> deleteall() async {
    var url = "${baseURL}/deleteall/$uid";
    final http.Response response = await http.delete(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    int code = response.statusCode;
    return code;
  }

  void _reloadPage() {
    setState(() {
      // empty setState body triggers a rebuild
      Provider.of<ToDoItems>(context, listen: false).getListDetail(uid!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade800,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddTask(
                  uid: uid!,
                ),
              ),
            ),
          );
        },
        backgroundColor: Colors.yellow.shade800,
        child: Icon(Icons.add),
      ),
      body: !loader
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: 30.00, right: 30.00, top: 60.00, bottom: 30.00),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    loader = true;
                                  });
                                  int success = await deleteall();
                                  setState(() {
                                    loader = false;
                                  });
                                  if (success == 200) {
                                    print("deleted all");
                                    _reloadPage();
                                  }
                                },
                                child: CircleAvatar(
                                  child: Icon(
                                    Icons.list,
                                    color: Colors.yellow.shade800,
                                    size: 30.00,
                                  ),
                                  backgroundColor: Colors.white,
                                  radius: 30.00,
                                ),
                              ),
                            ],
                          ),
                          Image(
                            image: AssetImage('images/to-do-list.png'),
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.15,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.00,
                      ),
                      Text(
                        'Checkit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50.00,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: TextField(
                            onTap: () {
                              showSearch(
                                  context: context,
                                  delegate: ProductSearchDelegate(uid: uid!));
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            autofocus: false,
                            maxLines: 1,
                            textAlignVertical: TextAlignVertical.bottom,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                            decoration: InputDecoration(
                              suffixIcon: const Icon(
                                Icons.search_sharp,
                                color: Colors.black54,
                                size: 25,
                              ),
                              hintText: 'Hop on to your note',
                              hintStyle: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 17,
                                fontWeight: FontWeight.w300,
                              ),
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(45),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(45),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.00),
                        topRight: Radius.circular(20.00),
                      ),
                    ),
                    child: TaskList(
                      uid: uid!,
                    ),
                  ),
                ),
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
