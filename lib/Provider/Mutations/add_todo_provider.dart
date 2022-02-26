import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:joovlin/GrapqhqlSchema/todo_schema.dart';
import 'package:joovlin/Provider/client_provider.dart';
import 'package:joovlin/Utils/url.dart';

class AddTaskProvider extends ChangeNotifier {
  bool _status = false;

  String _response = '';

  bool get getStatus => _status;

  String get getResponse => _response;

  final EndPoint _point = EndPoint();

  ///To get graphql client

  ///Add task method
  void addTask(
      {String? title,
      String? description,
      BuildContext? ctx}) async {
    _status = true;
    notifyListeners();

    ValueNotifier<GraphQLClient> _client = _point.getClient();

    QueryResult result = await _client.value.mutate(
      MutationOptions(document: gql(TaskSchema.addTaskSchema), variables: {
        "description": description,
        "developer_id": developerId,
        "title": title
      }),
    );

    if (result.hasException) {
      print(result.exception);
      _status = false;
      if (result.exception!.graphqlErrors.isEmpty) {
        _response = "Internet is not found";
      } else {
        _response = result.exception!.graphqlErrors[0].message.toString();
      }
      notifyListeners();
    } else {
      print(result.data);
      _status = false;
      _response = "Task was successfully added";
      notifyListeners();

      Navigator.of(ctx!).pop('added');
    }
  }

  void clear() {
    _response = '';
    notifyListeners();
  }
}
