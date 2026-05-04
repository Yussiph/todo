import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Themes.dart';

import 'package:todo/collections/Task.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar_community/isar.dart';

import 'package:todo/services/isar_setup.dart';
import 'package:todo/repositories/task_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initIsar();
  runApp(
    ChangeNotifierProvider(create: (context) => TaskProvider(isar),
    child: const MainApp(),
  )
  );
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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appbar: appbar(
        //   leading: iconbutton(
        //     onpressed: () => print("hello world"),
        //     icon: icon(icons.sunny),
        //   ),
        // ),
        body: Center(
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Completion(),
                SizedBox(height: 30),
                AddTask(),
                SizedBox(height: 30),
                TodoItem(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TodoItem extends StatelessWidget{
  TodoItem({super.key});

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
                  onChanged: (bool? value) { },
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

class AddTask extends StatelessWidget {
  AddTask({super.key});

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final sch = MediaQuery.sizeOf(context).height;
    final scw = MediaQuery.sizeOf(context).width;

    return Container(
      constraints: BoxConstraints(minHeight: sch * 0.05),
      width: scw * 0.8,
      // decoration: BoxDecoration(color: Colors.red),
      child: Row(
        children: [
          Expanded(
            flex: 8,
            child: Container(
              decoration: BoxDecoration(
                color: LightMode.secondary,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: null,
                controller: _textEditingController,
                decoration: InputDecoration(
                  hintText: "New task",
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: LightMode.accent1,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                final newTask = Task()
                  ..todo = _textEditingController.text.trim()
                  ..isChecked = false;
                context.read<TaskProvider>().addAndUpdateTask(newTask);
                _textEditingController.clear();
              },
              icon: Icon(Icons.add),
              color: LightMode.background,
              style: ButtonStyle(),
            ),
          ),
        ],
      ),
    );
  }
}

class Completion extends StatelessWidget {

  const Completion({super.key});

  @override
  Widget build(BuildContext context) {
    final sch = MediaQuery.sizeOf(context).height;
    final scw = MediaQuery.sizeOf(context).width;
    final taskProvider = context.watch<TaskProvider>();
    final count = taskProvider.count;
    final completedCount = taskProvider.completedCount;

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
            child: Center(
              child: Text(
                "$completedCount/$count",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
