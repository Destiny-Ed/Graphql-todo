import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:joovlin/GrapqhqlSchema/todo_schema.dart';
import 'package:joovlin/Provider/client_provider.dart';
import 'package:joovlin/Utils/url.dart';

class GetTaskProvider extends ChangeNotifier {
  bool _status = false;

  String _response = '';

  dynamic _list = [];

  bool get getStatus => _status;

  String get getResponse => _response;

  final EndPoint _point = EndPoint();

  ///GEt task method
  void getTask(bool isLocal) async {
    ValueNotifier<GraphQLClient> _client = _point.getClient();

    QueryResult result = await _client.value.query(QueryOptions(
        document: gql(TaskSchema.getTaskSchema),
        variables: {"developer_id": developerId},
        fetchPolicy: isLocal == true ? null : FetchPolicy.networkOnly));

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
      _list = result.data;
      notifyListeners();
    }
  }

  List<dynamic> getResponseData() {
    if (_list.isNotEmpty) {
      final data = _list;
      return data['tasks'] ?? [];
    } else {
      return [];
    }
  }

  void clear() {
    _response = '';
    notifyListeners();
  }
}
