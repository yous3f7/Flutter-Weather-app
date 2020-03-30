import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/constants.dart';
import 'core/global/CoreStyle.dart';
import 'core/global/route.dart';
import 'features/weather/preseintation/bloc/bloc.dart';
import 'features/weather/preseintation/page/home_page.dart';
class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: BlocProvider(
      create: (_)=> WeatherBloc(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          // set this Widget as root
          initialRoute: '/',
          onGenerateRoute: Router.generateRoute,
          title: TITLE_APP_NAME,
          themeMode: ThemeMode.light,
          theme: ThemeData(
              fontFamily: GoogleFonts.oxygen().fontFamily,
              appBarTheme: AppBarTheme(
                color: CoreStyle.primaryTheme,
              ),
              primaryColor: CoreStyle.primaryTheme,
              accentColor: CoreStyle.primaryLightTheme,
              snackBarTheme: const SnackBarThemeData(
                actionTextColor: CoreStyle.white,
                backgroundColor: CoreStyle.primaryTheme,

                behavior: SnackBarBehavior.fixed,
                elevation: 5.0,),
              scaffoldBackgroundColor: Colors.grey[200]
          ),
          home:HomePage()
        )
      )
    );
  }
}