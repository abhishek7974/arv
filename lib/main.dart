import 'package:arv_ssign/colors.dart';
import 'package:arv_ssign/screens/home_screen.dart';
import 'package:arv_ssign/viewModel/HomeModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeModel>(create: (_) => HomeModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Arv',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colours.scaffoldBgColor,
          useMaterial3: true,
        ),
        home: HomePage(),
      ),
    );
  }
}
