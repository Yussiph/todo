import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: Task()));
  }
}

class Task extends StatefulWidget {
  const Task({super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    final sch = MediaQuery.sizeOf(context).height;
    final scw = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => print("hello world"), icon: Icon(Icons.sunny),),
      ),
      body: Center(
        child: Container(
          width: scw * 0.71,
          height: sch * 0.06,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: BoxBorder.all(color: Colors.black, width: 1),
            color: Color.fromRGBO(240, 240, 240, 1),
          ),
        ),
      ),
    );
  }
}
