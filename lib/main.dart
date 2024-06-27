import 'package:flutter/material.dart';
import 'package:sq_flite/db/functions/functions.dart';
import 'package:sq_flite/screens/screen_home.dart';

Future<void>main()async{
     WidgetsFlutterBinding.ensureInitialized();
     await initialDatabase(); 
        runApp(const MyApp());
      }
      class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScreenHome(),
    );
  }
}  