import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_riverpod/providers/slider_provider.dart';

class SliderScreen extends ConsumerStatefulWidget {
  const SliderScreen({super.key});

  @override
  ConsumerState<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends ConsumerState<SliderScreen> {
  @override
  Widget build(BuildContext context) {
    debugPrint('Build');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Slider"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer(
              builder: (context, ref, child) {
                debugPrint('Heart Build');
                final slider = ref.watch(sliderProvider.select((state) => state.showHeart));
                return InkWell(
                  onTap: () {
                    final notifier = ref.read(sliderProvider.notifier);
                    notifier.state = notifier.state.copywith(
                      showHeart: !slider,
                    );
                  },

                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      child: slider
                          ? Icon(Icons.favorite, size: 40, color: Colors.red)
                          : Icon(
                              Icons.heart_broken,
                              size: 40,
                              color: Colors.redAccent,
                            ),
                    ),
                  ),
                );
              },
            ),
            Consumer(
              builder: (context, ref, child) {
                return Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(
                      alpha: ref.watch(sliderProvider).opacity,
                    ),
                  ),
                );
              },
            ),
            Consumer(
              builder: (context, ref, child) {
                debugPrint('Slider Build');
                final state = ref.watch(sliderProvider.select((state)=> state.opacity));
                return Slider(
                  value: state,
                  onChanged: (value) {
                    final notifier = ref.read(sliderProvider.notifier);
                    notifier.state = notifier.state.copywith(opacity: value);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
