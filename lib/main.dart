import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/screens/home/index.dart';
import 'package:oktoast/oktoast.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: "test app",
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
            primaryColor: Colors.orangeAccent,
            shadowColor: Colors.white,
            scaffoldBackgroundColor: const Color.fromARGB(255, 10, 4, 0)),
        home: const IndexScreen(),
      ),
    );
  }
}
