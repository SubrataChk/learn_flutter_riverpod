// Provider shobcheye simple provider — eta ekTa value expose kore
// jeta change hoy na (read-only). Eta mainly
// config value, repository/service instance, ba computed value
// expose korar jonno use hoy.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/features/provider_example/example_provider.dart';

class ProviderExampleView extends ConsumerWidget {
  const ProviderExampleView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appName = ref.watch(appNameProvider);

    return Scaffold(
      appBar: AppBar(title: Text(appName)),
      body: SafeArea(
        child: Column(children: [Center(child: Text("Welcome to Provider"))]),
      ),
    );
  }
}
