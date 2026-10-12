import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Holds the counter value and the logic to change it.
/// UI never mutates state directly — it only calls methods like [increment].
class CounterNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void increment() => state++;

  void reset() => state = 0;
}

final counterProvider = NotifierProvider<CounterNotifier, int>(
  CounterNotifier.new,
);
