import 'package:flutter_riverpod/flutter_riverpod.dart';

final appNameProvider = Provider<String>((ref){
  return "My New App";
});


class ApiService {
  String fetchGreeting() => "Hello Sir";
}
final apiServiceProvider = Provider<ApiService>((ref){
  return ApiService();
});