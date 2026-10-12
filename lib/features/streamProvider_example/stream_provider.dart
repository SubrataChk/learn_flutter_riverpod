
import 'package:flutter_riverpod/flutter_riverpod.dart';

final timeProvider = StreamProvider<int>((ref){
  return Stream.periodic(Duration(seconds: 1), (count) => count + 1);
});