class TodoResponse {
  List<Todo>? todos;
  int? total;
  int? skip;
  int? limit;

  TodoResponse({
    required this.todos,
    required this.total,
    required this.skip,
    required this.limit,
  });

  TodoResponse.fromJson(Map<String, dynamic> json) {
    todos = (json['todos'] as List<dynamic>)
        .map((todoJson) => Todo.fromJson(todoJson))
        .toList();
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }
}

class Todo {
  int? id;
  String? todo;
  bool? completed;
  int? userId;

  Todo({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });

  Todo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    todo = json['todo'];
    completed = json['completed'];
    userId = json['userId'];
  }
}