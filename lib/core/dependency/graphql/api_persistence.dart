import 'package:clean_framework_graphql/clean_framework_graphql.dart';
import 'package:graphql/client.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class APIPersistence extends GraphQLPersistence {
  @override
  Future<GraphQLCache> setup() async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'db');

    HiveStore.init(onPath: path);

    return GraphQLCache(
      store: await HiveStore.open(),
    );
  }
}
