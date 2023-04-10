import 'dart:convert';

import 'package:http/http.dart' as http;
import '../app/constants/baseurl.dart';

/* Created by Jasraj*/

Future<Map> getSearchData(String search, String uid) async {
  http.Response response = await http.get(
    Uri.parse('${baseURL}/search/$uid/$search'),
  );
  if (response.statusCode == 200) {
    String data = response.body;
    final json = jsonDecode(data) as Map;
    return json;
  } else {
    throw Exception('Failed to load model');
  }
}
