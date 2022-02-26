import 'package:flutter/material.dart';
import 'package:joovlin/Provider/Mutations/add_todo_provider.dart';
import 'package:joovlin/Screen/Resuable_Widgets/button.dart';
import 'package:joovlin/Screen/Resuable_Widgets/text_field.dart';
import 'package:joovlin/Styles/color.dart';
import 'package:joovlin/Utils/snack_bar.dart';
import 'package:provider/provider.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({Key? key}) : super(key: key);

  @override
  _CreateTaskPageState createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();

  ///Validation Variables for textfield
  bool _isTitleComplete = false;
  bool _isDescriptionComplete = false;

  @override
  void dispose() {
    _title.clear();
    _description.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Task')),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  customTextField(
                    title: 'Title',
                    controller: _title,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        _isTitleComplete = false;
                      } else {
                        _isTitleComplete = true;
                      }
                      setState(() {});
                    },
                    hint: 'What do you want to do?',
                  ),

                  ///Description field
                  customTextField(
                      title: 'Description',
                      controller: _description,
                      onChanged: (value) {
                        if (value.isEmpty) {
                          _isDescriptionComplete = false;
                        } else {
                          _isDescriptionComplete = true;
                        }
                        setState(() {});
                      },
                      hint: 'Describe your task?',
                      maxLines: 4),

                  Consumer<AddTaskProvider>(builder: (context, addTask, child) {
                    WidgetsBinding.instance!.addPostFrameCallback((_) {
                      if (addTask.getResponse != '') {
                        showMessage(
                            message: addTask.getResponse, context: context);
                      }
                    });
                    return customButton(
                      status: addTask.getStatus,
                      tap: () {
                        ///Save Task to database
                        addTask.addTask(
                            ctx: context,
                            title: _title.text.trim(),
                            description: _description.text.trim());
                      },
                      isValid: _isTitleComplete == true &&
                              _isDescriptionComplete == true
                          ? true
                          : false,
                      context: context,
                    );
                  })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
