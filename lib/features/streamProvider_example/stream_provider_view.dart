
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/features/streamProvider_example/stream_provider.dart';

class StreamProviderView extends ConsumerWidget {
  const StreamProviderView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("Hello world");
    final timer = ref.watch(timeProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Stream Provider"),
      ),
      body: SafeArea(child: Column(
        children: [
          timer.when(data: (time) => Text("The sec: $time"), error: (err, stack) => Text("Error: $err"), loading: ()=> const Center(child: CircularProgressIndicator(),))
        ],
      )),
    );
  }
}
