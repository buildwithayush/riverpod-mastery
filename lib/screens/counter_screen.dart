import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final count = StateProvider<int>((ref) {
  return 0;
});

final stateProvider = StateProvider<bool>((ref) {
  return true;
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
                debugPrint("Switch Build");
                final state = ref.watch(stateProvider);
                return Switch(value: state, onChanged: (value){
                   ref.read(stateProvider.notifier).state = value;
                });
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
