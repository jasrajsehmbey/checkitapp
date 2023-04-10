// ignore_for_file: prefer_const_constructors

import 'dart:collection';
import 'dart:developer';
import 'package:checkit/widgets/tasktile.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../core/getsearch.dart';
import '../core/notifiers.dart';
import '../core/remove_item.dart';
import '../core/update_item.dart';

/* Created by Jasraj*/
class ProductSearchDelegate extends SearchDelegate {
  ProductSearchDelegate({required this.uid});

  final String uid;

  List<Map> searchResults = [];
  List<Map> result = [];

  List<Map> suggestions = [];

  late Map searchItems;

  getItems() async {
    searchItems = await getSearchData(query, uid);
    return searchItems;
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
          close(context, null);
        },
      );

  @override
  Widget buildResults(BuildContext context) {
    // final user = Provider.of<AuthProvider>(context);
    if (suggestions.toString() != '[]') {
      return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 0.1,
                ),
              ),
            ),
            child: TaskTile(
              text: suggestion["note"],
              isChecked: suggestion["isChecked"] == 1 ? true : false,
              onLongPress: () async {
                int success = await removeItem(suggestion["note"], uid);
                if (success == 200) {
                  print("removed");
                  showResults(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("${suggestion["note"]} is deleted")));
                }
                // taskData.removeTask(task);
              },
              onChanged: (bool? newValue) async {
                int success = await updateItem(suggestion["note"], uid);
                if (success == 200) {
                  print("changed");
                  showResults(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("${suggestion["note"]} is changed")));
                }
                // taskData.updateTask(task);
              },
            ),
          );
        },
      );
    } else {
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Center(child: Text('No items')),
      );
    }
  }

  bool loader = false;

  @override
  Widget buildSuggestions(BuildContext context) {
    // final user = Provider.of<AuthProvider>(context);
    suggestions = result.where((element) {
      final result = element['note'];
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();
    return FutureBuilder<List>(
      future: Future.wait([getItems()]),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final item = snapshot.data![0];
          if (item['data'].toString() != '[]') {
            if (item['length'] != 0) {
              for (int i = 0; i < item['length']; i++) {
                searchResults.add(item['data'][i]);
              }
              result = LinkedHashSet<Map>.from(searchResults).toList();
              searchResults.clear();
              return ListView.builder(
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final suggestion = suggestions[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 0.1,
                        ),
                      ),
                    ),
                    child: TaskTile(
                      text: suggestion["note"],
                      isChecked: suggestion["isChecked"] == 1 ? true : false,
                      onLongPress: () async {
                        int success = await removeItem(suggestion["note"], uid);
                        if (success == 200) {
                          print("removed");
                          showResults(context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text("${suggestion["note"]} is deleted")));
                        }
                        // taskData.removeTask(task);
                      },
                      onChanged: (bool? newValue) async {
                        int success = await updateItem(suggestion["note"], uid);
                        if (success == 200) {
                          print("changed");
                          showResults(context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text("${suggestion["note"]} is changed")));
                        }
                        // taskData.updateTask(task);
                      },
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text('No Items'),
              );
            }
          } else {
            return Center(
              child: Text('No Items'),
            );
          }
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
