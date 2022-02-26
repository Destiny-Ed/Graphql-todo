import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:joovlin/Utils/url.dart';

class EndPoint {
  ValueNotifier<GraphQLClient> getClient() {
    ValueNotifier<GraphQLClient> _client = ValueNotifier(GraphQLClient(
      link: HttpLink(graphqlEndpoint, defaultHeaders: {
        "x-hasura-admin-secret": secretKey,
        "content-type": "application/json"
      }),
      cache: GraphQLCache(store: HiveStore()),
    ));

    return _client;
  }
}
