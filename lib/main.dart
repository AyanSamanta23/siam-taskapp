import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:siamtaskapp/screens/auth.dart';
import 'package:siamtaskapp/themes/theme_file_for_dm.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ThemeBuilder(
      defaultBrightness: Brightness.light,
      builder: (context, _brightness) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData( brightness: _brightness),
          home: LoginPage(),
        );
      },
    );
  }
}

