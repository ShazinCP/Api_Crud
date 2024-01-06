import 'package:flutter/material.dart';
import 'package:todo_api/model/todo_model.dart';
import 'package:todo_api/services/todo_services.dart';

class TodoProvider extends ChangeNotifier {
  bool isEdit = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  List<TodoModel> items = [];
  TodoServices todoServices = TodoServices();
  bool isLoading = true;

  //fetch todo
  Future<void> fetchTodo() async {
    items = await todoServices.fetchTodo();
    notifyListeners();
  }

  //add todo
  Future<void> submitData() async {
    final title = titleController.text;
    final description = descriptionController.text;
    final modelRequest =
        TodoModel(title: title, description: description, isCompleted: false);
    await todoServices.submitData(modelRequest);
    titleController.text = '';
    descriptionController.text = '';
    fetchTodo();
  }

  //delete todo
  Future<void> deleteById(String id) async {
    await todoServices.deleteById(id);
    items.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }

  // update todo
  Future<void> updateData(TodoModel todoModel) async {
    // ignore: unnecessary_null_comparison
    if (todoModel == null) {
      debugPrint('you cannot call updated without todo data');
      return;
    }
    final id = todoModel.id;
    final title = titleController.text;
    final description = descriptionController.text;
    final modelRequest =
        TodoModel(title: title, description: description, isCompleted: false);
    try {
      await todoServices.updateData(modelRequest, id);
      fetchTodo();
    } catch (e) {
      throw Exception('update :$e');
    }
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void isEditValueChange(bool value) {
    isEdit = value;
  }
}
