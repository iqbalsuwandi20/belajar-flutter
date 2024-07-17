import 'dart:async';

import 'package:belajar_flutter_maps/models/todo.dart';
import 'package:belajar_flutter_maps/screens/home/form_todo.dart';
import 'package:belajar_flutter_maps/services/auth.dart';
import 'package:belajar_flutter_maps/services/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Auth auth = Auth();
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Todo>? todoList;

  @override
  Widget build(BuildContext context) {
    todoList ??= <Todo>[];

    final signOut = IconButton(
      onPressed: () async {
        await auth.signOut();
      },
      icon: const Icon(Icons.logout),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [signOut],
      ),
      body: createListTodo(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var todo = await _navigatorToForm(context, null);
          // ignore: unnecessary_null_comparison
          if (todo != null) {
            _createData(todo);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<Todo> _navigatorToForm(BuildContext context, Todo? todo) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return FormTodo(todo: todo);
        },
      ),
    );
    return result;
  }

  ListView createListTodo() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            title: Text(todoList![index].title),
            trailing: GestureDetector(
              child: const Icon(Icons.delete),
              onTap: () {
                _deleteData(todoList![index]);
              },
            ),
            onTap: () async {
              var todo = await _navigatorToForm(context, this.todoList![index]);
              // ignore: unnecessary_null_comparison
              if (todo != null) {
                _editData(todo);
              }
            },
          ),
        );
      },
      itemCount: count,
    );
  }

  void _createData(Todo object) async {
    int result = await dbHelper.create(object);
    if (result > 0) {
      _updateView();
    }
  }

  void _editData(Todo object) async {
    int result = await dbHelper.update(object);
    if (result > 0) {
      _updateView();
    }
  }

  void _deleteData(Todo object) async {
    int result = await dbHelper.delete(object.id);
    if (result > 0) {
      _updateView();
    }
  }

  void _updateView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then(
      (database) {
        Future<List<Todo>> todoListFuture = dbHelper.getTodoList();
        todoListFuture.then(
          (todoList) {
            setState(
              () {
                this.todoList = todoList;
                count = todoList.length;
              },
            );
          },
        );
      },
    );
  }
}
