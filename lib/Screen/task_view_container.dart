import 'package:flutter/material.dart';
import 'package:joovlin/Provider/Mutations/update_todo_provider.dart';
import 'package:joovlin/Provider/Query/get_todo_provider.dart';
import 'package:joovlin/Screen/todo_details_page.dart';
import 'package:joovlin/Styles/color.dart';
import 'package:joovlin/Utils/router.dart';
import 'package:provider/provider.dart';

class TaskField extends StatefulWidget {
  TaskField(
      {Key? key,
      this.title,
      this.taskId,
      this.isCompleted,
      this.initial,
      this.subtitle})
      : super(key: key);

  final String? title;
  final String? subtitle;
  final String? taskId;
  final String? initial;

  bool? isCompleted;

  @override
  _TaskFieldState createState() => _TaskFieldState();
}

class _TaskFieldState extends State<TaskField> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        PageNavigator(ctx: context)
            .nextPage(
                page: TaskDetailsPage(
          taskId: widget.taskId,
          isCompleted: widget.isCompleted,
          title: widget.title,
          description: widget.subtitle,
        ))
            .then((value) {
          if (value == '') {
            ///Fetch latest data
            Provider.of<GetTaskProvider>(context, listen: false)
                  .getTask(false);
          }
        });
      },
      contentPadding: const EdgeInsets.all(0),
      title: Text(
        widget.title!,
        style: TextStyle(
          decoration: widget.isCompleted == true
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        widget.subtitle!,
        style: TextStyle(
          decoration: widget.isCompleted == true
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      leading: CircleAvatar(
        backgroundColor: widget.isCompleted == true ? green : amber,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: CircleAvatar(
            backgroundColor:
                widget.isCompleted == true ? lightGreen : lightAmber,
            child: Text(widget.initial!),
          ),
        ),
      ),
      trailing: Checkbox(
        onChanged: (value) {
          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
            setState(() {
              widget.isCompleted = value!;
            });
          });
          Provider.of<UpdateTaskProvider>(context, listen: false).updateTask(
              id: widget.taskId,
              isCompleted: value,
              title: widget.title,
              description: widget.subtitle,
              ctx: context);
        },
        value: widget.isCompleted,
        fillColor: MaterialStateProperty.resolveWith(
          (states) {
            return widget.isCompleted == true ? green : grey;
          },
        ),
      ),
    );
  }
}