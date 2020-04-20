import 'dart:convert';

import 'package:easy_bill/Modals/ReturnItem.dart';
import 'package:easy_bill/Modals/SaleItem.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../variables.dart';

class GetAllSalesService {
  static Future<List<dynamic>> getAllSales() async {
    try {
      Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
     
     SharedPreferences login = await SharedPreferences.getInstance();
      final body = {
        "token": login.getString("gettoken")
            
      };

      final response = await http.post('${URLS.BASE_URL}sales/getmysales',
          body: jsonEncode(body), headers: requestHeaders);

      if (response.statusCode == 200) {
        List<SaleItem> list = parseSales(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<SaleItem> parseSales(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<SaleItem>((json) => SaleItem.fromJson(json)).toList();
  }
}
