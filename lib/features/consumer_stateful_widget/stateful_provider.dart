
import 'package:flutter_riverpod/flutter_riverpod.dart';

final statefullCounterState = StateProvider<int>((ref){
  return 0;
});