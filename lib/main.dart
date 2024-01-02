import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_api/controller/addtodo_provider.dart';
import 'package:todo_api/controller/todolist_provider.dart';
import 'package:todo_api/view/todo_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AddTodoProvider(),
        ),
         ChangeNotifierProvider(
          create: (context) => TodoListProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        home: const TodoListScreen(),
      ),
    );
  }
}
