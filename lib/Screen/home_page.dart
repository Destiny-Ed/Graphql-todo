import 'package:flutter/material.dart';
import 'package:joovlin/Provider/Mutations/update_todo_provider.dart';
import 'package:joovlin/Provider/Query/get_todo_provider.dart';
import 'package:joovlin/Screen/add_todo_page.dart';
import 'package:joovlin/Screen/task_view_container.dart';
import 'package:joovlin/Styles/color.dart';
import 'package:joovlin/Utils/router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isFetched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        automaticallyImplyLeading: false,
      ),
      body: Consumer2<GetTaskProvider, UpdateTaskProvider>(
          builder: (context, getTask, updateTask, child) {
        ///Check for isFetched condition to avoid multiple request to database
        if (isFetched == false) {
          ///Fetch the data
          getTask.getTask(true);

          Future.delayed(const Duration(seconds: 3), () => isFetched = true);
        }
        return getTask.getResponseData().isEmpty
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
                            .nextPage(page: const CreateTaskPage())
                            .then((value) {
                          if (value == '') {
                            ///Fetch latest data
                            getTask.getTask(false);
                          }
                        });
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
                              child: RefreshIndicator(
                            onRefresh: () {
                              getTask.getTask(false);

                              return Future.delayed(const Duration(seconds: 3));
                            },
                            color: primaryColor,
                            child: ListView(
                              children: [
                                ///Not completed
                                ...List.generate(
                                    getTask
                                        .getResponseData()
                                        .where((element) =>
                                            element['isCompleted'] == false)
                                        .length, (index) {
                                  Map data = getTask
                                      .getResponseData()
                                      .where((element) =>
                                          element['isCompleted'] == false)
                                      .toList()[index];
                                  String taskId = data['id'];
                                  String title = data['title'];
                                  String description = data['description'];
                                  bool isCompleted = data['isCompleted'];

                                  final initial = "${index + 1}";
                                  return TaskField(
                                    initial: initial,
                                    title: title,
                                    taskId: taskId,
                                    subtitle: description,
                                    isCompleted: isCompleted,
                                  );
                                }),

                                ///Completed
                                ...List.generate(
                                    getTask
                                        .getResponseData()
                                        .where((element) =>
                                            element['isCompleted'] == true)
                                        .length, (index) {
                                  Map data = getTask
                                      .getResponseData()
                                      .where((element) =>
                                          element['isCompleted'] == true)
                                      .toList()[index];
                                  String taskId = data['id'];
                                  String title = data['title'];
                                  String description = data['description'];
                                  bool isCompleted = data['isCompleted'];

                                  final initial =
                                      title.substring(0, 1).toUpperCase();
                                  return TaskField(
                                    initial: initial,
                                    title: title,
                                    taskId: taskId,
                                    subtitle: description,
                                    isCompleted: isCompleted,
                                  );
                                }),
                              ],
                            ),
                          )),
                          const SizedBox(height: 150),
                        ],
                      ),
                    ),
                  )
                ],
              );
      }),
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {
          PageNavigator(ctx: context)
              .nextPage(page: const CreateTaskPage())
              .then((value) {
            if (value == '') {
              ///refetch data
              Provider.of<GetTaskProvider>(context, listen: false)
                  .getTask(false);
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
