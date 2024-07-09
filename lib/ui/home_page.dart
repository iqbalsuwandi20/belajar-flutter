import 'package:belajar_flutter_sqlite/helpers/db_helper.dart';
import 'package:belajar_flutter_sqlite/models/absensi.dart';
import 'package:belajar_flutter_sqlite/ui/form_absensi_page.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Absensi>? absensiList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Absensi Karyawan"),
      ),
      body: createListAbsensi(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var absensi = await _navigateToFormAbensi(context, null);
          _createAbsensi(absensi);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<Absensi> _navigateToFormAbensi(
      BuildContext context, Absensi? abensi) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return FormAbsensiPage(absensi: abensi);
    }));
    return result;
  }

  ListView createListAbsensi() {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.white,
            elevation: 3.0,
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.people_outline),
              ),
              title: Text(this.absensiList![index].nama),
              subtitle: Text(this.absensiList![index].status_hadir),
              trailing: GestureDetector(
                child: const Icon(Icons.delete),
                onTap: () {
                  _deleteAbsensi(absensiList![index]);
                },
              ),
              onTap: () async {
                var absensi = await _navigateToFormAbensi(
                    context, this.absensiList![index]);
                _editAbsensi(absensi);
              },
            ),
          );
        });
  }

  void _createAbsensi(Absensi object) async {
    int result = await dbHelper.create(object);
    if (result > 0) {
      _updateListView();
    }
  }

  void _editAbsensi(Absensi object) async {
    int result = await dbHelper.update(object);
    if (result > 0) {
      _updateListView();
    }
  }

  void _deleteAbsensi(Absensi object) async {
    int result = await dbHelper.delete(object.id);
    if (result > 0) {
      _updateListView();
    }
  }

  void _updateListView() {
    final Future<Database> dbFuture = dbHelper.initDB();
    dbFuture.then((database) {
      Future<List<Absensi>> absensiListFuture = dbHelper.getAbsensiList();
      absensiListFuture.then((absensiList) {
        setState(() {
          this.absensiList = absensiList;
          this.count = absensiList.length;
        });
      });
    });
  }
}
