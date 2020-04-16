import 'dart:convert';

import 'package:easy_bill/Modals/ReturnItem.dart';
import 'package:easy_bill/Modals/StockItem.dart';
import 'package:http/http.dart' as http;

import '../variables.dart';

class GetMyReturnsService {
  static Future<List<dynamic>> getRturns() async {
    try {
      Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

      final body = {
        "token":
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZTkzMWU0NjYxYzVjMDAwMTcwYmNkYzUiLCJpYXQiOjE1ODY4NjU5MDB9.5rMJBsgdlMQZVqoFPU3iCHoLm44gn7v_HPPDc90F1DA"
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
