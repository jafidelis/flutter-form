import 'package:bytebank/models/transferencias.dart';
import 'package:bytebank/screens/autenticacao/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/saldo.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Saldo(0)),
        ChangeNotifierProvider(create: (context) => Transferencias())
      ],
      child: BytebankApp(),
    ));

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green[900],
        accentColor: Color.fromRGBO(71, 161, 53, 1),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent[700],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: Login(),
    );
  }
}
