import 'package:flutter/material.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Tasks')),
      // drawer: const AppDrawer(),
      body: const Center(child: Text('Manage your Tasks')),
    );
  }
}
