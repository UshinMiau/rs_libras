import 'package:flutter/material.dart';
import 'package:rs_libras/view/category/category.dart';
import 'package:rs_libras/view/edit_client/edit_client.dart';
import 'package:rs_libras/view/element_category/element_category.dart';
import 'package:rs_libras/view/color_schemes.g.dart';
import 'package:rs_libras/view/home/home.dart';
import 'package:rs_libras/view/login/sign_in.dart';
import 'package:rs_libras/view/login/sign_up.dart';
import 'package:rs_libras/view/profile/profile.dart';

void main() {
  runApp(
    MaterialApp(
      title: "RS Libras",
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => const Home(),
        "/category": (context) => const Category(),
        "/element": (context) => const ElementCategory(),
        "/sign_in": (context) => const SignIn(),
        "/sign_up": (context) => const SignUp(),
        "/profile": (context) => const Profile(),
        '/edit_client': (context) => const EditClient(),
      },
      initialRoute: "/",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      themeMode: ThemeMode.light,
    ),
  );
}
