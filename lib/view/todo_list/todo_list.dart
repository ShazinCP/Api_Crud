import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_api/controller/todo_provider.dart';
import 'package:todo_api/helper/colors.dart';
import 'package:todo_api/view/add_todo/add_screen.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  void initState() {
    final provider = Provider.of<TodoProvider>(context, listen: false);
    super.initState();
    provider.fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
        centerTitle: true,
      ),
      body: Consumer<TodoProvider>(
        builder: (context, provider, child) {
          return RefreshIndicator(
            onRefresh: provider.fetchTodo,
            child: Visibility(
              visible: provider.items.isNotEmpty,
              replacement: const Center(
                child: Text(
                  'No Todo Item',
                  style: TextStyle(color: cGreyColor, fontSize: 19),
                ),
              ),
              child: ListView.builder(
                itemCount: provider.items.length,
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  final item = provider.items[index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(child: Text('${index + 1}')),
                      title: Text(item.title!),
                      subtitle: Text(item.description!),
                      trailing: PopupMenuButton(
                        onSelected: (value) {
                          if (value == 'edit') {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddTodoScreen(todo: item),
                            ));
                          } else if (value == 'delete') {
                            provider.deleteById(item.id!);
                          }
                        },
                        itemBuilder: (context) {
                          return [
                            const PopupMenuItem(
                              value: 'edit',
                              child: Text("Edit"),
                            ),
                            const PopupMenuItem(
                              value: 'delete',
                              child: Text("Delete"),
                            ),
                          ];
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: cCyanColor,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddTodoScreen(),
          ));
        },
        label: const Text("Add Todo"),
      ),
    );
  }

  Future<void> navigateToEditPage(Map item) async {
    final provider = Provider.of<TodoProvider>(context, listen: false);
    final route = MaterialPageRoute(
      builder: (context) => AddTodoScreen(todo: item),
    );
    await Navigator.push(context, route);
    provider.setLoading(true);
    provider.fetchTodo();
  }

  // void showErrorMessage(String message) {
  //   final snackBar = SnackBar(
  //     content: Text(
  //       message,
  //       style: const TextStyle(color: cWhiteColor),
  //     ),
  //     backgroundColor: cRedColor,
  //   );
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }
}
