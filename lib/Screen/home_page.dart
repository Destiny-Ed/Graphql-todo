import 'package:flutter/material.dart';
import 'package:joovlin/Screen/add_todo_page.dart';
import 'package:joovlin/Screen/todo_details_page.dart';
import 'package:joovlin/Styles/color.dart';
import 'package:joovlin/Utils/router.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List task = [];
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 3));
        },
        color: primaryColor,
        child: task.isNotEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Todo List is empty',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        PageNavigator(ctx: context)
                            .nextPage(page: const CreateTaskPage());
                      },
                      child: Text(
                        'Create a task',
                        style: TextStyle(fontSize: 18, color: grey),
                      ),
                    ),
                  ],
                ),
              )
            : CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Expanded(
                              child: ListView(
                            children: List.generate(4, (index) {
                              final initial = _isChecked
                                  ? "Meeting with john"
                                      .substring(0, 1)
                                      .toUpperCase()
                                  : "${index + 1}";
                              return ListTile(
                                onTap: () {
                                  PageNavigator(ctx: context).nextPage(
                                      page: TaskDetailsPage(
                                    taskId: index.toString(),
                                    title: 'Meeting with john',
                                    description: 'Hello world',
                                  ));
                                },
                                contentPadding: const EdgeInsets.all(0),
                                title: Text(
                                  "Meeting with john",
                                  style: TextStyle(
                                    decoration: _isChecked
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  "meet with john to discuss the list of required stuff",
                                  style: TextStyle(
                                    decoration: _isChecked
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                leading: CircleAvatar(
                                  backgroundColor: _isChecked ? green : amber,
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: CircleAvatar(
                                      backgroundColor:
                                          _isChecked ? lightGreen : lightAmber,
                                      child: Text(initial),
                                    ),
                                  ),
                                ),
                                trailing: Checkbox(
                                  onChanged: (value) {
                                    _isChecked = value!;
                                    setState(() {});
                                  },
                                  value: _isChecked,
                                  fillColor: MaterialStateProperty.resolveWith(
                                    (states) {
                                      return _isChecked == false ? grey : green;
                                    },
                                  ),
                                ),
                              );
                            }),
                          )),
                          const SizedBox(height: 150),
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          PageNavigator(ctx: context).nextPage(page: const CreateTaskPage());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
