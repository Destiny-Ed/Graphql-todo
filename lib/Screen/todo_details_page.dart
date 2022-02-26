import 'package:flutter/material.dart';
import 'package:joovlin/Screen/Resuable_Widgets/button.dart';
import 'package:joovlin/Screen/Resuable_Widgets/text_field.dart';
import 'package:joovlin/Styles/color.dart';

class TaskDetailsPage extends StatefulWidget {
  const TaskDetailsPage({Key? key, this.title, this.description, this.taskId})
      : super(key: key);

  final String? title;
  final String? description;
  final String? taskId;

  @override
  _TaskDetailsPageState createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
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
  void initState() {
    super.initState();

    populateFields();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task details'),
        actions: [
          IconButton(
            onPressed: () {
              print("Delete");
            },
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.delete,
                color: white,
              ),
            ),
          )
        ],
      ),
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

                  customButton(
                    value: 'Save',
                    tap: () {
                      print(_description.text);
                      print(_title.text);
                    },
                    isValid: _isTitleComplete == true &&
                            _isDescriptionComplete == true
                        ? true
                        : false,
                    context: context,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void populateFields() {
    _title.text = widget.title!;
    _description.text = widget.description!;
    setState(() {});
  }
}
