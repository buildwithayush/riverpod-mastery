import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final count = StateProvider<int>((ref) {
  return 0;
});

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("Build");

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer(
              builder: (context, ref, child) {
                debugPrint("Text Build");
                final value = ref.watch(count);
                return Text(value.toString(), style: TextStyle(fontSize: 40));
              },
            ),
            Consumer(
              builder: (context, ref, child) {
                return ElevatedButton(
                  onPressed: () {
                    ref.read(count.notifier).state++;
                  },
                  child: const Text("+", style: TextStyle(fontSize: 20)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
