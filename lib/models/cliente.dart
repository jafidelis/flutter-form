import 'dart:io';

import 'package:flutter/material.dart';

class Cliente extends ChangeNotifier {
  String _nome;
  String _email;
  String _cpf;
  String _celular;
  String _nascimento;
  String _cep;
  String _estado;
  String _cidade;
  String _bairro;
  String _logradouro;
  String _numero;
  String _senha;
  int _stepAtual = 0;
  File _imagemRG;
  bool _biometria;

  bool get biometria => _biometria;

  set biometria(bool value) {
    _biometria = value;
    notifyListeners();
  }

  set imagemRG(File value) {
    _imagemRG = value;
    notifyListeners();
  }

  File get imagemRG => _imagemRG;

  set stepAtual(int value) {
    _stepAtual = value;
    notifyListeners();
  }

  int get stepAtual => _stepAtual;

  String get nome => _nome;

  String get email => _email;

  String get cpf => _cpf;

  String get celular => _celular;

  String get nascimento => _nascimento;

  String get cep => _cep;

  String get estado => _estado;

  String get cidade => _cidade;

  String get bairro => _bairro;

  String get logradouro => _logradouro;

  String get numero => _numero;

  String get senha => _senha;

  set senha(String value) {
    _senha = value;
  }

  set numero(String value) {
    _numero = value;
  }

  set logradouro(String value) {
    _logradouro = value;
  }

  set bairro(String value) {
    _bairro = value;
  }

  set cidade(String value) {
    _cidade = value;
  }

  set estado(String value) {
    _estado = value;
  }

  set cep(String value) {
    _cep = value;
  }

  set nascimento(String value) {
    _nascimento = value;
  }

  set celular(String value) {
    _celular = value;
  }

  set cpf(String value) {
    _cpf = value;
    notifyListeners();
  }

  set email(String value) {
    _email = value;
  }

  set nome(String value) {
    _nome = value;
    notifyListeners();
  }


}