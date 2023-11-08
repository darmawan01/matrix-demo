import 'package:matrix/matrix.dart';
import 'package:path_provider/path_provider.dart';

class MatrixClient {
  MatrixClient._();

  static final MatrixClient instance = MatrixClient._();

  Client? _client;

  Future<void> init() async {
    if (_client == null) {
      _client = Client(
        'Matrix Example Chat',
        databaseBuilder: (_) async {
          final dir = await getApplicationSupportDirectory();
          final db = HiveCollectionsDatabase('matrix_example_chat', dir.path);
          await db.open();
          return db;
        },
      );

      await _client?.init();
    }
  }

  Client? getClient() {
    return _client;
  }
}
