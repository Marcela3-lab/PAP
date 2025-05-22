import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SairshProvider extends ChangeNotifier {
  Future<bool> dadoslocais() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('id');
    prefs.remove('nome');
    int? iduser = prefs.getInt('id');
    String? nome = prefs.getString('nome');

    print("ID DADOS LOCAIS: $iduser");
    print("NOME DADOS LOCAIS: $nome");
    if (iduser == null && nome == null) {
      return true;
    } else {
      print("Conta ainda iniciada");
      return false;
    }
  }
}
