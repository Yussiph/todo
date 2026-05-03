import 'package:flutter/material.dart';
import 'package:todo/Themes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => print("hello world"),
            icon: Icon(Icons.sunny),
          ),
        ),
        body: Center(
          child: Container(
            width: MediaQuery.sizeOf(context).width * 0.8,
            child: Column(
              children: [Completion(), SizedBox(height: 30), Task()],
            ),
          ),
        ),
      ),
    );
  }
}

class Task extends StatefulWidget {
  const Task({super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool? _toggle = false;
  @override
  Widget build(BuildContext context) {
    final sch = MediaQuery.sizeOf(context).height;
    final scw = MediaQuery.sizeOf(context).width;

    return Center(
      child: Container(
        height: sch * 0.07,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: BoxBorder.all(color: LightMode.accent2, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  checkColor: Colors.green,
                  value: _toggle,
                  onChanged: (bool? value) {
                    setState(() {
                      _toggle = value;
                    });
                  },
                ),
                Text("data"),
              ],
            ),
            Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Completion extends StatefulWidget {
  Completion({super.key});

  @override
  State<Completion> createState() => _CompletionState();
}

class _CompletionState extends State<Completion> {
  @override
  Widget build(BuildContext context) {
    final sch = MediaQuery.sizeOf(context).height;
    final scw = MediaQuery.sizeOf(context).width;

    return Container(
      height: sch * 0.2,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("Todo's Done"),
          Container(
            width: 0.14 * sch,
            height: 0.14 * sch,
            decoration: BoxDecoration(
              color: LightMode.accent1,
              shape: BoxShape.circle,
            ),
            child: Center(child: Text("1/3", style: TextStyle(color: Colors.white),),),
          ),
        ],
      ),
    );
  }
}
