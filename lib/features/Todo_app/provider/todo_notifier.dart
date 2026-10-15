import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/todo_model.dart';

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier() : super([]);

  void addTodo(String title){
    final newTodo = Todo(id: DateTime.now().toString(), title: title);
    state = [...state, newTodo];
  }

  void removeTodo(String id){
    state = state.where((todo) => todo.id != id).toList();
  }

  void toggleComplete(String id){
    state = [
      for (final todo in state)
        if(todo.id == id)
          todo.copyWith(isComplete: !todo.isComplete)
        else
          todo
    ];
  }
}

final todoProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref){
  return TodoNotifier();
});