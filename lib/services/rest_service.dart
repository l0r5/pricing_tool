import 'dart:convert';

import 'package:http/http.dart';
import 'package:pricing_tool/constants/urls.dart';
import 'package:pricing_tool/utils/data_format_utils.dart';

class RestService {
  static final RestService _instance = RestService._internal();

  factory RestService() => _instance;

  // init things inside this
  RestService._internal();

  Future<Map> getTotalCountedDelays() async {
    Response res = await get(URLS.SERVER_URL_GET_TOTAL_COUNTED_DELAYS);
    if (res.statusCode == 200) {
      Map body = json.decode(res.body);
      Map resultData = DataFormatUtils().parseHistoricData(body);
      return resultData;
    } else {
      throw "Can't get total counted delays.";
    }
  }
}
