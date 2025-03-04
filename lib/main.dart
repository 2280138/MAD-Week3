import 'package:flutter/material.dart';

class TodoItem extends StatefulWidget {
  final String todoTask;
  final bool isDone;

  const TodoItem({required this.isDone, required this.todoTask, super.key});

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late String todoTask;
  late bool isDone;

  @override
  void initState() {
    super.initState();
    todoTask = widget.todoTask;
    isDone = widget.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      child: ListTile(
        title: Text(
          todoTask,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            decoration: isDone ? TextDecoration.lineThrough : null,
            color: isDone ? Colors.grey : Colors.black,
          ),
        ),
        trailing: Checkbox(
          value: isDone,
          onChanged: (value) {
            setState(() {
              isDone = value!;
            });
          },
        ),
      ),
    );
  }
}

class TodoListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> tasks = [
    {'task': 'Complete Flutter Assignment', 'isDone': false},
    {'task': 'Buy Groceries', 'isDone': true},
    {'task': 'Organize Closet', 'isDone': false},
    {'task': 'Read a Book', 'isDone': false},
  ];

  @override
  Widget build(BuildContext context) {
    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(title: const Text("To-Do List")),
      body: isLandscape ? _buildLandscapeView() : _buildPortraitView(),
    );
  }

  Widget _buildPortraitView() {
    return PageView(
      children: [
        _buildProfileSection(),
        _buildTaskList(),
      ],
    );
  }

  Widget _buildLandscapeView() {
    return Row(
      children: [
        Expanded(flex: 2, child: _buildProfileSection()),
        Expanded(flex: 3, child: _buildTaskList()),
      ],
    );
  }

  Widget _buildProfileSection() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(radius: 80, child: Icon(Icons.person, size: 80)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            child: const Text("To-Do List"),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TodoItem(
          todoTask: tasks[index]['task'],
          isDone: tasks[index]['isDone'],
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TodoListScreen(),
  ));
}
