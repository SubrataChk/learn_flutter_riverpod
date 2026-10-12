import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/theme/app_theme.dart';
import 'features/consumer_stateful_widget/consumer_stateful_widget_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 390x844 ~ a standard phone (iPhone 13) used as the design reference.
    // `.w`, `.h`, `.sp`, `.r` extensions elsewhere scale relative to this.
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Riverpod Demo',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          home: const ConsumerStatefulWidgetView(),
        );
      },
    );
  }
}
