import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:recipe_book/pages/home_page.dart';
import 'package:recipe_book/pages/login_page.dart';
import 'package:window_manager/window_manager.dart';
import 'dart:io' show Platform;

void main() async {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();
  }

  runApp(const RecipeBook());
}

class RecipeBook extends StatelessWidget {
  const RecipeBook({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        onGenerateTitle: (context) {
          if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
            WindowOptions windowOptions = WindowOptions(
                center: true, title: AppLocalizations.of(context)!.appTitle);

            windowManager.waitUntilReadyToShow(windowOptions, () async {
              await windowManager.show();
              await windowManager.focus();
            });
          }
          return AppLocalizations.of(context)!.appTitle;
        },
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
            appBarTheme: const AppBarTheme(
                titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
            useMaterial3: true),
        initialRoute: "/login",
        routes: {
          "/login": (context) => const LoginPage(),
          "/home": (context) => const HomePage()
        });
  }
}
