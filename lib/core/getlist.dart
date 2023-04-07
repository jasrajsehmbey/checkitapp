import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import '../app/constants/baseurl.dart';
import '../models/listmodel.dart';
/* Created by Jasraj*/

Future<List<ListModel>> getListData(String uid) async {
  http.Response response = await http.get(Uri.parse('${baseURL}/get/$uid'));
  if (response.statusCode == 200) {
    String data = response.body;
    final json = jsonDecode(data) as List;
    final list = json
        .map((e) => ListModel(
              id: e["id"],
              note: e["note"],
              isChecked: e["isChecked"],
            ))
        .toList();
    return list;
  } else {
    log(response.statusCode.toString());
    return [];
  }
}
