import 'dart:convert';

import 'package:http/http.dart';
import 'package:pricing_tool/constants/urls.dart';

class RestService {
  static final RestService _instance = RestService._internal();

  factory RestService() => _instance;

  // init things inside this
  RestService._internal();

  Future<Map> getTotalCountedDelays() async {

    Response res = await get(URLS.SERVER_URL_GET_TOTAL_COUNTED_DELAYS);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      return body;
    } else {
      throw "Can't get total counted delays.";
    }
  }
}
