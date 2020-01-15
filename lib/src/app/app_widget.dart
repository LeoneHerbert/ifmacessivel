import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ifmaacessivel/src/pages/login/login_module.dart';


class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return MaterialApp(
      title: 'Sistema de Estoque',
      theme: ThemeData(
        primaryColor: Color(0xFF004AA3),
        dividerColor: Color(0xFF658BB3),
        accentColor: Color(0xFF003270),
        highlightColor: Colors.white,
        scaffoldBackgroundColor: Color(0xFFD2E0ED),
        textTheme: TextTheme(
          title: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 16,
          ),
          headline: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          textTheme: TextTheme(
            title: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          color: Color(0xFF004AA3),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: LoginModule(),
    );
  }
}
