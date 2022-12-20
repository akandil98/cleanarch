import 'package:cleanarch/config/routes/app_routes.dart';
import 'package:cleanarch/config/themes/app_theme.dart';
import 'package:cleanarch/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

import 'features/random_quote/presentation/screens/quote_screen.dart';

class QuoteApp extends StatelessWidget {
  const QuoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      home: const QuoteScreen(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
