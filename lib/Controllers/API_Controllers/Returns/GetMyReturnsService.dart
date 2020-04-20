import 'dart:convert';
import 'package:easy_bill/Modals/ReturnItem.dart';
import 'package:easy_bill/Modals/StockItem.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../variables.dart';

class GetMyReturnsService {
  static Future<List<dynamic>> getRturns() async {
    try {
      Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
      
      SharedPreferences login = await SharedPreferences.getInstance();

      final body = {
        "token": login.getString("gettoken")
      };

      final response = await http.post('${URLS.BASE_URL}returns/getmine',
          body: jsonEncode(body), headers: requestHeaders);

      if (response.statusCode == 200) {
        List<ReturnItem> list = parseStockss(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<ReturnItem> parseStockss(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<ReturnItem>((json) => ReturnItem.fromJson(json)).toList();
  }
}
