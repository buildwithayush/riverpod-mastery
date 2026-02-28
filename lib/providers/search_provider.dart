import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchProvider = StateNotifierProvider<SearchNotifier, SearchState>((
  ref,
) {
  return SearchNotifier();
});

class SearchNotifier extends StateNotifier<SearchState> {
  SearchNotifier() : super(SearchState(text: '', isshow: true));

  void text(String query) {
    state = state.copywith(text: query);
  }

  void toggleShow() {
    state = state.copywith(isshow: !state.isshow);
  }
}

class SearchState {
  final String text;
  final bool isshow;

  SearchState({required this.text, required this.isshow});

  SearchState copywith({String? text, bool? isshow}) {
    return SearchState(text: text ?? this.text, isshow: isshow ?? this.isshow);
  }
}
