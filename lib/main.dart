import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portolink_admin/shared/shared.dart';
import 'package:portolink_admin/views/views.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bool dark = WidgetsBinding.instance!.window.platformBrightness == Brightness.dark;
    final ThemeData initTheme = dark ? BlackWhite.darkTheme() : BlackWhite.lightTheme();
    return ThemeProvider(
      initTheme: initTheme,
      builder: (context, theme) {
        return MaterialApp(
          theme: theme,
          initialRoute: '/',
          routes: {
            '/': (context) => const Splash(),
            '/in' : (context) => const SignIn(),
            '/up': (context) => const SignUp(),
            '/main': (context) => const MainMenu(),
            '/add': (context) => const Add()
          }
        );
      }
    );
  }
}