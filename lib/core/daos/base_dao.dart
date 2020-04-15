import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:weather/core/models/BaseModel.dart';

abstract class BaseDao<Model extends BaseModel> {
  final String boxName;
  final Map<String, dynamic> Function(Model item) toJsonConverter;
  final Model Function(Map<String, dynamic> json) fromJsonConverter;
  final String Function(Model item) identifier;

  BaseDao(
      this.boxName,
      this.toJsonConverter,
      this.fromJsonConverter,
      this.identifier,
      );

  Future<Model> get(int id) => _getExecutor(id, fromJsonConverter);

  Future<List<Model>> getAll() => _getAllExecutor(fromJsonConverter);

  Future<void> add(Model item) =>
      _addExecutor(item, identifier, toJsonConverter);

  Future<void> addAll(List<Model> items) =>
      _addAllExecutor(items, identifier, toJsonConverter);


  Future<void> clear() async {
    final box = await Hive.openLazyBox(boxName,);
    await box.clear();
  }

  Future<Model> _getExecutor(
      int id,
      Model Function(Map<String, dynamic> json) converter,
      ) async {
    final box = await Hive.openLazyBox(boxName, );
    return converter(jsonDecode(await box.getAt(id)));
  }

  Future<List<Model>> _getAllExecutor(
      Model Function(Map<String, dynamic> json) converter,
      ) async {
    final box = await Hive.openLazyBox(boxName, );
    final posts = List<Model>();
    for (int i = 0; i < box.length; i++) {
      final jsonMap = jsonDecode(await box.getAt(i));
      posts.add(converter(jsonMap));
    }
    return posts;
  }

  Future<void> _addExecutor(
      Model item,
      String Function(Model model) identifier,
      Map<String, dynamic> Function(Model model) converter,
      ) async {
    final box = await Hive.openLazyBox(boxName,);
    print(identifier(item));
    await box.put(identifier(item), jsonEncode(converter(item)));
  }

  Future<void> _addAllExecutor(
      List<Model> items,
      String Function(Model model) identifier,
      Map<String, dynamic> Function(Model model) converter,
      ) async {
    final box = await Hive.openLazyBox(boxName, );
    for (Model item in items) {
      await box.put(identifier(item), jsonEncode(converter(item)));
    }
  }
}
