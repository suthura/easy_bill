import 'dart:convert';
import 'package:easy_bill/Controllers/API_Controllers/variables.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  static Future<bool> login(body) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    final response = await http.post('${URLS.BASE_URL}auth/login',
        body: jsonEncode(body), headers: requestHeaders);

    var data = response.body;
    // print(body);
    print(json.decode(data));

    Map<String, dynamic> res_data = jsonDecode(data);
    print(res_data.toString());
    if (res_data['status'] == 'active') {
      final _token = res_data['token'];
      print("Token set");
        SharedPreferences login = await SharedPreferences.getInstance();
        print("Token set");
        login.setString("gettoken", _token);
      return true;
    } else {
      return false;
    }
    // return false;
  }
}
