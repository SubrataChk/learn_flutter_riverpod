import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/features/state_provider_example/provider.dart';

// StateProvider
// use hoy simple, mutable state-er jonno — jemon counter, toggle switch, selected filter. Eta
// directly value replace korar support dei.


class StateProviderView extends ConsumerWidget {
  const StateProviderView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(newCounterProvider);
    return Scaffold(
      appBar: AppBar(title: Text("State Provider View")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("The is counter app: $counter"),
              SizedBox(height: 150,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(onPressed: (){
                    ref.read(newCounterProvider.notifier).state++;
                  }, child: Text("Increment")),
                  TextButton(onPressed: (){
                    if(counter != 0){
                      ref.read(newCounterProvider.notifier).state--;
                    }

                  }, child: Text("Decrement")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
