import 'package:flutter/material.dart';

class BadgeNotif extends StatelessWidget {
  final int totalNotif;
  const BadgeNotif({super.key, required this.totalNotif});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
      child: Center(
        child: Text("$totalNotif"),
      ),
    );
  }
}
