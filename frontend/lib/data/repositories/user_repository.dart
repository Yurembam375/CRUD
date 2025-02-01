import 'dart:convert';
import 'package:frontend/data/model/userModel.dart';
import 'package:http/http.dart' as http;

class PersonRepository {
  static const baseUrl = 'http://192.168.29.196:3000/api/';

  Future<List<Person>> fetchPersons() async {
    // final response = await http.get(Uri.parse("${baseUrl}get_persons"));
    // if (response.statusCode == 200) {
    //   List<dynamic> data = json.decode(response.body)['persons'];
    //   return data.map((json) => Person.fromJson(json)).toList();
    // } else {
    //   throw Exception("Failed to fetch persons");
    // }
    final response = await http.get(Uri.parse("${baseUrl}get_persons"));
    print(
        'Response body: ${response.body}'); // Log the response to check its structure
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['persons'];
      return data.map((json) => Person.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch persons");
    }
  }

  Future<bool> addPerson(Map<String, dynamic> data) async {
    final response =
        await http.post(Uri.parse("${baseUrl}add_person"), body: data);
    return response.statusCode == 200;
  }

  Future<bool> updatePerson(int id, Map<String, dynamic> data) async {
    final response =
        await http.put(Uri.parse("${baseUrl}update_person/$id"), body: data);
    return response.statusCode == 200;
  }

  Future<bool> deletePerson(int id) async {
    final response =
        await http.delete(Uri.parse("${baseUrl}delete_person/$id"));
    return response.statusCode == 200;
  }
}
