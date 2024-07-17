import 'package:belajar_flutter_maps/models/todo.dart';
import 'package:flutter/material.dart';

class FormTodo extends StatefulWidget {
  final Todo? todo;
  const FormTodo({super.key, required this.todo});

  @override
  // ignore: no_logic_in_create_state
  State<FormTodo> createState() => _FormTodoState(todo);
}

class _FormTodoState extends State<FormTodo> {
  Todo? todo;
  _FormTodoState(this.todo);

  final title = TextEditingController();
  final note = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (todo != null) {
      title.text = todo!.title;
      note.text = todo!.note;
    }

    return Scaffold(
      appBar: AppBar(
        title: todo == null
            ? const Text("Create Data")
            : const Text("Update Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: TextField(
                controller: title,
                decoration: const InputDecoration(labelText: "Tulis Title"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: TextField(
                controller: note,
                decoration: const InputDecoration(labelText: "Tulis Note"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (todo == null) {
                          todo = Todo(note.text, title.text);
                        } else {
                          todo!.title = title.text;
                          todo!.note = note.text;
                        }
                        Navigator.pop(context, todo);
                      },
                      child: const Text("Submit"),
                    ),
                  ),
                  Container(
                    width: 15,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Kembali"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
