import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
      home: const MyHomePageState(),
    );
  }
}

class MyHomePageState extends StatefulWidget {
  const MyHomePageState({super.key});

  @override
  State<MyHomePageState> createState() => _MyHomePageStateState();
}

class _MyHomePageStateState extends State<MyHomePageState> {
  final TextEditingController _namedEditingController = TextEditingController();
  final TextEditingController _statusEditingController =
      TextEditingController();

  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection("attendance");

  Future<void> _createUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = "create";
    if (documentSnapshot != null) {
      action = "update";
      _namedEditingController.text = documentSnapshot["name"];
      _statusEditingController.text = documentSnapshot["status"];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            child: Column(
              children: [
                TextField(
                  controller: _namedEditingController,
                  decoration: const InputDecoration(labelText: "Student Name"),
                ),
                TextField(
                  controller: _statusEditingController,
                  decoration:
                      const InputDecoration(labelText: "Student Status"),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      final String? name = _namedEditingController.text;
                      final String? status = _statusEditingController.text;

                      if (name != null && status != null) {
                        if (action == "create") {
                          await _collectionReference
                              .add({"name": name, "status": status});
                        }
                        if (action == "update") {
                          await _collectionReference
                              .doc(documentSnapshot!.id)
                              .update({"name": name, "status": status});
                        }

                        _namedEditingController.text = "";
                        _statusEditingController.text = "";

                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(action == "create" ? "create" : " upadate"))
              ],
            ),
          );
        });
  }

  Future<void> _deleteAttendance(String attendanceID) async {
    await _collectionReference.doc(attendanceID).delete();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("data is successfully deleted")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase"),
      ),
      body: StreamBuilder(
          stream: _collectionReference.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(documentSnapshot["name"]),
                        subtitle: Text(documentSnapshot["status"]),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    _deleteAttendance(documentSnapshot.id);
                                  },
                                  icon: const Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () {
                                    _createUpdate(documentSnapshot);
                                  },
                                  icon: const Icon(Icons.delete)),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _createUpdate,
        child: const Icon(Icons.add),
      ),
    );
  }
}
