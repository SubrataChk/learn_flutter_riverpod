import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/features/Todo_app/provider/todo_notifier.dart';

class TodoScreen extends ConsumerStatefulWidget {
  const TodoScreen({super.key});

  @override
  ConsumerState<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends ConsumerState<TodoScreen> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todoProvider);
    return Scaffold(
      appBar: AppBar(title: Text("Todo List")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        hintText: "Enter a new todo",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ActionChip(
                    label: Text("Add"),
                    onPressed: () {
                      if (textEditingController.text.trim().isEmpty) return;
                      ref
                          .read(todoProvider.notifier)
                          .addTodo(textEditingController.text.trim());
                      textEditingController.clear();
                    },
                  ),
                ],
              ),
              Expanded(
                child: todos.isEmpty
                    ? Center(child: Text("No data found"))
                    : ListView.builder(
                        itemCount: todos.length,
                        itemBuilder: (context, index) {
                          final todo = todos[index];
                          return ListTile(
                            leading: Checkbox(
                              value: todo.isComplete,
                              onChanged: (value) {
                                ref.watch(todoProvider.notifier).toggleComplete(todo.id);
                              },
                            ),
                            title: Text(
                              todo.title,
                              style: TextStyle(
                                fontSize: 20,
                                decoration: todo.isComplete
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                ref.watch(todoProvider.notifier).removeTodo(todo.id);
                              },
                              icon: Icon(Icons.delete),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
