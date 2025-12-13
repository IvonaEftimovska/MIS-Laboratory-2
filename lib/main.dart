import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:second_lab_mis/services/notification_service.dart';
import 'screens/categories_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService.init();
  await NotificationService.scheduleDailyRecipeNotification();
  runApp(MealApp());
}


class MealApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CategoriesScreen(),
    );
  }
}
