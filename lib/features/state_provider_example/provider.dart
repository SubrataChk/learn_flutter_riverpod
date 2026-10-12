import 'package:flutter_riverpod/flutter_riverpod.dart';

final newCounterProvider = StateProvider<int>((ref) {
  return 0;
});
