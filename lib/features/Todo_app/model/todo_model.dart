class Todo {
  final String id;
  final String title;
  final bool isComplete;
  Todo({required this.id,  this.isComplete = false, required this.title});
  Todo copyWith({String? title, bool? isComplete}) {
    return Todo(
      id: id,
      isComplete: isComplete ?? this.isComplete,
      title: title ?? this.title,
    );
  }
}
