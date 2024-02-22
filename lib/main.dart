import 'package:ecomerce/login/login.dart';
import 'package:ecomerce/provider/cartprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => Cart())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // theme: ,
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
