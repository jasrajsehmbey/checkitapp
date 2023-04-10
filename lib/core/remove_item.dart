import 'dart:convert';

import '../app/constants/baseurl.dart';
import 'package:http/http.dart' as http;

Future<int> removeItem(String note, String uid) async {
  var url = "${baseURL}/delete/$uid";
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
