import 'dart:convert';

import 'package:easy_bill/Modals/StockItem.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../variables.dart';

class GetMyStockService {
  static Future<List<dynamic>> getStock() async {
    try {
      Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
      
      SharedPreferences login = await SharedPreferences.getInstance();
      
      final body = {
        "token": login.getString("gettoken")
      };

      final response = await http.post('${URLS.BASE_URL}stocks/getmine',
          body: jsonEncode(body), headers: requestHeaders);

      if (response.statusCode == 200) {
        List<StockItem> list = parseStockss(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<StockItem> parseStockss(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<StockItem>((json) => StockItem.fromJson(json)).toList();
  }
}
