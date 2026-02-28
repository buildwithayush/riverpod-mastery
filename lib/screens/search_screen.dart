import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_riverpod/providers/search_provider.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('Build');

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Search Screen',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer(
              builder: (context, ref, child) {
                return TextField(
                  onChanged: (value) {
                    final search = ref.read(searchProvider.notifier);
                    search.text(value);
                  },
                  decoration: InputDecoration(
                    hintText: "Type something...",
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

            Consumer(
              builder: (context, ref, child) {
                final value = ref.watch(searchProvider);
                return Text(
                  value.text,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                );
              },
            ),
            Consumer(
              builder: (context, ref, child) {
                final state = ref.watch(searchProvider);
                return InkWell(
                  onTap: () {
                    ref.read(searchProvider.notifier).toggleShow();
                  },
                  child: state.isshow
                      ? const Icon(Icons.remove_red_eye)
                      : const Icon(Icons.visibility_off),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
