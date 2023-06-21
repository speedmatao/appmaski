import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:webmaskitchen/screens/splash_screen.dart';
import 'package:webmaskitchen/screens/home_page.dart';
import 'package:webmaskitchen/share_prefers/preferencias_usuario.dart';
import 'package:webmaskitchen/theme/light_colors.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter/services.dart' show rootBundle;

final navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = PreferenciasUsuario();
  await prefs.initPrefs();

  Future<void> leerArchivo() async {
    try {
      String contenido =
          await rootBundle.loadString('assets/configuracion/datosEmpresa.txt');
      List<String> partes = contenido.split('|');

      if (partes.length == 2) {
        prefs.idEmpresa = partes[0];
        prefs.ipEmpresa = partes[1];
        // Hacer algo con los valores (por ejemplo, almacenarlos en variables)
      } else {}
    } catch (e) {
      // print('Error al leer el archivo: $e');
    }
  }

  leerArchivo();

  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es'), // Español
        Locale('en'), // ingles
      ],
      locale: const Locale('es'),
      title: "Maskitchen",
      theme: ThemeData(
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            foregroundColor: LightColors().kLavender),
        useMaterial3: true,
        textTheme: Theme.of(context).textTheme.apply(
            bodyColor: LightColors().kDarkBlue,
            displayColor: LightColors().kDarkBlue,
            fontFamily: 'Poppins'),
      ),
      initialRoute: SplashPage.routeName,
      routes: {
        HomePage.routeName: (BuildContext context) => const HomePage(),
        SplashPage.routeName: (BuildContext context) => const SplashPage(),
        // ObrasForm.routeName: (BuildContext context) => ObrasForm(),
      },
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
    );
  }
}
