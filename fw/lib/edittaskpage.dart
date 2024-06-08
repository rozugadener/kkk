import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditTaskPage extends StatefulWidget {
  final String taskId;
  final String initialTitle;
  final String initialDescription;

  const EditTaskPage({super.key, required this.taskId, required this.initialTitle, required this.initialDescription});

  @override
  _EditTaskPageState createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _descriptionController =
        TextEditingController(text: widget.initialDescription);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteTask(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () => _updateTask(context),
              child: const Text('Update Task'),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteTask(BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('tasks')
          .doc(widget.taskId)
          .delete();
      Navigator.pop(context);
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting task: $e');
      }
    }
  }

  void _updateTask(BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('nguts').doc(
          "MinNF4iVqFfEA8WRhyow").update({
        'name': _titleController.text,
        // Giá trị của trường "name" là nội dung của TextField tiêu đề
        'description': _descriptionController.text,
        // Giá trị của trường "description" là nội dung của TextField mô tả
      });
      Navigator.pop(context);
    } catch (e) {
      if (kDebugMode) {
        print('Error updating task: $e');
      }
    }
  }
}
