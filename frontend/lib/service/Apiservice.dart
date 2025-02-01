
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class Apiservice {
  static const baseUrl = 'http://192.168.29.196:3000/api/';

  static Future<bool> addPerson(Map<String, dynamic> pdata) async {
    var url = Uri.parse("${baseUrl}add_person");
    try {
      final res = await http.post(url, body: pdata);
      if (res.statusCode == 200) {
        log("Person added: ${res.body}");
        return true;
      } else {
        log("Failed to add person");
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  static Future<List<dynamic>> getPersons() async {
    var url = Uri.parse("${baseUrl}get_persons");
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        return data['persons'];
      } else {
        log("Failed to fetch persons");
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  static Future<bool> updatePerson(int id, Map<String, dynamic> pdata) async {
    var url = Uri.parse("${baseUrl}update_person/$id");
    try {
      final res = await http.put(url, body: pdata);
      if (res.statusCode == 200) {
        log("Person updated: ${res.body}");
        return true;
      } else {
        log("Failed to update person");
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  static Future<bool> deletePerson(int id) async {
    var url = Uri.parse("${baseUrl}delete_person/$id");
    try {
      final res = await http.delete(url);
      if (res.statusCode == 200) {
        log("Person deleted: ${res.body}");
        return true;
      } else {
        log("Failed to delete person");
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
