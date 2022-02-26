import 'package:flutter/material.dart';
import 'package:joovlin/Provider/Query/get_todo_provider.dart';
import 'package:joovlin/Screen/add_todo_page.dart';
import 'package:joovlin/Screen/todo_details_page.dart';
import 'package:joovlin/Styles/color.dart';
import 'package:joovlin/Utils/router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List task = [];
  bool _isChecked = false;
  bool isFetched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        automaticallyImplyLeading: false,
      ),
      body: Consumer<GetTaskProvider>(builder: (context, getTask, child) {
        ///Check for isFetched condition to avoid multiple request to database
        if (isFetched == false) {
          ///Fetch the data
          getTask.getTask(true);

          Future.delayed(const Duration(seconds: 3), () => isFetched = true);
        }
        return RefreshIndicator(
          onRefresh: () {
            return Future.delayed(const Duration(seconds: 3));
          },
          color: primaryColor,
          child: getTask.getResponseData().isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Todo List is empty',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          PageNavigator(ctx: context)
                              .nextPage(page: const CreateTaskPage())
                              .then((value) {
                            if (value == '') {
                              setState(() {});
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
                                child: ListView(
                              children: List.generate(
                                  getTask.getResponseData().length, (index) {
                                Map data = getTask.getResponseData()[index];
                                print(data);
                                String taskId = data['id'];
                                String title = data['title'];
                                String description = data['description'];
                                bool isCompleted = data['isCompleted'];

                                final initial = isCompleted == true
                                    ? title.substring(0, 1).toUpperCase()
                                    : "${index + 1}";
                                return ListTile(
                                  onTap: () {
                                    PageNavigator(ctx: context)
                                        .nextPage(
                                            page: TaskDetailsPage(
                                      taskId: taskId,
                                      title: title,
                                      description: description,
                                    ))
                                        .then((value) {
                                      if (value == '') {
                                        setState(() {});
                                      }
                                    });
                                  },
                                  contentPadding: const EdgeInsets.all(0),
                                  title: Text(
                                    title,
                                    style: TextStyle(
                                      decoration: _isChecked
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Text(
                                    description,
                                    style: TextStyle(
                                      decoration: isCompleted == true
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  leading: CircleAvatar(
                                    backgroundColor:
                                        isCompleted == true ? green : amber,
                                    child: Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: CircleAvatar(
                                        backgroundColor: isCompleted == true
                                            ? lightGreen
                                            : lightAmber,
                                        child: Text(initial),
                                      ),
                                    ),
                                  ),
                                  trailing: Checkbox(
                                    onChanged: (value) {
                                      isCompleted = value!;
                                      setState(() {});
                                    },
                                    value: _isChecked,
                                    fillColor:
                                        MaterialStateProperty.resolveWith(
                                      (states) {
                                        return isCompleted == false
                                            ? grey
                                            : green;
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
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          PageNavigator(ctx: context)
              .nextPage(page: const CreateTaskPage())
              .then((value) {
            if (value == '') {
              print("dkkfdfdf");
              setState(() {});
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
