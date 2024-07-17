class Todo {
  int? _id;
  String? _title;
  String? _note;

  Todo(this._note, this._title);

  Todo.fromMap(Map<String, dynamic> map) {
    _id = map["id"];
    _title = map["title"];
    _note = map["note"];
  }

  int get id => _id!;
  String get title => _title!;
  String get note => _note!;

  set title(String value) {
    _title = value;
  }

  set note(String value) {
    _note = value;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map["id"] = _id;
    map["title"] = title;
    map["note"] = note;

    return map;
  }
}
