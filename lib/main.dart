import 'dart:ui';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }
}

class Task {
  String title;
  DateTime deadline;

  Task({required this.title, required this.deadline});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List todoApp = [];
  String singlevalue = "";
  final TextEditingController _taskTitleController = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          _selectedDate = DateTime(
            picked.year,
            picked.month,
            picked.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  addString(content) {
    setState(() {
      singlevalue = content;
    });
  }

  void _addTask() {
    if (_taskTitleController.text.isNotEmpty && _selectedDate != null) {
      Task newTask = Task(
        title: _taskTitleController.text,
        deadline: _selectedDate!,
      );
      // Add the task to your task list
      print('Task: ${newTask.title}, Deadline: ${newTask.deadline}');
    }
  }

  addList() {
    setState(() {
      todoApp.add({"value": singlevalue});
    });
  }

  deleteItem(index) {
    setState(() {
      todoApp.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 243, 172, 142),
        title: Text('TO DO APPLICATION',
            style: GoogleFonts.play(fontStyle: FontStyle.italic)),
        centerTitle: true,
        toolbarHeight: 50,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            print('Icon Button pressed');
          },
        ),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
                flex: 90,
                child: ListView.builder(
                    itemCount: todoApp.length,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: Container(
                            margin: EdgeInsets.only(left: 20),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 80,
                                  child: Text(
                                    todoApp[index]['value'].toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                
                               
                                Expanded(
                                    flex: 20,
                                    child: CircleAvatar(
                                      radius: 40,
                                      child: TextButton(
                                        onPressed: () {
                                          deleteItem(index);
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )),

                                    
                              ],
                            ),
                            
                            
                          ),
                        ),
                        
                        
                      );

                      
                    })),
                     Row(
                                  children: [
                                    Text(_selectedDate == null
                                        ? 'No Deadline Chosen!'
                                        : 'Deadline: ${DateFormat.yMMMd().add_jm().format(_selectedDate!)}'),
                                    Spacer(),
                                    ElevatedButton(
                                      onPressed: () => _selectDate(context),
                                      child: Text('Choose Deadline'),
                                    ),
                                  ],
                                ),
            Expanded(
                flex: 10,
                child: Row(
                  children: [
                    Expanded(
                      flex: 70,
                      child: Container(
                        height: 40,
                        child: TextFormField(
                          onChanged: (content) {
                            addString(content);
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              fillColor: Color.fromARGB(255, 244, 169, 137),
                              filled: true,
                              labelText: 'Enter Task...',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: SizedBox(
                          width: 5,
                        )),
                    Expanded(
                        flex: 27,
                        child: ElevatedButton(
                          onPressed: () {
                            addList();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 244, 169, 137)),
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Text('ADD',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        )),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
