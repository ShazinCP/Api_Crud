import 'dart:convert';

import 'package:todo_api/model/todo_model.dart';
import 'package:http/http.dart' as http;

class TodoServices {
  Future<List<TodoModel>> fetchTodo() async {
    const url = "https://api.nstack.in/v1/todos";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      return result.map((json) => TodoModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to Fetch Todo');
    }
  }

  Future<void> submitData(TodoModel modelRequest) async {
    final body = modelRequest.toJson();

    const url = "https://api.nstack.in/v1/todos";
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
      print('Creation Success');
    } else {
      print('Creation Failed');
    }
  }

  Future<void> deleteById(String id) async {
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      print('Deletion Success');
    } else {
      print('Deletion Failed');
    }
  }

  Future<void> updateData(TodoModel modelRequest, id) async {
    final body = modelRequest.toJson();

    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.put(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      print('Updation Success');
    } else {
      print('Updation Success');
    }
  }
}
