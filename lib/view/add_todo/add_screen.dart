import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_api/constant/sizedbox.dart';
import 'package:todo_api/controller/todo_provider.dart';
import 'package:todo_api/helper/colors.dart';
import 'package:todo_api/view/todo_list/todo_list.dart';

class AddTodoScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final todo;
  const AddTodoScreen({super.key, this.todo});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);
    if (todo != null) {
      todoProvider.isEditValueChange(true);
      final title = todo.title;
      final descriptio = todo.description;
      todoProvider.titleController.text = title;
      todoProvider.descriptionController.text = descriptio;
    } else {
      todoProvider.isEditValueChange(false);
      todoProvider.titleController.text = '';
      todoProvider.descriptionController.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(provider.isEdit ? 'Edit Todo' : 'Add Todo'),
            centerTitle: true,
          ),
          body: Consumer<TodoProvider>(
            builder: (context, provider, child) {
              return ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  cHeight20,
                  TextField(
                    controller: provider.titleController,
                    decoration: const InputDecoration(hintText: "Title"),
                  ),
                  TextField(
                    controller: provider.descriptionController,
                    decoration: const InputDecoration(hintText: "Description"),
                    keyboardType: TextInputType.multiline,
                    minLines: 5,
                    maxLines: 8,
                  ),
                  cHeight20,
                  ElevatedButton(
                    onPressed: () {
                      if (provider.isEdit) {
                        provider.updateData(widget.todo);
                        showSuccessMessage('Updation Success');
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const TodoListScreen(),
                        ));
                      } else {
                        provider.submitData();
                        showSuccessMessage('Creation Success');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          cCyanColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        provider.isEdit ? 'Update' : 'Submit',
                        style: const TextStyle(
                            color: cBlackColor,fontSize: 16),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
