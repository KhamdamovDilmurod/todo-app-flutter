class TodoModel{
  int? id;
  String name;
  String description;
  String time;
  String location;
  int priority;

  TodoModel(this.name, this.description, this.time, this.location, this.priority) : id = null;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'id': id,
      'name': name,
      'description': description,
      'time': time,
      'location': location,
      'priority': priority,
    };
    return map;
  }

  TodoModel.fromMap(Map<String, Object?> map)
      : id = (map['id'] as int?)!,
        name = (map['name'] as String?)!,
        description = (map['description'] as String?)!,
        time = (map['time'] as String?)!,
        location = (map['location'] as String?)!,
        priority = (map['priority'] as int?)!;
}