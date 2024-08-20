import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for date formatting

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Map<String, dynamic>> _tasks = [];

  Future<void> _sendDataToServer(String label, String description) async {
    final url = Uri.parse('http://192.168.66.170:9876/task/new');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'label': label,
          'description': description,
        }),
      );

      if (response.statusCode == 200) {
        print('Data sent successfully!');
      } else {
        print('Failed to send data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending data: $e');
    }
  }

  void _addTask(String label, String description, DateTime startDate, DateTime endDate) {
    if (label.isNotEmpty && description.isNotEmpty) {
      setState(() {
        _tasks.add({
          'label': label,
          'description': description,
          'startDate': startDate,
          'endDate': endDate,
        });
      });
      _sendDataToServer(label, description); // Send data to the server
    }
  }

  void _showAddTaskDialog() {
    final TextEditingController _labelController = TextEditingController();
    final TextEditingController _descriptionController = TextEditingController();
    DateTime? _startDate;
    DateTime? _endDate;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Task'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _labelController,
                  decoration: InputDecoration(hintText: 'Enter Title'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(hintText: 'Enter Description'),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        child: Text(_startDate == null
                            ? 'Select Start Date'
                            : 'Start Date: ${DateFormat('yyyy-MM-dd').format(_startDate!)}'),
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              _startDate = pickedDate;
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        child: Text(_endDate == null
                            ? 'Select End Date'
                            : 'End Date: ${DateFormat('yyyy-MM-dd').format(_endDate!)}'),
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              _endDate = pickedDate;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                if (_startDate != null && _endDate != null) {
                  _addTask(_labelController.text, _descriptionController.text, _startDate!, _endDate!);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    ).then((_) {
      _labelController.dispose();
      _descriptionController.dispose();
    });
  }

  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  void _updateTask(int index) {
    final TextEditingController _labelController = TextEditingController(text: _tasks[index]['label']);
    final TextEditingController _descriptionController = TextEditingController(text: _tasks[index]['description']);
    DateTime? _startDate = _tasks[index]['startDate'];
    DateTime? _endDate = _tasks[index]['endDate'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Task'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _labelController,
                  decoration: InputDecoration(hintText: 'Enter Title'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(hintText: 'Enter Description'),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        child: Text(_startDate == null
                            ? 'Select Start Date'
                            : 'Start Date: ${DateFormat('yyyy-MM-dd').format(_startDate!)}'),
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              _startDate = pickedDate;
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        child: Text(_endDate == null
                            ? 'Select End Date'
                            : 'End Date: ${DateFormat('yyyy-MM-dd').format(_endDate!)}'),
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              _endDate = pickedDate;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Update'),
              onPressed: () {
                if (_startDate != null && _endDate != null) {
                  setState(() {
                    _tasks[index] = {
                      'label': _labelController.text,
                      'description': _descriptionController.text,
                      'startDate': _startDate,
                      'endDate': _endDate,
                    };
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    ).then((_) {
      _labelController.dispose();
      _descriptionController.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showAddTaskDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _tasks.map((task) {
            return SizedBox(
              width: 300, // Medium size for the card
              height: 350, // Adjust height for a medium-sized card
              child: Card(
                margin: EdgeInsets.all(10),
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task['label'] ?? 'No Title',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        task['description'] ?? 'No Description',
                        style: TextStyle(color: Colors.indigo),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Start Date: ${task['startDate'] != null ? DateFormat('yyyy-MM-dd').format(task['startDate']) : 'Not Set'}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Text(
                        'End Date: ${task['endDate'] != null ? DateFormat('yyyy-MM-dd').format(task['endDate']) : 'Not Set'}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _removeTask(_tasks.indexOf(task)),
                          ),
                          IconButton(
                            icon: Icon(Icons.update),
                            onPressed: () => _updateTask(_tasks.indexOf(task)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
