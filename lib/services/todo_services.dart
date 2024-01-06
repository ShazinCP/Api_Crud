import 'dart:convert';

import 'package:todo_api/model/todo_model.dart';
import 'package:dio/dio.dart';

class TodoServices {
  final Dio _dio = Dio();
  Future<List<TodoModel>> fetchTodo() async {
    const url = "https://api.nstack.in/v1/todos";
    final response = await _dio.get(url);
    if (response.statusCode == 200) {
      final json = response.data as Map<String, dynamic>;
      final result = json['items'] as List;
      return result.map((json) => TodoModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to Fetch Todo');
    }
  }

  Future<void> submitData(TodoModel modelRequest) async {
    final body = modelRequest.toJson();
    const url = "https://api.nstack.in/v1/todos";
    final response = await _dio.post(
      url,
      data: jsonEncode(body),
      options: Options(headers: {'Content-Type': 'application/json'}),
    );
    if (response.statusCode == 201) {
      print('Creation Success');
    } else {
      print('Creation Failed');
    }
  }

  Future<void> deleteById(String id) async {
    final url = 'https://api.nstack.in/v1/todos/$id';
    final response = await _dio.delete(url);
    if (response.statusCode == 200) {
      print('Deletion Success');
    } else {
      print('Deletion Failed');
    }
  }

  Future<void> updateData(requestModel, id) async {
    final body = requestModel.toJson();

    final url = "https://api.nstack.in/v1/todos/$id";
    final response = await _dio.put(
      url,
      data: jsonEncode(body),
      options: Options(headers: {'Content-Type': 'application/json'}),
    );
    if (response.statusCode == 200) {
      print('Updation success');
    } else {
      throw Exception('Update failed');
    }
  }
}
