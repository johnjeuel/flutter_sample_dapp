import 'package:flutter/material.dart';
import 'package:flutter_basic_dapp/pages/home.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const BasicDapp());
}

class BasicDapp extends StatelessWidget {
  const BasicDapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
