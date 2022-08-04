import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noty/features/db/models/notes.dart';
import 'package:noty/features/db/providers/category_provider.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

final categoryState = StateProvider((ref) => "All");

final categoriesState =
    StateNotifierProvider<CategoryStateNotifier, List<Category>>(
        (ref) => CategoryStateNotifier([Category(label: "All")]));

class CategoryStateNotifier extends StateNotifier<List<Category>> {
  CategoryStateNotifier(super.state);

  add({Category? category, List<Category> categories = const []}) {
    if (categories.length > 0) {
      state = [...state, ...categories];
    } else {
      state = [
        ...state,
        ...[category!]
      ];
    }
  }

  get(Database db) async {
    List<Category> categories = await CategoryProvider.findAll(db);
    add(categories: categories);
  }
}
