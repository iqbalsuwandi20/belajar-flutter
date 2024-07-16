import 'package:belajar_flutter_notification/push_notif.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_messaging/firebase_messaging.dart';
// ignore: depend_on_referenced_packages
import 'package:overlay_support/overlay_support.dart';

void main() async {
  runApp(const MyApp());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final FirebaseMessaging _messaging;
  int _totalNotif = 0;
  PushNotif? _notifInfo;

  void registrasiNotif() async {
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;

    Future _firebaseMessageHandler(RemoteMessage message) async {
      print("Handling Message : ${message.messageId}");
    }

    FirebaseMessaging.onBackgroundMessage(_firebaseMessageHandler);

    NotificationSettings settings = await _messaging.requestPermission(
        alert: true, badge: true, provisional: true, sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("Oke di izinkan");
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print(message);

        PushNotif pushNotif = PushNotif(
          title: message.notification?.title,
          body: message.notification?.body,
          dataTitle: message.data["title"],
          dataBody: message.data["body"],
        );

        setState(() {
          _notifInfo = pushNotif;
          _totalNotif++;
        });

        if (_notifInfo != null) {
          showSimpleNotification(Text(_notifInfo!.title!),
              leading: const Icon(Icons.notifications),
              subtitle: Text(_notifInfo!.body!),
              duration: const Duration(seconds: 5));
        }
      });
    } else {
      print("User tidak diizinkan");
    }
  }

  checkMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? _initialMessage;
    await FirebaseMessaging.instance.getInitialMessage();

    // ignore: unnecessary_null_comparison
    if (_initialMessage != null) {
      PushNotif notifFication = PushNotif(
        title: _initialMessage.notification?.title,
        body: _initialMessage.notification?.body,
      );

      setState(() {
        _notifInfo = notifFication;
        _totalNotif++;
      });
    }
  }

  @override
  void initState() {
    _totalNotif = 0;
    super.initState();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage msg) {
      PushNotif notification = PushNotif(
          title: msg.notification?.title, body: msg.notification?.body);
      setState(() {
        _notifInfo = notification;
        _totalNotif++;
      });
      registrasiNotif();
      checkMessage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
      ),
      body: Column(
        children: [
          const Text("TOTAL DATA YANG DITERIMA"),
          NotifBadge(totalNotif: _totalNotif),
          _notifInfo != null
              ? Column(
                  children: [
                    Text("${_notifInfo!.dataTitle ?? _notifInfo!.title}"),
                    Text("${_notifInfo!.dataBody ?? _notifInfo!.body}")
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}

class NotifBadge extends StatelessWidget {
  final int totalNotif;
  const NotifBadge({super.key, required this.totalNotif});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text("$totalNotif"),
      )),
    );
  }
}
