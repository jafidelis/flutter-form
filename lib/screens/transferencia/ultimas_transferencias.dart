import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/models/transferencias.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'lista.dart';

const _titulo = 'Últimas transferências';

class UltimasTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _titulo,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        Consumer<Transferencias>(builder: (context, transferencias, child) {
          final int _quantidade = transferencias.transferencias.length;
          if (_quantidade == 0) {
            return SemtransferenciaCadastrada();
          }
          final List<Transferencia> _ultimasTransferencias =
              transferencias.transferencias.reversed.toList();
          return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _quantidade < 2 ? _quantidade : 2,
              shrinkWrap: true,
              itemBuilder: (context, indice) {
                return ItemTransferencia(_ultimasTransferencias[indice]);
              });
        }),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ListaTransferencias();
            }));
          },
          child: Text('Ver todas transferências'),
        ),
      ],
    );
  }
}

class SemtransferenciaCadastrada extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(40),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          'Você ainda não cadastrou nenhuma transferências',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
