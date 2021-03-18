import 'package:bytebank/screens/dashboard/saldo_card.dart';
import 'package:bytebank/screens/deposito/formulario_deposito.dart';
import 'package:bytebank/screens/transferencia/formulario.dart';
import 'package:bytebank/screens/transferencia/lista.dart';
import 'package:bytebank/screens/transferencia/ultimas_transferencias.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bytebank'),
      ),
      body: ListView(children: [
        Align(
          child: SaldoCard(),
          alignment: Alignment.topCenter,
        ),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FormularioDeposito();
                }));
              },
              child: Text('Receber depósito'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FormularioTransferencia();
                }));
              },
              child: Text('Nova transferência'),
            ),
          ],
        ),
        UltimasTransferencias()
      ]),
    );
  }
}
