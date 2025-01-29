import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class Apiservice {
  static const baseUrl = 'http:// 192.168.29.196/api/';

  static addPerson(Map<String,dynamic> pdata) async {
    log("${pdata.toString()} yaree");
    var url = Uri.parse("${baseUrl}add_person'");
    try {
      final res = await http.post(url, body: pdata);
      if (res.statusCode == 200) {
        var data = res.body;
        jsonDecode(data);
        log(data.toString());
      } else {
        log("fail to upload data ");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
