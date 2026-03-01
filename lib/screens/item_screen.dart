import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_riverpod/providers/item_provider.dart';

class ItemScreen extends ConsumerWidget {
  ItemScreen({super.key});
  final listController = TextEditingController();
  final updateController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('Build');
    return Scaffold(
      appBar: AppBar(title: Text('Item Screen')),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: listController,
              decoration: const InputDecoration(
                hintText: "Enter item name",
                border: OutlineInputBorder(),
              ),
            ),
          ),

          SizedBox(height: 30),

          ElevatedButton(
            onPressed: () {
              if (listController.text.isNotEmpty) {
                ref.read(itemProvider.notifier).adddata(listController.text);

                listController.clear();
              }
            },
            child: const Text("Add Item"),
          ),

          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final item = ref.watch(itemProvider);
                return item.isEmpty
                    ? Center(child: Text('No item'))
                    : ListView.builder(
                        itemCount: item.length,
                        itemBuilder: (context, index) {
                          final itemlist = item[index];
                          return ListTile(
                            title: Text(itemlist.name),
                            subtitle: Text(itemlist.id),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    updateController.text = itemlist.name;

                                    showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        title: Text("Update Item"),
                                        content: TextFormField(
                                          controller: updateController,
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              ref
                                                  .read(itemProvider.notifier)
                                                  .updateItem(
                                                    itemlist.id,
                                                    updateController.text,
                                                  );

                                              updateController.clear();
                                              Navigator.pop(context);
                                            },
                                            child: Text("Update"),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.edit),
                                ),

                                IconButton(
                                  onPressed: () {
                                    ref
                                        .read(itemProvider.notifier)
                                        .deleteItem(itemlist.id);
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                              ],
                            ),
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
