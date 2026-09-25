import 'package:flutter/material.dart';

void main() {
  runApp(const TodoApp());
}

// Simple Model Class for a Todo Item
class Todo {
  String title;
  bool isCompleted;

  Todo({
    required this.title,
    this.isCompleted = false,
  });
}

// Root application widget
class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo List',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF6F8FA),
      ),
      home: const TodoListScreen(),
    );
  }
}

// StatefulWidget for the Todo List screen to manage state
class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  // Controller to read and clear input from the TextField
  final TextEditingController _taskController = TextEditingController();

  // List to store all Todo items
  final List<Todo> _todos = [
    Todo(title: 'Complete Flutter Assignment', isCompleted: false),
    Todo(title: 'Learn StatefulWidget', isCompleted: true),
    Todo(title: 'Practice setState()', isCompleted: false),
  ];

  // Function 1: Add a new Todo item
  void _addTodo() {
    final String enteredTask = _taskController.text.trim();

    // Do not allow empty tasks to be added
    if (enteredTask.isEmpty) {
      return;
    }

    // setState() notifies Flutter that state has changed and re-renders the UI
    setState(() {
      _todos.add(Todo(title: enteredTask));
    });

    // Clear the TextField after adding the task
    _taskController.clear();
  }

  // Function 2: Toggle completed / incomplete status
  void _toggleTodoStatus(int index) {
    setState(() {
      _todos[index].isCompleted = !_todos[index].isCompleted;
    });
  }

  // Function 3: Delete a Todo item from the list
  void _deleteTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final completedCount = _todos.where((t) => t.isCompleted).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Todo List',
          style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.5),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.indigo.shade900,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey.shade200,
            height: 1.0,
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Input Area: Rounded Container with TextField and Add Button
                Container(
                  padding: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _taskController,
                          decoration: InputDecoration(
                            hintText: 'Enter a task...',
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            prefixIcon: const Icon(Icons.add_task_rounded, color: Colors.indigo),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                          ),
                          onSubmitted: (_) => _addTodo(),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: _addTodo,
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text(
                          'Add',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Summary Row / Header
                if (_todos.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tasks (${_todos.length})',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.indigo.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '$completedCount of ${_todos.length} done',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.indigo.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 8),

                // Display List of Todo Items
                Expanded(
                  child: _todos.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.task_alt_rounded,
                                size: 64,
                                color: Colors.grey.shade300,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'All caught up!',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Add a task above to get started.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: _todos.length,
                          itemBuilder: (context, index) {
                            final todo = _todos[index];
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                color: todo.isCompleted
                                    ? const Color(0xFFF0F2F5)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: todo.isCompleted
                                      ? Colors.grey.shade300
                                      : Colors.grey.shade200,
                                ),
                                boxShadow: todo.isCompleted
                                    ? []
                                    : [
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0.02),
                                          blurRadius: 6,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                // Checkbox to mark complete/incomplete
                                leading: Transform.scale(
                                  scale: 1.1,
                                  child: Checkbox(
                                    activeColor: Colors.indigo,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    value: todo.isCompleted,
                                    onChanged: (_) => _toggleTodoStatus(index),
                                  ),
                                ),
                                // Task title with strikethrough when completed
                                title: Text(
                                  todo.title,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: todo.isCompleted
                                        ? FontWeight.normal
                                        : FontWeight.w500,
                                    decoration: todo.isCompleted
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                    decorationColor: Colors.grey.shade500,
                                    color: todo.isCompleted
                                        ? Colors.grey.shade500
                                        : Colors.grey.shade900,
                                  ),
                                ),
                                // Delete button to remove task
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.redAccent,
                                    size: 22,
                                  ),
                                  tooltip: 'Delete task',
                                  splashRadius: 20,
                                  onPressed: () => _deleteTodo(index),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
