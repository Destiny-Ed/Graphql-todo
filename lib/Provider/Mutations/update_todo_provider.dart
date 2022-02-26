import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:joovlin/GrapqhqlSchema/todo_schema.dart';
import 'package:joovlin/Provider/client_provider.dart';
import 'package:joovlin/Utils/url.dart';

class UpdateTaskProvider extends ChangeNotifier {
  bool _status = false;

  String _response = '';

  bool get getStatus => _status;

  String get getResponse => _response;

  final EndPoint _point = EndPoint();

  ///To get graphql client

  ///Add task method
  void updateTask(
      {String? id,
      String? title,
      String? description,
      bool? isCompleted,
      BuildContext? ctx}) async {
    _status = true;
    notifyListeners();

    ValueNotifier<GraphQLClient> _client = _point.getClient();

    QueryResult result = await _client.value.mutate(
      MutationOptions(document: gql(TaskSchema.updateTaskSchema), variables: {
        "id": id,
        "payload": {
          "isCompleted": isCompleted,
          "title": title,
          "description": description
        }
      }),
    );

    if (result.hasException) {
      _status = false;
      if (result.exception!.graphqlErrors.isEmpty) {
        _response = "Internet is not found";
      } else {
        _response = result.exception!.graphqlErrors[0].message.toString();
      }
      notifyListeners();
    } else {
      _status = false;
      _response = "Task updated";
      notifyListeners();

      Navigator.of(ctx!).pop('');
    }
  }

  void clear() {
    _response = '';
    notifyListeners();
  }
}
