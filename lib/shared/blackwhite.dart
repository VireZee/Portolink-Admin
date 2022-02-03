part of 'shared.dart';

class BlackWhite {
  static ThemeData lightTheme() => ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Colors.white,
      onPrimary: Colors.white,
      primaryVariant: Colors.white,
      secondary: Colors.white,
      onSecondary: Colors.white,
      secondaryVariant: Colors.white,
      background: Colors.white,
      onBackground: Colors.white,
      surface: Colors.white,
      onSurface: Colors.white,
      error: Colors.white,
      onError: Colors.white
    ),
    appBarTheme: const AppBarTheme(iconTheme: IconThemeData(color: Colors.white)),
    textTheme: const TextTheme(
      headline1: TextStyle(),
      headline2: TextStyle(),
      headline3: TextStyle(),
      headline4: TextStyle(),
      headline5: TextStyle(),
      headline6: TextStyle(),
      bodyText1: TextStyle(),
      bodyText2: TextStyle(),
      subtitle1: TextStyle(),
      subtitle2: TextStyle(),
      button: TextStyle(),
      caption: TextStyle(),
      overline: TextStyle()
    ).apply(bodyColor: Colors.white),
    iconTheme: const IconThemeData(color: Colors.white),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          return states.contains(MaterialState.disabled)
          ? Colors.grey.withOpacity(0.2)
          : Colors.white.withOpacity(0.6);
        }),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          return states.contains(MaterialState.disabled)
          ? Colors.white.withOpacity(0.2)
          : Colors.black;
        })
      )
    ),
    hintColor: Colors.white.withOpacity(0.2),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.white)
  );
  static ThemeData darkTheme() => ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Colors.black,
      onPrimary: Colors.black,
      primaryVariant: Colors.black,
      secondary: Colors.black,
      onSecondary: Colors.black,
      secondaryVariant: Colors.black,
      background: Colors.black,
      onBackground: Colors.black,
      surface: Colors.black,
      onSurface: Colors.black,
      error: Colors.black,
      onError: Colors.black
    ),
    appBarTheme: const AppBarTheme(iconTheme: IconThemeData(color: Colors.black)),
    textTheme: const TextTheme(
      headline1: TextStyle(),
      headline2: TextStyle(),
      headline3: TextStyle(),
      headline4: TextStyle(),
      headline5: TextStyle(),
      headline6: TextStyle(),
      bodyText1: TextStyle(),
      bodyText2: TextStyle(),
      subtitle1: TextStyle(),
      subtitle2: TextStyle(),
      button: TextStyle(),
      caption: TextStyle(),
      overline: TextStyle()
    ).apply(bodyColor: Colors.black),
    iconTheme: const IconThemeData(color: Colors.black),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          return states.contains(MaterialState.disabled)
          ? Colors.grey.withOpacity(0.2)
          : Colors.black.withOpacity(0.6);
        }),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          return states.contains(MaterialState.disabled)
          ? Colors.black.withOpacity(0.2)
          : Colors.white;
        })
      )
    ),
    hintColor: Colors.black.withOpacity(0.2),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.black)
  );
}