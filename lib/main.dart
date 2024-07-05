import 'package:belajar_flutter_intermediate/second_screen_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      initialRoute: "/",
      routes: {"secondPage": (context) => SecondScreenPage()},
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Navigation and Routing"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("This is first page"),

            // navigator pushnamed
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed("secondPage");
                },
                child: Text("This is Second Screen Page"))

            // navigator pop
            // ElevatedButton(
            //     onPressed: () {
            //       Navigator.of(context).pop(MaterialPageRoute(builder: (_) {
            //         return SecondScreenPage();
            //       }));
            //     },
            //     child: Text("Go to screen 2"))

            // navigator push
            // ElevatedButton(
            //     onPressed: () {
            //       Navigator.push(context, MaterialPageRoute(builder: (_) {
            //         return SecondScreenPage();
            //       }));
            //     },
            //     child: Text("Go to Page 2"))
          ],
        ),
      ),
    );
  }
}
