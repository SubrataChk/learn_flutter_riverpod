import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../application/counter_provider.dart';

/// Only this widget rebuilds when the counter changes — `ref.watch` here
/// scopes the rebuild to this widget instead of the whole screen.
class CounterDisplay extends ConsumerWidget {
  const CounterDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);

    return Text(
      '$count',
      style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
    );
  }
}
