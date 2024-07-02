import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Home Appbar"),
        leading: Icon(Icons.arrow_back_ios),
        actions: [Icon(Icons.notifications_active), Icon(Icons.history)],
      ),

      //Praktek
      body: Center(
        child: Column(
          children: [
            Image.asset(
              "assets/images/profile-avatar.jpg",
              width: 200,
              height: 100,
            ),
            const Center(
              child: Column(
                children: [Text("Nama: "), Text("Iqbal Suwandi")],
              ),
            )
          ],
        ),
      ),

      // Container
      // body: Container(
      //   child: Row(
      //     children: [
      //       Column(
      //         children: [
      //           ElevatedButton(
      //               onPressed: () {
      //                 print("Ini tertekan");
      //               },
      //               child: Text("Ini adalah Elevated Button")),
      //           Image.network(
      //             "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
      //             height: 100,
      //             width: 200,
      //           ),
      //         ],
      //       ),
      //       Column(
      //         children: [
      //           Image.network(
      //             "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
      //             height: 100,
      //             width: 200,
      //           ),
      //           ElevatedButton(
      //               onPressed: () {
      //                 print("Ini tertekan");
      //               },
      //               child: Text("Ini adalah Elevated Button")),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),

      // Row dan Column
      // body: Row(
      //   children: [
      //     Column(
      //       children: [
      //         ElevatedButton(
      //             onPressed: () {
      //               print("Ini tertekan");
      //             },
      //             child: Text("Ini adalah Elevated Button")),
      //         Image.network(
      //           "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
      //           height: 100,
      //           width: 200,
      //         ),
      //       ],
      //     ),
      //     Column(
      //       children: [
      //         Image.network(
      //           "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
      //           height: 100,
      //           width: 200,
      //         ),
      //         ElevatedButton(
      //             onPressed: () {
      //               print("Ini tertekan");
      //             },
      //             child: Text("Ini adalah Elevated Button")),
      //       ],
      //     ),
      //   ],
      // ),

      // Row
      // body: Row(
      //   children: [
      //     ElevatedButton(
      //         onPressed: () {
      //           print("Ini tertekan");
      //         },
      //         child: Text("Ini adalah Elevated Button")),
      //     Image.network(
      //       "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
      //       height: 100,
      //       width: 200,
      //     ),
      //   ],
      // ),

      // Column
      // body: Column(
      //   children: [
      //     ElevatedButton(
      //         onPressed: () {
      //           print("Ini tertekan");
      //         },
      //         child: Text("Ini adalah Elevated Button")),
      //     Image.network(
      //       "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
      //       height: 100,
      //       width: 200,
      //     ),
      //   ],
      // ),

      // Image network
      // body: Image.network(
      //   "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
      //   height: 100,
      //   width: 200,
      // ),

      // Image asset
      // body: Image.asset("assets/images/profile-avatar.jpg",
      //     width: 200, height: 100),

      //body: ElevatedButton(
      //   onPressed: () => print("ini tertekan"),
      // child: Text("Ini adalah ElevatedButton")),

      // TextButton
      // body: TextButton(
      //     onPressed: () {
      //       print("Ini Text Button");
      //     },
      //     child: Text("Ini adalah text button"))

      // Icon Button onPressed
      // body: IconButton(
      //   onPressed: () {
      //     print("Ini tekan");
      //   },
      //   icon: Icon(Icons.alarm),
      // ),

      // body: Text(
      //   "Ini adalah Home Appbar",
      //   style:
      //       TextStyle(fontFamily: "open sans", fontSize: 20, color: Colors.red),
      // ),
    );
  }
}
