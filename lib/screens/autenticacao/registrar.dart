import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:bytebank/components/biometria.dart';
import 'package:bytebank/models/cliente.dart';
import 'package:bytebank/screens/dashboard/dashboard.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';
import 'package:image_picker/image_picker.dart';

class Registrar extends StatelessWidget {
  final _formUserData = GlobalKey<FormState>();
  final _formUserAddress = GlobalKey<FormState>();
  final _formUserAuth = GlobalKey<FormState>();

  // Step 1
  final TextEditingController _nomeControler = TextEditingController();
  final TextEditingController _emailControler = TextEditingController();
  final TextEditingController _cpfControler = TextEditingController();
  final TextEditingController _celularControler = TextEditingController();
  final TextEditingController _nascimentoControler = TextEditingController();

  // Step2
  final TextEditingController _cepControler = TextEditingController();
  final TextEditingController _estadoControler = TextEditingController();
  final TextEditingController _cidadeControler = TextEditingController();
  final TextEditingController _bairroControler = TextEditingController();
  final TextEditingController _logradouroControler = TextEditingController();
  final TextEditingController _numeroControler = TextEditingController();

  // Step 3
  final TextEditingController _senhaControler = TextEditingController();
  final TextEditingController _confirmarSenhaControler =
      TextEditingController();
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de cliente'),
      ),
      body: Consumer<Cliente>(
        builder: (context, cliente, child) {
          return Stepper(
            currentStep: cliente.stepAtual,
            onStepContinue: () {
              final functions = [
                _salvarStep1,
                _salvarStep2,
                _salvarStep3,
              ];
              return functions[cliente.stepAtual](context);
            },
            onStepCancel: () {
              return cliente.stepAtual =
                  cliente.stepAtual > 0 ? cliente.stepAtual - 1 : 0;
            },
            steps: _construirSteps(context, cliente),
            controlsBuilder: (context, {onStepContinue, onStepCancel}) {
              return Padding(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    ElevatedButton(
                        onPressed: onStepContinue, child: Text('Salvar')),
                    Padding(padding: EdgeInsets.only(right: 20)),
                    ElevatedButton(
                      onPressed: onStepCancel,
                      child: Text('Voltar'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _salvar(BuildContext context) {
    Provider.of<Cliente>(context, listen: false).nome = _nomeControler.text;
  }

  void _salvarStep1(context) {
    // if (_formUserData.currentState.validate()) {
    Cliente cliente = Provider.of<Cliente>(context, listen: false);
    cliente.nome = _nomeControler.text;
    _proximoStep(context);
    // }
  }

  void _salvarStep2(context) {
    // if (_formUserAddress.currentState.validate()) {
    _proximoStep(context);
    // }
  }

  void _salvarStep3(context) {
    // if (_formUserAuth.currentState.validate()) {
    FocusScope.of(context).unfocus();
    Provider.of<Cliente>(context, listen: false).imagemRG = null;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Dashboard()),
      (route) => false,
    );
    // }
  }

  List<Step> _construirSteps(BuildContext context, Cliente cliente) {
    List<Step> steps = [
      step1Form(context, cliente),
      step2Form(context, cliente),
      step3Form(context, cliente)
    ];
    return steps;
  }

  Step step1Form(BuildContext context, Cliente cliente) {
    return Step(
      title: Text('Seus dados'),
      isActive: cliente.stepAtual >= 0,
      content: Form(
        key: _formUserData,
        child: Column(
          children: [
            TextFormField(
              controller: _nomeControler,
              maxLength: 255,
              decoration: InputDecoration(labelText: 'Nome'),
              validator: (value) {
                if (value.length < 3) {
                  return 'Nome inválido';
                }
                if (!value.contains(" ")) {
                  return 'Informe pelo menos um sobrenome';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _emailControler,
              maxLength: 255,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) =>
                  Validator.email(value) ? 'Email inválido' : null,
            ),
            TextFormField(
              controller: _cpfControler,
              maxLength: 14,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'CPF'),
              validator: (value) =>
                  Validator.cpf(value) ? 'CPF inválido' : null,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CpfInputFormatter()
              ],
            ),
            TextFormField(
              controller: _celularControler,
              maxLength: 14,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Celular'),
              validator: (value) =>
                  Validator.phone(value) ? 'Celular inválido' : null,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                TelefoneInputFormatter()
              ],
            ),
            DateTimePicker(
              controller: _nascimentoControler,
              type: DateTimePickerType.date,
              firstDate: DateTime(1950),
              lastDate: DateTime(2100),
              dateLabelText: 'Nascimento',
              dateMask: 'dd/MM/yyyy',
              validator: (value) {
                if (value.isEmpty) {
                  return 'Data inválida';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Step step2Form(BuildContext context, Cliente cliente) {
    return Step(
      title: Text('Endereço'),
      isActive: cliente.stepAtual >= 1,
      content: Form(
        key: _formUserAddress,
        child: Column(
          children: [
            TextFormField(
              controller: _cepControler,
              maxLength: 10,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'CEP'),
              // validator: (value) => Validator.cep(value) ? 'CEP inválido' : null,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CepInputFormatter()
              ],
            ),
            DropdownButtonFormField(
              isExpanded: true,
              decoration: InputDecoration(labelText: 'Estado'),
              items: Estados.listaEstadosSigla
                  .map(
                    (e) => DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    ),
                  )
                  .toList(),
              onChanged: (String novoEstadoSelecionado) {
                _estadoControler.text = novoEstadoSelecionado;
              },
              validator: (value) {
                if (value == null) {
                  return 'Selecione um estado';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _cidadeControler,
              maxLength: 255,
              decoration: InputDecoration(labelText: 'Cidade'),
              validator: (value) {
                if (value.length < 3) {
                  return 'Cidade inválida';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _bairroControler,
              maxLength: 255,
              decoration: InputDecoration(labelText: 'Bairro'),
              validator: (value) {
                if (value.length < 3) {
                  return 'Bairro inválido';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _logradouroControler,
              maxLength: 255,
              decoration: InputDecoration(labelText: 'Logradouro'),
              validator: (value) {
                if (value.length < 3) {
                  return 'Logradouro inválido';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _numeroControler,
              maxLength: 255,
              decoration: InputDecoration(labelText: 'Número'),
            ),
          ],
        ),
      ),
    );
  }

  Step step3Form(BuildContext context, Cliente cliente) {
    return Step(
        title: Text('Autenticação'),
        isActive: cliente.stepAtual >= 2,
        content: Form(
          key: _formUserAuth,
          child: Column(
            children: [
              TextFormField(
                controller: _senhaControler,
                maxLength: 255,
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (value) {
                  if (value.length < 8) {
                    return 'Senha muito curta';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _confirmarSenhaControler,
                maxLength: 255,
                decoration: InputDecoration(labelText: 'Confirmar senha'),
                obscureText: true,
                validator: (value) {
                  if (value != _senhaControler.text) {
                    return 'Senha não confere';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              Text(
                'Para prosseguir com o seu cadastro é necessário que tenha uma foto do seu RG.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () => _capturarRG(cliente),
                child: Text('Tirar foto do meu RG'),
              ),
              _jaEnvioRG(context) ? _imageDoRG(context) : _pedidoDeRG(context),
              Biometria()
            ],
          ),
        ));
  }

  _proximoStep(context) {
    Cliente cliente = Provider.of<Cliente>(context, listen: false);
    irPara(cliente.stepAtual + 1, cliente);
  }

  void irPara(int step, Cliente cliente) {
    cliente.stepAtual = step;
  }

  void _capturarRG(Cliente cliente) async {
    final pickedImage = await _picker.getImage(source: ImageSource.camera);
    cliente.imagemRG = File(pickedImage.path);
  }

  bool _jaEnvioRG(BuildContext context) {
    return Provider.of<Cliente>(context, listen: false).imagemRG != null;
  }

  Column _pedidoDeRG(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15),
        Text(
          'Foto do RG pendente',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Image _imageDoRG(BuildContext context) {
    return Image.file(Provider.of<Cliente>(context, listen: false).imagemRG);
  }
}
