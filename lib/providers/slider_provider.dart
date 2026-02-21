import 'package:flutter_riverpod/flutter_riverpod.dart';

final sliderProvider = StateProvider((ref) {
  return AppState(opacity: 0.5, showHeart: false);
});

class AppState {
  final double opacity;
 final bool showHeart;

  AppState({ required this.opacity,  required this.showHeart});

  AppState copywith({
    double? opacity,
    bool? showHeart
  }){
    return AppState(
      opacity: opacity ?? this.opacity,
      showHeart: showHeart ?? this.showHeart,
    );
  }

}