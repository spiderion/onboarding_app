import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/constants/material_constants/material_constants.dart';

ThemeData baseTheme = ThemeData(
    colorScheme: baseColorScheme,
    primarySwatch: primarySwatch,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.red),
    cardTheme: CardTheme(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
    appBarTheme: AppBarTheme(backgroundColor: baseColorScheme.background, centerTitle: true),
    textTheme: _textTheme,
    shadowColor: Colors.black12,
    iconTheme: IconThemeData(color: Colors.black),
    elevatedButtonTheme: _elevatedButtonTheme,
    outlinedButtonTheme: _outlineButtonThemeData(),
    dialogTheme: DialogTheme(
        backgroundColor: baseColorScheme.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MaterialConstants.ALERT_DIALOG_RADIUS)),
        contentTextStyle: TextStyle()),
    buttonTheme: ButtonThemeData(buttonColor: baseColorScheme.primary, shape: StadiumBorder()),
    fontFamily: MaterialFont.PRIMARY);

ElevatedButtonThemeData _elevatedButtonTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))));

TextTheme _textTheme =
    TextTheme(headline6: _appBarTextStyle, headline5: TextStyle(fontFamily: MaterialFont.TERTIARY, fontSize: 28));

TextStyle _appBarTextStyle = TextStyle(fontWeight: MaterialFontWeight.BOLD);

OutlinedButtonThemeData _outlineButtonThemeData() => OutlinedButtonThemeData(
        style: ButtonStyle(
      shape: MaterialStateProperty.all(StadiumBorder()),
      side: MaterialStateProperty.all(BorderSide(color: primarySwatch)),
    ));

MaterialColor primarySwatch = Colors.yellow;

ColorScheme baseColorScheme = ColorScheme.dark(
    primary: Color(0xFF28AFFA),
    onPrimary: Color(0xFFFFFFFF),
    primaryVariant: Color(0xFF054A91),
    secondary: Color(0xFFA823CD),
    onSecondary: Color(0xFFFFFFFF),
    secondaryVariant: Color(0xFFF3762C),
    background: Color.fromRGBO(24, 28, 34, 1),
    error: Color(0xFFB00020),
    onError: Color(0xFFFFFFFF),
    brightness: Brightness.light);
