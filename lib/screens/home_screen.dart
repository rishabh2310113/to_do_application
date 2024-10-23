import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_application/screens/email_auth/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void logOut() async{

    await FirebaseAuth.instance.signOut();
     Navigator.popUntil(context, (route)=>route.isFirst);
     Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => LoginScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
          title: Text("Home"),
          actions: [
            IconButton(
              onPressed: (){
                logOut();
              },
               icon: Icon(Icons.exit_to_app),
               )
          ],
         ),
    );
  }
}

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Simple To-Do App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: TodoApp(),
//     );
//   }
// }

// class TodoApp extends StatefulWidget {
//   @override
//   _TodoAppState createState() => _TodoAppState();
// }

// class _TodoAppState extends State<TodoApp> {
//   final TextEditingController _taskController = TextEditingController();
//   List<String> _tasks = [];
//   List<bool> _completed = [];

//   // Function to add a new task
//   void _addTask() {
//     if (_taskController.text.isNotEmpty) {
//       setState(() {
//         _tasks.add(_taskController.text);
//         _completed.add(false); // By default, the task is not completed
//       });
//       _taskController.clear();
//     }
//   }

//   // Function to remove a task
//   void _removeTask(int index) {
//     setState(() {
//       _tasks.removeAt(index);
//       _completed.removeAt(index);
//     });
//   }

//   // Function to mark a task as completed
//   void _toggleCompletion(int index) {
//     setState(() {
//       _completed[index] = !_completed[index];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('To-Do App'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             TextField(
//               controller: _taskController,
//               decoration: InputDecoration(
//                 labelText: 'Enter a task',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: _addTask,
//               child: Text('Add Task'),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: _tasks.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(
//                       _tasks[index],
//                       style: TextStyle(
//                         decoration: _completed[index]
//                             ? TextDecoration.lineThrough
//                             : TextDecoration.none,
//                       ),
//                     ),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: Icon(
//                             _completed[index]
//                                 ? Icons.check_box
//                                 : Icons.check_box_outline_blank,
//                           ),
//                           onPressed: () => _toggleCompletion(index),
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.delete),
//                           onPressed: () => _removeTask(index),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
