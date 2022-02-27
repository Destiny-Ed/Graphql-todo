import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:joovlin/GrapqhqlSchema/todo_schema.dart';
import 'package:joovlin/Provider/Mutations/add_todo_provider.dart';
import 'package:joovlin/Provider/client_provider.dart';
import 'package:joovlin/Utils/url.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

/// Mocks a callback function on which you can use verify
class MockHttpClient extends Mock implements http.Client, BuildContext {}

@GenerateMocks([BuildContext])
void main() async {
  await initHiveForFlutter();

  MockHttpClient mockHttpClient;
  ValueNotifier<GraphQLClient>? client;

  setUp(() async {
    mockHttpClient = MockHttpClient();
    client = EndPoint().getClient();
  });

  group('Add Task', () {
    test("Return true if task was added", () async {
      // final provider = Provider.of<AddTaskProvider>(MockHttpClient());

      QueryResult value = await client!.value.mutate(
        MutationOptions(document: gql(TaskSchema.addTaskSchema), variables: {
          "description": "Helloworld",
          "developer_id": developerId,
          "title": "Hi"
        }),
      );

      expect(value.hasException, false);
    });

    test("Check for exception", () async {

      QueryResult value = await client!.value.mutate(
        MutationOptions(document: gql(TaskSchema.addTaskSchema), variables: {
          "description": "Helloworld",
          "developer_id": 2,
          "title": "Hi"
        }),
      );

      expect(value.hasException, true);
    });
  });
}
