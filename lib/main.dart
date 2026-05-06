import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
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
    ChangeNotifierProvider(
      create: (context) => TaskProvider(isar),
      child: const MainApp(),
    ),
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
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      builder: FToastBuilder(),
      home: Scaffold(
        // appbar: appbar(
        //   leading: iconbutton(
        //     onpressed: () => print("hello world"),
        //     icon: icon(icons.sunny),
        //   ),
        // ),
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 50),
            child: Center(
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.8,
                child: Column(
                  // I don't think this is needed.
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Completion(),
                    SizedBox(height: 30),
                    AddTask(),
                    SizedBox(height: 30),
                    Expanded(child: TodosList()),
                  ],
                ),
              ),
            ),
          ),
        ),
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
    print(
      "This is the something that needs to be rebuilt: ${taskProvider.count}",
    );
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
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                child: Text(
                  "$completedCount/${taskProvider.count}",
                  key: UniqueKey(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddTask extends StatefulWidget {
  AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  late FToast fToast;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  submit(TextEditingController todo, BuildContext context) {
    if (todo.text.trim().length <= 100 && todo.text.trim().isNotEmpty) {
      final newTask = Task()
        ..todo = todo.text.trim()
        ..isChecked = false;
      context.read<TaskProvider>().addAndUpdateTask(newTask);
      todo.clear();
    } else {
      fToast.showToast(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          decoration: BoxDecoration(
            color: LightMode.accent1,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text("Empty", style: TextStyle(color: Colors.white)),
        ),
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(milliseconds: 1500),
      );
    }
  }

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
                // to make enter submits.
                minLines: 1,
                maxLines: null,
                keyboardType: TextInputType.text,
                controller: _textEditingController,
                inputFormatters: [LengthLimitingTextInputFormatter(100)],
                cursorColor: LightMode.accent1,
                cursorWidth: 3,
                decoration: InputDecoration(
                  hintText: "New task",
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  border: InputBorder.none,
                ),
                onSubmitted: (_) => submit(_textEditingController, context),
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
              onPressed: () => submit(_textEditingController, context),
              icon: Icon(Icons.add_rounded, size: 28),
              color: LightMode.background,
              style: ButtonStyle(),
            ),
          ),
        ],
      ),
    );
  }
}

class TodoItem extends StatelessWidget {
  final Task task;
  TodoItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final sch = MediaQuery.sizeOf(context).height;
    final scw = MediaQuery.sizeOf(context).width;

    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        constraints: BoxConstraints(minHeight: sch * 0.07),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: BoxBorder.all(color: LightMode.accent2, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Checkbox(
                    checkColor: Colors.green,
                    value: task.isChecked,
                    onChanged: (bool? value) {
                      task.isChecked = value ?? false;
                      context.read<TaskProvider>().addAndUpdateTask(task);
                    },
                  ),
                  Expanded(
                    child: AnimatedDefaultTextStyle(
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        decoration: task.isChecked
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                      duration: Duration(milliseconds: 200),
                      child: Text(task.todo),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    task.todo = "Updated";
                    context.read<TaskProvider>().addAndUpdateTask(task);
                  },
                  icon: Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    context.read<TaskProvider>().deleteTask(task);
                  },
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TodosList extends StatelessWidget {
  TodosList({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();
    final todos = taskProvider.taskList;

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return TodoItem(task: todos[index]);
      },
    );
  }
}