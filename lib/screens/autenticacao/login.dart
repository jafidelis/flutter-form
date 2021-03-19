import 'package:brasil_fields/brasil_fields.dart';
import 'package:bytebank/components/mensagem.dart';
import 'package:bytebank/screens/autenticacao/registrar.dart';
import 'package:bytebank/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatelessWidget {
  TextEditingController _cpfController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/images/bytebank_logo.png',
                  height: 100,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 300,
                  height: 455,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: _construirFormulario(context),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Theme.of(context).accentColor,
    );
  }

  Widget _construirFormulario(context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            'Faça seu login',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'CPF',
            ),
            maxLength: 14,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CpfInputFormatter(),
            ],
            validator: (value) {
              if (value.length == 0) {
                return 'Informe o cpf';
              }
              if (value.length < 11) {
                return 'CPF inválido';
              }
              return null;
            },
            keyboardType: TextInputType.number,
            controller: _cpfController,
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Senha',
            ),
            maxLength: 15,
            validator: (value) {
              if (value.length == 0) {
                return 'Informe uma senha';
              }
              return null;
            },
            controller: _senhaController,
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            width: double.maxFinite,
            child: OutlinedButton(
              style: ButtonStyle(
                // textStyle: TextStyle(color: Theme.of(context).accentColor)
                foregroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).accentColor),
                side: MaterialStateProperty.all<BorderSide>(
                  BorderSide(
                    width: 2,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                overlayColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(71, 161, 56, 0.2)),
              ),
              child: Text('CONTINUAR'),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  if (_cpfController.text == '111.111.111-11' &&
                      _senhaController.text == 'abc123') {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Dashboard(),
                      ),
                      (route) => false,
                    );
                  } else {
                    exibirAlerta(
                      context: context,
                      titulo: 'ATENÇÃO',
                      content: 'CPF ou Senha incorretos',
                    );
                  }
                }
              },
            ),
          ),
          SizedBox(height: 15),
          Text(
            'Esqueci minha senha >',
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15),
          OutlinedButton(
            style: ButtonStyle(
                // textStyle: TextStyle(color: Theme.of(context).accentColor)
                foregroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).accentColor),
                side: MaterialStateProperty.all<BorderSide>(
                  BorderSide(
                    width: 2,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                overlayColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(71, 161, 56, 0.2))),
            child: Text('Criar uma conta >'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Registrar()),
              );
            },
          ),
        ],
      ),
    );
  }
}
