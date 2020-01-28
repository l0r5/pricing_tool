class DataFormatUtils {
  Map<dynamic, dynamic> parseHistoricData(dynamic jsonData) {
    Map resultData = {};
    jsonData.forEach((k, v) {
      Map resultMap = {};
      if (k == "dates") {
        resultData["$k"] = v;
      } else {
        v.forEach((k, v) {
          resultMap["$k"] = v;
        });
        resultData["$k"] = resultMap;
      }
    });
    return resultData;
  }
}