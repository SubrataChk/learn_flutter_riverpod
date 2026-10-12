

import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<String> fetchUserName()async{
  await Future.delayed(Duration(seconds: 2));
  return "Subrata Chakraborty";
}

final userNameProvider = FutureProvider<String>((ref){
  return fetchUserName();
});