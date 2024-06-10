import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // final Color _primaryLight = Colors.black ;
  // final Color _primaryDark = Colors.black ;
  static List<ThemeData> golden = [
    ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color.fromARGB(255, 12, 12, 12),
          onPrimary: Color.fromARGB(255, 165, 165, 165),
          secondary: Color.fromARGB(255, 191, 148, 95),
          onSecondary: Color.fromARGB(255, 242, 242, 242) // primary
          ,
          tertiary: Color.fromARGB(255, 153, 116, 71),
          onTertiary: Colors.black,
          error: Color.fromARGB(255, 221, 57, 46),
          onError: Colors.white,
          background: Color.fromARGB(255, 242, 242, 242),
          onBackground: Colors.black,
          surface: Color.fromARGB(255, 191, 148, 95) //secondary
          ,
          onSurface:
              Color.fromARGB(255, 165, 165, 165) // primary // onSecondary
          ,
          secondaryContainer: Color.fromARGB(255, 225, 225, 225)),
      snackBarTheme: const SnackBarThemeData(
          contentTextStyle: TextStyle(color: Color.fromARGB(255, 12, 12, 12))),
      disabledColor: const Color.fromARGB(255, 165, 165, 165),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        backgroundColor: const Color.fromARGB(255, 191, 148, 95) //secondary
        ,
        foregroundColor: const Color.fromARGB(255, 242, 242, 242) //primary
        ,
      ),
      scaffoldBackgroundColor:
          const Color.fromARGB(255, 242, 242, 242) //backgroundColor
      ,
      shadowColor: const Color.fromARGB(255, 191, 148, 95) //secondary
      ,
      splashColor: const Color.fromARGB(48, 191, 148, 95) //secondary
      ,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(),
        bodyMedium: TextStyle(),
        bodySmall: TextStyle(),
        displayLarge: TextStyle(),
        displayMedium: TextStyle(),
        displaySmall: TextStyle(),
        headlineLarge: TextStyle(),
        headlineMedium: TextStyle(
          fontSize: 20,
          color: Color.fromARGB(255, 242, 242, 242) // primary
          ,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          color: Color.fromARGB(255, 191, 148, 95) // primary
          ,
          fontWeight: FontWeight.w800,
        ),
        labelLarge: TextStyle(fontWeight: FontWeight.w300),
        labelMedium: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 242, 242, 242) //backgroundColor
            ),
        labelSmall:
            TextStyle(fontWeight: FontWeight.w300, color: Colors.blueGrey),
        titleLarge: TextStyle(),
        titleMedium: TextStyle(),
        titleSmall: TextStyle(),
      ),
      dialogTheme: DialogTheme(
        elevation: 1,
        backgroundColor:
            const Color.fromARGB(255, 242, 242, 242) //backgroundColor
        ,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
      appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0,
        shadowColor: Color.fromARGB(255, 191, 148, 95),
        backgroundColor: Color.fromARGB(255, 242, 242, 242) //secondary
        ,
        foregroundColor: Color.fromARGB(255, 191, 148, 95) //primary

        ,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color.fromARGB(255, 191, 148, 95),
        unselectedItemColor: Color.fromARGB(255, 165, 165, 165),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: Color.fromARGB(255, 242, 242, 242) //backgroundColor
        ,
      ),
      listTileTheme: const ListTileThemeData(
          titleTextStyle: TextStyle(
            color: Color.fromARGB(255, 191, 148, 95) //primary
            ,
            fontWeight: FontWeight.w500,
            fontSize: 25,
          ),
          iconColor: Color.fromARGB(255, 191, 148, 95) //primary
          ),
    ),
    ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color.fromARGB(255, 242, 242, 242),
          onPrimary: Color.fromARGB(255, 89, 89, 89),
          secondary: Color.fromARGB(255, 191, 148, 95),
          onSecondary: Color.fromARGB(255, 12, 12, 12) // primary
          ,
          tertiary: Color.fromARGB(255, 247, 210, 165),
          onTertiary: Colors.white,
          error: Color.fromARGB(255, 221, 57, 46),
          onError: Colors.black,
          background: Color.fromARGB(255, 12, 12, 12),
          onBackground: Colors.white,
          surface: Color.fromARGB(255, 191, 148, 95) //secondary
          ,
          onSurface: Color.fromARGB(255, 89, 89, 89) // primary // onSecondary
          ,
          secondaryContainer: Color.fromARGB(255, 44, 44, 44)),
      snackBarTheme: const SnackBarThemeData(
          contentTextStyle:
              TextStyle(color: Color.fromARGB(255, 242, 242, 242))),
      disabledColor: const Color.fromARGB(255, 89, 89, 89),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        backgroundColor: const Color.fromARGB(255, 191, 148, 95) //secondary
        ,
        foregroundColor: const Color.fromARGB(255, 89, 89, 89) //primary
        ,
      ),
      scaffoldBackgroundColor:
          const Color.fromARGB(255, 12, 12, 12) //backgroundColor
      ,
      shadowColor: const Color.fromARGB(255, 191, 148, 95) //secondary
      ,
      splashColor: const Color.fromARGB(48, 191, 148, 95) //secondary
      ,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(),
        bodyMedium: TextStyle(),
        bodySmall: TextStyle(),
        displayLarge: TextStyle(),
        displayMedium: TextStyle(),
        displaySmall: TextStyle(),
        headlineLarge: TextStyle(),
        headlineMedium: TextStyle(
          fontSize: 20,
          color: Color.fromARGB(255, 12, 12, 12) // primary
          ,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          color: Color.fromARGB(255, 191, 148, 95) // primary
          ,
          fontWeight: FontWeight.w800,
          fontSize: 33,
        ),
        labelLarge: TextStyle(fontWeight: FontWeight.w300),
        labelMedium: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 12, 12, 12) //backgroundColor

            ),
        labelSmall:
            TextStyle(fontWeight: FontWeight.w300, color: Colors.blueGrey),
        titleLarge: TextStyle(),
        titleMedium: TextStyle(),
        titleSmall: TextStyle(),
      ),
      dialogTheme: DialogTheme(
        elevation: 1,
        backgroundColor: const Color.fromARGB(255, 12, 12, 12) //backgroundColor
        ,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
      appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0,
        shadowColor: Color.fromARGB(255, 191, 148, 95),
        backgroundColor: Color.fromARGB(255, 12, 12, 12) //background

        ,
        foregroundColor: Color.fromARGB(255, 191, 148, 95) //secondary

        ,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Color.fromARGB(255, 165, 165, 165),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: Color.fromARGB(255, 12, 12, 12) //backgroundColor,
        ,
      ),
      listTileTheme: const ListTileThemeData(
          titleTextStyle: TextStyle(
            color: Color.fromARGB(255, 191, 148, 95) //secondary
            ,
            fontWeight: FontWeight.w500,
            fontSize: 25,
          ),
          iconColor: Color.fromARGB(255, 191, 148, 95) //secondary
          ),
    ),
  ];

//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//

  static List<ThemeData> blue = [
    ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color.fromARGB(255, 12, 12, 12),
          onPrimary: Color.fromARGB(255, 170, 191, 185),
          secondary: Color.fromARGB(255, 77, 122, 140),
          onSecondary: Color.fromARGB(255, 242, 242, 242) // primary
          ,
          tertiary: Color.fromARGB(255, 57, 95, 110),
          onTertiary: Colors.black,
          error: Color.fromARGB(255, 221, 57, 46),
          onError: Colors.white,
          background: Color.fromARGB(255, 242, 242, 242),
          onBackground: Colors.black,
          surface: Color.fromARGB(255, 77, 122, 140) //secondary
          ,
          onSurface:
              Color.fromARGB(255, 170, 191, 185) // primary // onSecondary
          ,
          secondaryContainer: Color.fromARGB(255, 225, 225, 225)),
      snackBarTheme: const SnackBarThemeData(
          contentTextStyle: TextStyle(color: Color.fromARGB(255, 12, 12, 12))),
      disabledColor: const Color.fromARGB(255, 170, 191, 185),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        backgroundColor: const Color.fromARGB(255, 77, 122, 140) //secondary
        ,
        foregroundColor: const Color.fromARGB(255, 242, 242, 242) //primary
        ,
      ),
      scaffoldBackgroundColor:
          const Color.fromARGB(255, 242, 242, 242) //backgroundColor
      ,
      shadowColor: const Color.fromARGB(255, 77, 122, 140) //secondary
      ,
      splashColor: const Color.fromARGB(48, 191, 148, 95) //secondary
      ,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(),
        bodyMedium: TextStyle(),
        bodySmall: TextStyle(),
        displayLarge: TextStyle(),
        displayMedium: TextStyle(),
        displaySmall: TextStyle(),
        headlineLarge: TextStyle(),
        headlineMedium: TextStyle(
          fontSize: 20,
          color: Color.fromARGB(255, 242, 242, 242) // primary
          ,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          color: Color.fromARGB(255, 77, 122, 140) // primary
          ,
          fontWeight: FontWeight.w800,
        ),
        labelLarge: TextStyle(fontWeight: FontWeight.w300),
        labelMedium: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 242, 242, 242) //backgroundColor
            ),
        labelSmall:
            TextStyle(fontWeight: FontWeight.w300, color: Colors.blueGrey),
        titleLarge: TextStyle(),
        titleMedium: TextStyle(),
        titleSmall: TextStyle(),
      ),
      dialogTheme: DialogTheme(
        elevation: 1,
        backgroundColor:
            const Color.fromARGB(255, 242, 242, 242) //backgroundColor
        ,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
      appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0,
        shadowColor: Color.fromARGB(255, 77, 122, 140),
        backgroundColor: Color.fromARGB(255, 242, 242, 242) //secondary
        ,
        foregroundColor: Color.fromARGB(255, 77, 122, 140) //primary

        ,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color.fromARGB(255, 77, 122, 140),
        unselectedItemColor: Color.fromARGB(255, 170, 191, 185),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: Color.fromARGB(255, 242, 242, 242) //backgroundColor
        ,
      ),
      listTileTheme: const ListTileThemeData(
          titleTextStyle: TextStyle(
            color: Color.fromARGB(255, 77, 122, 140) //primary
            ,
            fontWeight: FontWeight.w500,
            fontSize: 25,
          ),
          iconColor: Color.fromARGB(255, 77, 122, 140) //primary
          ),
    ),
    ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color.fromARGB(255, 242, 242, 242),
          onPrimary: Color.fromARGB(255, 132, 165, 165),
          secondary: Color.fromARGB(255, 77, 122, 140),
          onSecondary: Color.fromARGB(255, 12, 12, 12) // primary
          ,
          tertiary: Color.fromARGB(255, 120, 169, 188),
          onTertiary: Colors.white,
          error: Color.fromARGB(255, 221, 57, 46),
          onError: Colors.black,
          background: Color.fromARGB(255, 12, 12, 12),
          onBackground: Colors.white,
          surface: Color.fromARGB(255, 77, 122, 140) //secondary
          ,
          onSurface:
              Color.fromARGB(255, 132, 165, 165) // primary // onSecondary
          ,
          secondaryContainer: Color.fromARGB(255, 17, 21, 21)),
      snackBarTheme: const SnackBarThemeData(
          contentTextStyle:
              TextStyle(color: Color.fromARGB(255, 242, 242, 242))),
      disabledColor: const Color.fromARGB(255, 132, 165, 165),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        backgroundColor: const Color.fromARGB(255, 77, 122, 140) //secondary
        ,
        foregroundColor: const Color.fromARGB(255, 132, 165, 165) //primary
        ,
      ),
      scaffoldBackgroundColor:
          const Color.fromARGB(255, 12, 12, 12) //backgroundColor
      ,
      shadowColor: const Color.fromARGB(255, 77, 122, 140) //secondary
      ,
      splashColor: const Color.fromARGB(48, 77, 122, 140) //secondary
      ,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(),
        bodyMedium: TextStyle(),
        bodySmall: TextStyle(),
        displayLarge: TextStyle(),
        displayMedium: TextStyle(),
        displaySmall: TextStyle(),
        headlineLarge: TextStyle(),
        headlineMedium: TextStyle(
          fontSize: 20,
          color: Color.fromARGB(255, 12, 12, 12) // primary
          ,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          color: Color.fromARGB(255, 77, 122, 140) // primary
          ,
          fontWeight: FontWeight.w800,
          fontSize: 33,
        ),
        labelLarge: TextStyle(fontWeight: FontWeight.w300),
        labelMedium: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 12, 12, 12) //backgroundColor

            ),
        labelSmall:
            TextStyle(fontWeight: FontWeight.w300, color: Colors.blueGrey),
        titleLarge: TextStyle(),
        titleMedium: TextStyle(),
        titleSmall: TextStyle(),
      ),
      dialogTheme: DialogTheme(
        elevation: 1,
        backgroundColor: const Color.fromARGB(255, 12, 12, 12) //backgroundColor
        ,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
      appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0,
        shadowColor: Color.fromARGB(255, 77, 122, 140),
        backgroundColor: Color.fromARGB(255, 12, 12, 12) //background

        ,
        foregroundColor: Color.fromARGB(255, 77, 122, 140) //secondary

        ,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Color.fromARGB(255, 132, 165, 165),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: Color.fromARGB(255, 12, 12, 12) //backgroundColor,
        ,
      ),
      listTileTheme: const ListTileThemeData(
          titleTextStyle: TextStyle(
            color: Color.fromARGB(255, 77, 122, 140) //secondary
            ,
            fontWeight: FontWeight.w500,
            fontSize: 25,
          ),
          iconColor: Color.fromARGB(255, 77, 122, 140) //secondary
          ),
    ),
  ];

//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//

  static List<ThemeData> brown = [
    ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color.fromARGB(255, 12, 12, 12),
          onPrimary: Color.fromARGB(255, 165, 165, 165),
          secondary: Color.fromARGB(255, 165, 115, 86),
          onSecondary: Color.fromARGB(255, 242, 242, 242) // primary
          ,
          tertiary: Color.fromARGB(255, 139, 95, 70),
          onTertiary: Colors.black,
          error: Color.fromARGB(255, 221, 57, 46),
          onError: Colors.white,
          background: Color.fromARGB(255, 242, 242, 242),
          onBackground: Colors.black,
          surface: Color.fromARGB(255, 165, 115, 86) //secondary
          ,
          onSurface:
              Color.fromARGB(255, 165, 165, 165) // primary // onSecondary
          ,
          secondaryContainer: Color.fromARGB(255, 225, 225, 225)),
      snackBarTheme: const SnackBarThemeData(
          contentTextStyle: TextStyle(color: Color.fromARGB(255, 12, 12, 12))),
      disabledColor: const Color.fromARGB(255, 165, 165, 165),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        backgroundColor: const Color.fromARGB(255, 165, 115, 86) //secondary
        ,
        foregroundColor: const Color.fromARGB(255, 242, 242, 242) //primary
        ,
      ),
      scaffoldBackgroundColor:
          const Color.fromARGB(255, 242, 242, 242) //backgroundColor
      ,
      shadowColor: const Color.fromARGB(255, 165, 115, 86) //secondary
      ,
      splashColor: const Color.fromARGB(48, 165, 115, 86) //secondary
      ,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(),
        bodyMedium: TextStyle(),
        bodySmall: TextStyle(),
        displayLarge: TextStyle(),
        displayMedium: TextStyle(),
        displaySmall: TextStyle(),
        headlineLarge: TextStyle(),
        headlineMedium: TextStyle(
          fontSize: 20,
          color: Color.fromARGB(255, 242, 242, 242) // primary
          ,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          color: Color.fromARGB(255, 165, 115, 86) // primary
          ,
          fontWeight: FontWeight.w800,
        ),
        labelLarge: TextStyle(fontWeight: FontWeight.w300),
        labelMedium: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 242, 242, 242) //backgroundColor
            ),
        labelSmall:
            TextStyle(fontWeight: FontWeight.w300, color: Colors.blueGrey),
        titleLarge: TextStyle(),
        titleMedium: TextStyle(),
        titleSmall: TextStyle(),
      ),
      dialogTheme: DialogTheme(
        elevation: 1,
        backgroundColor:
            const Color.fromARGB(255, 242, 242, 242) //backgroundColor
        ,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
      appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0,
        shadowColor: Color.fromARGB(255, 165, 115, 86),
        backgroundColor: Color.fromARGB(255, 242, 242, 242) //secondary
        ,
        foregroundColor: Color.fromARGB(255, 165, 115, 86) //primary

        ,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color.fromARGB(255, 165, 115, 86),
        unselectedItemColor: Color.fromARGB(255, 165, 165, 165),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: Color.fromARGB(255, 242, 242, 242) //backgroundColor
        ,
      ),
      listTileTheme: const ListTileThemeData(
          titleTextStyle: TextStyle(
            color: Color.fromARGB(255, 165, 115, 86) //primary
            ,
            fontWeight: FontWeight.w500,
            fontSize: 25,
          ),
          iconColor: Color.fromARGB(255, 165, 115, 86) //primary
          ),
    ),
    ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color.fromARGB(255, 242, 242, 242),
          onPrimary: Color.fromARGB(255, 191, 167, 147),
          secondary: Color.fromARGB(255, 89, 63, 54),
          onSecondary: Color.fromARGB(255, 12, 12, 12) // primary
          ,
          tertiary: Color.fromARGB(255, 121, 88, 76),
          onTertiary: Color.fromARGB(255, 191, 167, 147),
          error: Color.fromARGB(255, 221, 57, 46),
          onError: Colors.black,
          background: Color.fromARGB(255, 12, 12, 12),
          onBackground: Colors.white,
          surface: Color.fromARGB(255, 89, 63, 54) //secondary
          ,
          onSurface: Color.fromARGB(255, 65, 53, 45) // primary // onSecondary
          ,
          secondaryContainer: Color.fromARGB(255, 26, 26, 26)),
      snackBarTheme: const SnackBarThemeData(
          contentTextStyle:
              TextStyle(color: Color.fromARGB(255, 242, 242, 242))),
      disabledColor: const Color.fromARGB(255, 138, 120, 106),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        backgroundColor: const Color.fromARGB(255, 89, 63, 54) //secondary
        ,
        foregroundColor: const Color.fromARGB(255, 191, 167, 147) //primary
        ,
      ),
      scaffoldBackgroundColor:
          const Color.fromARGB(255, 12, 12, 12) //backgroundColor
      ,
      shadowColor: const Color.fromARGB(255, 89, 63, 54) //secondary
      ,
      splashColor: const Color.fromARGB(48, 89, 63, 54) //secondary
      ,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(),
        bodyMedium: TextStyle(),
        bodySmall: TextStyle(),
        displayLarge: TextStyle(),
        displayMedium: TextStyle(),
        displaySmall: TextStyle(),
        headlineLarge: TextStyle(),
        headlineMedium: TextStyle(
          fontSize: 20,
          color: Color.fromARGB(255, 12, 12, 12) // primary
          ,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          color: Color.fromARGB(255, 89, 63, 54) // primary
          ,
          fontWeight: FontWeight.w800,
          fontSize: 33,
        ),
        labelLarge: TextStyle(fontWeight: FontWeight.w300),
        labelMedium: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 12, 12, 12) //backgroundColor

            ),
        labelSmall:
            TextStyle(fontWeight: FontWeight.w300, color: Colors.blueGrey),
        titleLarge: TextStyle(),
        titleMedium: TextStyle(),
        titleSmall: TextStyle(),
      ),
      dialogTheme: DialogTheme(
        elevation: 1,
        backgroundColor: const Color.fromARGB(255, 12, 12, 12) //backgroundColor
        ,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
      appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0,
        shadowColor: Color.fromARGB(255, 89, 63, 54),
        backgroundColor: Color.fromARGB(255, 12, 12, 12) //background

        ,
        foregroundColor: Color.fromARGB(255, 89, 63, 54) //secondary

        ,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Color.fromARGB(255, 191, 167, 147),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: Color.fromARGB(255, 12, 12, 12) //backgroundColor,
        ,
      ),
      listTileTheme: const ListTileThemeData(
          titleTextStyle: TextStyle(
            color: Color.fromARGB(255, 89, 63, 54) //secondary
            ,
            fontWeight: FontWeight.w500,
            fontSize: 25,
          ),
          iconColor: Color.fromARGB(255, 89, 63, 54) //secondary
          ),
    ),
  ];

//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//

  static List<ThemeData> grey = [
    ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color.fromARGB(255, 12, 12, 12),
          onPrimary: Color.fromARGB(255, 165, 165, 165),
          secondary: Color.fromARGB(255, 89, 89, 86),
          onSecondary: Color.fromARGB(255, 242, 242, 242) // primary
          ,
          tertiary: Color.fromARGB(255, 67, 67, 65),
          onTertiary: Colors.black,
          error: Color.fromARGB(255, 221, 57, 46),
          onError: Colors.white,
          background: Color.fromARGB(255, 242, 242, 242),
          onBackground: Colors.black,
          surface: Color.fromARGB(255, 89, 89, 86) //secondary
          ,
          onSurface:
              Color.fromARGB(255, 165, 165, 165) // primary // onSecondary
          ,
          secondaryContainer: Color.fromARGB(255, 225, 225, 225)),
      snackBarTheme: const SnackBarThemeData(
          contentTextStyle: TextStyle(color: Color.fromARGB(255, 12, 12, 12))),
      disabledColor: const Color.fromARGB(255, 165, 165, 165),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        backgroundColor: const Color.fromARGB(255, 89, 89, 86) //secondary
        ,
        foregroundColor: const Color.fromARGB(255, 242, 242, 242) //primary
        ,
      ),
      scaffoldBackgroundColor:
          const Color.fromARGB(255, 242, 242, 242) //backgroundColor
      ,
      shadowColor: const Color.fromARGB(255, 89, 89, 86) //secondary
      ,
      splashColor: const Color.fromARGB(48, 89, 89, 86) //secondary
      ,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(),
        bodyMedium: TextStyle(),
        bodySmall: TextStyle(),
        displayLarge: TextStyle(),
        displayMedium: TextStyle(),
        displaySmall: TextStyle(),
        headlineLarge: TextStyle(),
        headlineMedium: TextStyle(
          fontSize: 20,
          color: Color.fromARGB(255, 242, 242, 242) // primary
          ,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          color: Color.fromARGB(255, 89, 89, 86) // primary
          ,
          fontWeight: FontWeight.w800,
        ),
        labelLarge: TextStyle(fontWeight: FontWeight.w300),
        labelMedium: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 242, 242, 242) //backgroundColor
            ),
        labelSmall:
            TextStyle(fontWeight: FontWeight.w300, color: Colors.blueGrey),
        titleLarge: TextStyle(),
        titleMedium: TextStyle(),
        titleSmall: TextStyle(),
      ),
      dialogTheme: DialogTheme(
        elevation: 1,
        backgroundColor:
            const Color.fromARGB(255, 242, 242, 242) //backgroundColor
        ,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
      appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0,
        shadowColor: Color.fromARGB(255, 89, 89, 86),
        backgroundColor: Color.fromARGB(255, 242, 242, 242) //secondary
        ,
        foregroundColor: Color.fromARGB(255, 89, 89, 86) //primary

        ,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color.fromARGB(255, 89, 89, 86),
        unselectedItemColor: Color.fromARGB(255, 165, 165, 165),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: Color.fromARGB(255, 242, 242, 242) //backgroundColor
        ,
      ),
      listTileTheme: const ListTileThemeData(
          titleTextStyle: TextStyle(
            color: Color.fromARGB(255, 89, 89, 86) //primary
            ,
            fontWeight: FontWeight.w500,
            fontSize: 25,
          ),
          iconColor: Color.fromARGB(255, 89, 89, 86) //primary
          ),
    ),
    ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color.fromARGB(255, 242, 242, 242),
          onPrimary: Color.fromARGB(255, 140, 140, 135),
          secondary: Color.fromARGB(255, 89, 89, 86),
          onSecondary: Color.fromARGB(255, 12, 12, 12) // primary
          ,
          tertiary: Color.fromARGB(255, 123, 123, 119),
          onTertiary: Colors.white,
          error: Color.fromARGB(255, 221, 57, 46),
          onError: Colors.black,
          background: Color.fromARGB(255, 12, 12, 12),
          onBackground: Colors.white,
          surface: Color.fromARGB(255, 89, 89, 86) //secondary
          ,
          onSurface:
              Color.fromARGB(255, 140, 140, 135) // primary // onSecondary
          ,
          secondaryContainer: Color.fromARGB(255, 44, 44, 44)),
      snackBarTheme: const SnackBarThemeData(
          contentTextStyle:
              TextStyle(color: Color.fromARGB(255, 242, 242, 242))),
      disabledColor: const Color.fromARGB(255, 140, 140, 135),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        backgroundColor: const Color.fromARGB(255, 89, 89, 86) //secondary
        ,
        foregroundColor: const Color.fromARGB(255, 140, 140, 135) //primary
        ,
      ),
      scaffoldBackgroundColor:
          const Color.fromARGB(255, 12, 12, 12) //backgroundColor
      ,
      shadowColor: const Color.fromARGB(255, 89, 89, 86) //secondary
      ,
      splashColor: const Color.fromARGB(48, 89, 89, 86) //secondary
      ,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(),
        bodyMedium: TextStyle(),
        bodySmall: TextStyle(),
        displayLarge: TextStyle(),
        displayMedium: TextStyle(),
        displaySmall: TextStyle(),
        headlineLarge: TextStyle(),
        headlineMedium: TextStyle(
          fontSize: 20,
          color: Color.fromARGB(255, 12, 12, 12) // primary
          ,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          color: Color.fromARGB(255, 89, 89, 86) // primary
          ,
          fontWeight: FontWeight.w800,
          fontSize: 33,
        ),
        labelLarge: TextStyle(fontWeight: FontWeight.w300),
        labelMedium: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 12, 12, 12) //backgroundColor

            ),
        labelSmall:
            TextStyle(fontWeight: FontWeight.w300, color: Colors.blueGrey),
        titleLarge: TextStyle(),
        titleMedium: TextStyle(),
        titleSmall: TextStyle(),
      ),
      dialogTheme: DialogTheme(
        elevation: 1,
        backgroundColor: const Color.fromARGB(255, 12, 12, 12) //backgroundColor
        ,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
      appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0,
        shadowColor: Color.fromARGB(255, 89, 89, 86),
        backgroundColor: Color.fromARGB(255, 12, 12, 12) //background

        ,
        foregroundColor: Color.fromARGB(255, 89, 89, 86) //secondary

        ,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Color.fromARGB(255, 140, 140, 135),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: Color.fromARGB(255, 12, 12, 12) //backgroundColor,
        ,
      ),
      listTileTheme: const ListTileThemeData(
          titleTextStyle: TextStyle(
            color: Color.fromARGB(255, 89, 89, 86) //secondary
            ,
            fontWeight: FontWeight.w500,
            fontSize: 25,
          ),
          iconColor: Color.fromARGB(255, 89, 89, 86) //secondary
          ),
    ),
  ];
}

// /* Color Theme Swatches in Hex */
// .Leblon-Steak-1-hex { color: #BF9460; }
// .Leblon-Steak-2-hex { color: #F2F2F2; }
// .Leblon-Steak-3-hex { color: #A6A6A6; }
// .Leblon-Steak-4-hex { color: #595959; }
// .Leblon-Steak-5-hex { color: #0D0D0D; }

// /* Color Theme Swatches in RGBA */
// .Leblon-Steak-1-rgba { color: rgba(191, 148, 95, 1); }
// .Leblon-Steak-2-rgba { color: rgba(242, 242, 242, 1); }
// .Leblon-Steak-3-rgba { color: rgba(165, 165, 165, 1); }
// .Leblon-Steak-4-rgba { color: rgba(89, 89, 89, 1); }
// .Leblon-Steak-5-rgba { color: rgba(12, 12, 12, 1); }

// /* Color Theme Swatches in HSLA */
// .Leblon-Steak-1-hsla { color: hsla(33, 42, 56, 1); }
// .Leblon-Steak-2-hsla { color: hsla(0, 0, 95, 1); }
// .Leblon-Steak-3-hsla { color: hsla(0, 0, 65, 1); }
// .Leblon-Steak-4-hsla { color: hsla(0, 0, 35, 1); }
// .Leblon-Steak-5-hsla { color: hsla(0, 0, 5, 1); }

/* Color Theme Swatches in Hex */
// .luxury-1-hex { color: #595956; }
// .luxury-2-hex { color: #8C8C88; }
// .luxury-3-hex { color: #BFBFBD; }
// .luxury-4-hex { color: #262626; }
// .luxury-5-hex { color: #0D0D0D; }

// /* Color Theme Swatches in RGBA */
// .luxury-1-rgba { color: rgba(89, 89, 86, 1); }
// .luxury-2-rgba { color: rgba(140, 140, 135, 1); }
// .luxury-3-rgba { color: rgba(191, 191, 188, 1); }
// .luxury-4-rgba { color: rgba(38, 38, 38, 1); }
// .luxury-5-rgba { color: rgba(13, 13, 13, 1); }

// /* Color Theme Swatches in HSLA */
// .luxury-1-hsla { color: hsla(60, 1, 34, 1); }
// .luxury-2-hsla { color: hsla(60, 1, 54, 1); }
// .luxury-3-hsla { color: hsla(60, 1, 74, 1); }
// .luxury-4-hsla { color: hsla(0, 0, 14, 1); }
// .luxury-5-hsla { color: hsla(0, 0, 5, 1); }

// /* Color Theme Swatches in Hex */
// $Basalte-x-Porsche-1-hex: #6D7E8C;
// $Basalte-x-Porsche-2-hex: #BFA893;
// $Basalte-x-Porsche-3-hex: #A67356;
// $Basalte-x-Porsche-4-hex: #594036;
// $Basalte-x-Porsche-5-hex: #40140A;

// /* Color Theme Swatches in RGBA */
// $Basalte-x-Porsche-1-rgba: rgba(109,125,140, 1);
// $Basalte-x-Porsche-2-rgba: rgba(191,167,147, 1);
// $Basalte-x-Porsche-3-rgba: rgba(165,115,86, 1);
// $Basalte-x-Porsche-4-rgba: rgba(89,63,54, 1);
// $Basalte-x-Porsche-5-rgba: rgba(63,20,10, 1);

// /* Color Theme Swatches in HSLA */
// $Basalte-x-Porsche-1-hsla: hsla(208, 12, 48, 1);
// $Basalte-x-Porsche-2-hsla: hsla(28, 25, 66, 1);
// $Basalte-x-Porsche-3-hsla: hsla(22, 31, 49, 1);
// $Basalte-x-Porsche-4-hsla: hsla(16, 24, 28, 1);
// $Basalte-x-Porsche-5-hsla: hsla(11, 72, 14, 1);

// /* Color Theme Swatches in Hex */
// .Black-Waters-for-@bazaarindia-May-2022-1-hex { color: #4D7A8C; }
// .Black-Waters-for-@bazaarindia-May-2022-2-hex { color: #85A6A6; }
// .Black-Waters-for-@bazaarindia-May-2022-3-hex { color: #AABFB9; }
// .Black-Waters-for-@bazaarindia-May-2022-4-hex { color: #C7D9D2; }
// .Black-Waters-for-@bazaarindia-May-2022-5-hex { color: #262626; }

// /* Color Theme Swatches in RGBA */
// .Black-Waters-for-@bazaarindia-May-2022-1-rgba { color: rgba(77, 122, 140, 1); }
// .Black-Waters-for-@bazaarindia-May-2022-2-rgba { color: rgba(132, 165, 165, 1); }
// .Black-Waters-for-@bazaarindia-May-2022-3-rgba { color: rgba(170, 191, 185, 1); }
// .Black-Waters-for-@bazaarindia-May-2022-4-rgba { color: rgba(199, 216, 210, 1); }
// .Black-Waters-for-@bazaarindia-May-2022-5-rgba { color: rgba(38, 38, 38, 1); }

// /* Color Theme Swatches in HSLA */
// .Black-Waters-for-@bazaarindia-May-2022-1-hsla { color: hsla(196, 29, 42, 1); }
// .Black-Waters-for-@bazaarindia-May-2022-2-hsla { color: hsla(180, 15, 58, 1); }
// .Black-Waters-for-@bazaarindia-May-2022-3-hsla { color: hsla(163, 14, 70, 1); }
// .Black-Waters-for-@bazaarindia-May-2022-4-hsla { color: hsla(157, 18, 81, 1); }
// .Black-Waters-for-@bazaarindia-May-2022-5-hsla { color: hsla(0, 0, 15, 1); }
