import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_application/screens/email_auth/login_screen.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _toDoController = TextEditingController();
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  final DateTime _currentDate = DateTime.now();

  void logOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => LoginScreen()));
  }

  void _addToDoItem() {
    String task = _toDoController.text.trim();
    if (task.isNotEmpty) {
      Map<String, dynamic> userTask = {
        "task": task,
        "timestamp": FieldValue.serverTimestamp(),
      };
      FirebaseFirestore.instance.collection("users").add(userTask);
      _toDoController.clear();
    }
  }

  void _deleteTask(String docId) {
    FirebaseFirestore.instance.collection("users").doc(docId).delete();
  }

  void _filterTasks(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "To-Do List",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            onPressed: logOut,
            icon: const Icon(Icons.exit_to_app, color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Display current date
            Text(
              DateFormat('EEEE, MMMM d, yyyy').format(_currentDate),
              style: TextStyle(fontSize: 18, color: Colors.blueGrey),
            ),
            const SizedBox(height: 20),

            // Search Bar
            TextField(
              controller: _searchController,
              onChanged: _filterTasks,
              decoration: InputDecoration(
                labelText: 'Search tasks',
                prefixIcon: Icon(Icons.search, color: Colors.blueAccent),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Add Task Bar
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _toDoController,
                    decoration: InputDecoration(
                      labelText: 'Enter a task',
                      labelStyle: TextStyle(color: Colors.blueAccent),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addToDoItem,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Add",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Expanded StreamBuilder to show tasks list
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("users").orderBy("timestamp").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData && snapshot.data != null) {
                      final filteredDocs = snapshot.data!.docs.where((doc) {
                        final data = doc.data() as Map<String, dynamic>;
                        final task = data["task"] ?? "";
                        return task.toLowerCase().contains(_searchQuery);
                      }).toList();

                      if (filteredDocs.isEmpty) {
                        return const Center(
                          child: Text(
                            "No matching tasks found!",
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: filteredDocs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> userMap = filteredDocs[index].data() as Map<String, dynamic>;
                          return Card(
                            color: Colors.grey[100],
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              title: Text(
                                userMap["task"] ?? "No Task",
                                style: TextStyle(fontSize: 18, color: Colors.blueGrey[800]),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  _deleteTask(filteredDocs[index].id);
                                },
                                icon: Icon(Icons.delete, color: Colors.redAccent),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text(
                          "No tasks added yet!",
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      );
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
} 