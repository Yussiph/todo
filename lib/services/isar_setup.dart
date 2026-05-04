import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo/collections/Task.dart';

late final Isar isar;

Future<void> initIsar() async {
  // Other directory options are available, see the path_provider
  // page and decide which one is suitable for yourself.
  final dir = await getApplicationSupportDirectory();
  isar = await Isar.open([TaskSchema], directory: dir.path);
}
