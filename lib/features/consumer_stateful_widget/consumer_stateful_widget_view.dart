import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/features/consumer_stateful_widget/stateful_provider.dart';

class ConsumerStatefulWidgetView extends ConsumerStatefulWidget {
  const ConsumerStatefulWidgetView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidgetView> createState() =>
      _ConsumerStatefulWidgetViewState();
}

class _ConsumerStatefulWidgetViewState
    extends ConsumerState<ConsumerStatefulWidgetView> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final count = ref.watch(statefullCounterState);
    print("Welcome home");
    return Scaffold(
      appBar: AppBar(title: Text("Consumer Statefull Widget")),
      body: SafeArea(child: Column(children: [
        TextField(
          controller: textEditingController,
        ),
        Text("This count: $count"),
        SizedBox(height: 150,),
        TextButton(onPressed: (){
          ref.read(statefullCounterState.notifier).state++;
        }, child: Text("Increment"))
      ])),
    );
  }
}
