import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/saldo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _tituloAppBar = 'Receber depósito';
const _dicaCampoValor = '0.00';
const _rotuloCampoValor = 'Valor';
const _textoBotaoConfirmar = 'Confirmar';

class FormularioDeposito extends StatelessWidget {
  final TextEditingController _controladorCampoValor = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      body:  SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
              dica: _dicaCampoValor,
              controlador: _controladorCampoValor,
              rotulo: _rotuloCampoValor,
              icone: Icons.monetization_on,
            ),
            ElevatedButton(
              child: Text(_textoBotaoConfirmar),
              onPressed: () => _criaDeposito(context),
            ),
          ],
        ),
      ),
    );
  }

  void _criaDeposito(BuildContext context) {
    final double valor = double.tryParse(_controladorCampoValor.text);
    if (_validaDeposito(valor)) {
      _atualizaEstado(context, valor);
      Navigator.pop(context);
    }
  }

  bool _validaDeposito(valor) {
    return valor != null;
  }

  void _atualizaEstado(context, valor) {
    Provider.of<Saldo>(context, listen: false).adiciona(valor);
  }
}
