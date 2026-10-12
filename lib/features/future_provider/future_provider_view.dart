import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/features/future_provider/future_provider_section.dart';

class FutureProviderView extends ConsumerWidget {
  const FutureProviderView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userName = ref.watch(userNameProvider);
    return Scaffold(
      appBar: AppBar(title: Text("Future Provider")),
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: userName.when(
                data: (name) => Text(name),
                error: (error, stack) => Text('Error: $error'),
                loading: () => const CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
