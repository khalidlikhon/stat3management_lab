import 'package:flutter/material.dart';

class TODOApp extends StatefulWidget {
  const TODOApp({super.key});

  @override
  State<TODOApp> createState() => _TODOAppState();
}

class _TODOAppState extends State<TODOApp> {
  List<TodoItem> todoList = [];

  void _addTodoTask(String task) {
    if (task.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ Please enter a task before adding.'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      todoList.add(TodoItem(task: task.trim(), isCompleted: false));
    });
  }

  void _deleteTask(int index) {
    setState(() {
      todoList.removeAt(index);
    });
  }

  void _toggleComplete(int index, bool? value) {
    setState(() {
      todoList[index].isCompleted = value ?? false;
    });
  }

  void _addNewTask(TextEditingController controller) {
    final taskText = controller.text.trim();
    if (taskText.isNotEmpty) {
      _addTodoTask(taskText);
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ Please enter a task before adding.'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'To-Do App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: const Divider(height: 1, color: Colors.grey),
          ),

          // Main content
          Expanded(
            child: todoList.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.list_alt, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No Tasks Yet!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Add a task by clicking the "+" button below.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                final task = todoList[index];
                return Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // More rounded for a soft look
                  ),
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16), // Narrower, more elegant spacing
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Better spacing
                    leading: Checkbox(
                      value: task.isCompleted,
                      activeColor: Colors.teal,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), // Squared-off checkbox
                      onChanged: (value) => _toggleComplete(index, value),
                    ),
                    title: Text(
                      task.task,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                        color: task.isCompleted ? Colors.grey : Colors.black,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                      onPressed: () => _deleteTask(index),
                    ),
                  ),
                );




              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskSheet,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),

    );
  }


  void _showAddTaskSheet() {
    final TextEditingController _taskController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Add New Task',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _taskController,
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Task name',
                labelStyle: const TextStyle(
                  color: Colors.teal,
                  fontStyle: FontStyle.italic,
                ),
                hintText: 'What needs to be done?',
                hintStyle: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
                filled: true,
                fillColor: Color(0xffF5F9FA),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.teal, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.teal, width: 1),
                ),
              ),
              onSubmitted: (_) => _addNewTask(_taskController),
            ),


            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _addNewTask(_taskController),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Add Task'),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

}



class TodoItem {
  String task;
  bool isCompleted;

  TodoItem({
    required this.task,
    this.isCompleted = false,
  });
}
