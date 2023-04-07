import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/listmodel.dart';
import 'getlist.dart';

class ToDoItems extends ChangeNotifier {
  bool isLoading = false;
  List<ListModel> get data => _data;
  List<ListModel> _data = [];

  Future<void> getListDetail(String uid) async {
    isLoading = true;
    notifyListeners();
    final response = await getListData(uid);
    _data = response;
    isLoading = false;
    notifyListeners();
  }
}
