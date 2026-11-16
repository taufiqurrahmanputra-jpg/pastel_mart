
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/product_provider.dart';
import 'screens/home_screen.dart';
import 'theme/app_colors.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
        ),
      ],
      child: const PastelMartApp(),
    ),
  );
}

class PastelMartApp extends StatelessWidget {
  const PastelMartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PastelMart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          centerTitle: false,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
