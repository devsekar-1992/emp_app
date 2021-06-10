import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDB {
  init() async {
    final dir = await getApplicationDocumentsDirectory();
    print('dir.path');
    try {
      await Hive.initFlutter(dir.path);
    } on MissingPlatformDirectoryException catch (e) {
      print(e.details);
    }
  }

  putIntoBox(String name, String key, dynamic data) async {
    var box = await Hive.openBox(name);
    box.put(key, data);
  }

  getFromBox(String boxName, String key) async {
    var box = await Hive.openBox(boxName);
    return box.get(key);
  }
}
