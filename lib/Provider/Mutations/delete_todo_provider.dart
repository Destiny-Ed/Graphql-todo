import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:joovlin/GrapqhqlSchema/todo_schema.dart';
import 'package:joovlin/Provider/client_provider.dart';

class DeleteTaskProvider extends ChangeNotifier {
  bool _status = false;

  String _response = '';

  bool get getStatus => _status;

  String get getResponse => _response;

  final EndPoint _point = EndPoint();

  ///To get graphql client

  ///Delete task method
  void deleteTask({String? id, BuildContext? ctx}) async {
    _status = true;
    notifyListeners();

    ValueNotifier<GraphQLClient> _client = _point.getClient();

    QueryResult result = await _client.value.mutate(
      MutationOptions(document: gql(TaskSchema.deleteTaskSchema), variables: {
        "id": id,
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
      _response = "Task Deleted";
      notifyListeners();

      Navigator.of(ctx!).pop('');
    }
  }

  void clear() {
    _response = '';
    notifyListeners();
  }
}
