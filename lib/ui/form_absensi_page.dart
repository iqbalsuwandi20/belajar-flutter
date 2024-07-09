import 'package:belajar_flutter_sqlite/models/absensi.dart';
import 'package:flutter/material.dart';

class FormAbsensiPage extends StatefulWidget {
  final Absensi? absensi;
  FormAbsensiPage({super.key, this.absensi});

  @override
  State<FormAbsensiPage> createState() => _FormAbsensiPageState(this.absensi);
}

class _FormAbsensiPageState extends State<FormAbsensiPage> {
  Absensi? absensi;
  _FormAbsensiPageState(this.absensi);

  TextEditingController nameController = TextEditingController();
  TextEditingController statusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (absensi != null) {
      nameController.text = absensi!.nama;
      statusController.text = absensi!.status_hadir;
    }

    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text("Form Absensi"),
      ),
      body: Padding(
        // ignore: prefer_const_constructors
        padding: EdgeInsets.only(top: 15, left: 10, right: 10),
        child: ListView(
          children: <Widget>[
            Padding(
              // ignore: prefer_const_constructors
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Nama Karyawan"),
                onChanged: (value) {},
              ),
            ),
            Padding(
              // ignore: prefer_const_constructors
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: TextField(
                controller: statusController,
                decoration:
                    const InputDecoration(labelText: "Status Kehadiran"),
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            if (absensi == null) {
                              absensi = Absensi(
                                  nameController.text, statusController.text);
                            } else {
                              absensi!.nama = nameController.text;
                              absensi!.status_hadir = statusController.text;
                            }
                            Navigator.pop(context, absensi);
                          },
                          child: const Text("Save"))),
                  Container(
                    width: 10,
                  ),
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // ignore: prefer_const_constructors
                          },
                          child: const Text("Cancel"))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
