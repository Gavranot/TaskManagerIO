class Task {
  String name;
  String description;
  double priority;
  DateTime? deadline;
  bool done;

  Task({
    required this.name,
    required this.description,
    required this.priority,
    required this.deadline,
    required this.done
  });
}


class User {
  String name;
  String password;
  String email;
  String about;
  String path_to_avatar;
  List<Task> tasks;

  User({
    required this.name,
    required this.password,
    required this.email,
    required this.path_to_avatar,
    required this.about,
    required this.tasks,
  });

}
