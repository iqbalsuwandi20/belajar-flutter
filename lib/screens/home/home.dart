import 'dart:async';

import 'package:belajar_flutter_maps/models/push_notification.dart';
import 'package:belajar_flutter_maps/models/todo.dart';
import 'package:belajar_flutter_maps/screens/home/form_todo.dart';
import 'package:belajar_flutter_maps/services/auth.dart';
import 'package:belajar_flutter_maps/services/db_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
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
  late final FirebaseMessaging _messaging;
  PushNotification? pushNotification;
  late int _totalNotif;

  void registerNotif() async {
    await Firebase.initializeApp();

    _messaging = FirebaseMessaging.instance;

    Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
      print(message);
    }

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("diizinkan");
      FirebaseMessaging.onMessage.listen(
        (RemoteMessage message) {
          print(message);

          PushNotification notification = PushNotification(
            title: message.notification?.title,
            body: message.notification?.body,
          );

          setState(() {
            pushNotification = notification;
            _totalNotif++;
          });

          if (pushNotification != null) {
            showSimpleNotification(
              Text(pushNotification!.title!),
              subtitle: Text(pushNotification!.title!),
              background: Colors.blueGrey,
              duration: const Duration(seconds: 10),
            );
          }
        },
      );
    } else {
      print("di tolak");
    }
  }

  checkInitialMessage() async {
    await Firebase.initializeApp();

    RemoteMessage? initialmsg =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialmsg != null) {
      PushNotification notification = PushNotification(
        title: initialmsg.notification!.title,
        body: initialmsg.notification!.body,
      );

      setState(() {
        pushNotification = notification;
        _totalNotif++;
      });
    }
  }

  @override
  void initState() {
    _totalNotif = 0;
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
        );

        setState(
          () {
            pushNotification = notification;
            _totalNotif++;
          },
        );
      },
    );
    checkInitialMessage();
    registerNotif();
    super.initState();
  }

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
          (todoListView) {
            setState(
              () {
                this.todoList = todoListView;
                count = todoListView.length;
              },
            );
          },
        );
      },
    );
  }
}
