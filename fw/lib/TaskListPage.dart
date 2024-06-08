import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('nguts').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              return ListTile(
                title: Text(data['name'] ?? 'No title'),
                subtitle: Text(data['description'] ?? 'No description'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteTask(context, document.id),
                ),
                onTap: () => _navigateToEditTaskPage(context, document.id, data['title'] ?? '', data['description'] ?? ''),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddTaskPage(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _deleteTask(BuildContext context, String taskId) async {
    try {
      await FirebaseFirestore.instance.collection('tasks').doc(taskId).delete();
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting task: $e');
      }
    }
  }

  void _navigateToAddTaskPage(BuildContext context) {
    Navigator.pushNamed(context, '/edittaskpage');
  }

  void _navigateToEditTaskPage(BuildContext context, String taskId, String initialTitle, String initialDescription) {
    Navigator.pushNamed(
      context,
      '/editTask',
      arguments: {
        'taskId': taskId,
        'initialTitle': initialTitle,
        'initialDescription': initialDescription,
      },
    );
  }
}
