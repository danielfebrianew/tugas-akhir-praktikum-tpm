import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_api_indonesia/model/user_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather_api_indonesia/pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(UserAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather API',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.red, brightness: Brightness.dark)
            .copyWith(secondary: Colors.amberAccent),
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.redAccent,
          backgroundColor: Colors.black54,
        ),
      ),
      home: const LoginPage(),
    );
  }
}
