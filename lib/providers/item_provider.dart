import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_riverpod/classes/item.dart';

final itemProvider = StateNotifierProvider<ItemNotifier, List<Item>>((ref) {
  return ItemNotifier();
});

class ItemNotifier extends StateNotifier<List<Item>> {
  ItemNotifier() : super([]);

  void adddata(String name) {
    final item = Item(id: DateTime.now().toString(), name: name);
    state = [...state, item];
  }

void updateItem(String id, String name) {
  state = state.map((item) {
    if (item.id == id) {
      return Item(id: item.id, name: name);
    }
    return item;
  }).toList();
}
  
 void deleteItem(String id) {
  state = state.where((item) => item.id != id).toList();
}

}
