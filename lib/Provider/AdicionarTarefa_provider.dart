import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdicionartarefaProvider extends ChangeNotifier {
  RegExp formatoh = RegExp(r"^(?:[01]?[0-9]|2[0-3]):([0-5]?[0-9])$");

//converte hora pro formato que da pra verificar
  DateTime converterHora(String hora) {
    String hoje = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String horaeData = "$hoje $hora";
    return DateFormat("yyyy-MM-dd HH:mm").parse(horaeData);
  }

  //faz conversão pq so da pra verificar DateTime
  bool verificarHoraMaiorQue(inicio, fim) {
    DateTime iniciohora = converterHora(inicio);
    DateTime fimhora = converterHora(fim);
    return fimhora.isAfter(iniciohora);
  }

//funcao principal verifica tudo antes de enviar

  Future<bool> verificarcamposagenda(
    BuildContext context,
    titulo,
    inicio,
    fim,
  ) async {
    if (await VerficarEspacos(context, inicio, inicio, fim) &&
        await verificarFormato(context, inicio, fim) &&
        await verificarMaior(context, inicio, fim)) {
      return true;
    } else {
      return false;
    }
  }

//campos nao vazios
  Future<bool> VerficarEspacos(
      BuildContext context, titulo, inicio, fim) async {
    if (titulo.isEmpty || inicio.isEmpty || fim.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Dados incorretos"),
          content: Text("Preencha todos os campos"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Ok"),
            )
          ],
        ),
      );
      return false;
    } else {
      return true;
    }
  }

//verifica se o formato é horas e minutos
  Future<bool> verificarFormato(BuildContext context, inicio, fim) async {
    if (!formatoh.hasMatch(inicio) || !formatoh.hasMatch(fim)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Dados incorretos"),
          content: Text("O formato dos campos início e fim deve ser: [00:00]"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Ok"),
            )
          ],
        ),
      );
      return false;
    } else {
      return true;
    }
  }

  //usando os dados convertidos pra DateTime verifica se fim é maior que hora
  Future<bool> verificarMaior(BuildContext context, inicio, fim) async {
    if (!verificarHoraMaiorQue(inicio, fim)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Dados incorretos"),
          content: Text("O campo fim deve ser maior que o início"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Ok"),
            )
          ],
        ),
      );
      return false;
    } else {
      return true;
    }
  }

  // Função para enviar a tarefa
  Future<void> enviarTarefa(BuildContext context, String titulo, String inicio,
      String fim, String dia) async {
    String dataexemplo = "2024-01-01";
    String inicioexemplo = "$dataexemplo $inicio";
    String fimexemplo = "$dataexemplo $fim";
    const String url = "http://192.168.1.187/agenda.php";
    final prefs = await SharedPreferences.getInstance();
    int? idUser = prefs.getInt('id');

    if (idUser == null) {
      print("Erro: ID do user não encontrado!");
      return;
    }
    print("Enviando para o backend:");
    print("Título: $titulo");
    print("Início: $inicioexemplo");
    print("Fim: $fimexemplo");
    print("ID usuário: $idUser");
    print("Dia: $dia");

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'titulo': titulo,
          'inicio': inicioexemplo,
          'fim': fimexemplo,
          'id_user': idUser.toString(),
          'dia': dia,
        },
      );
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final data = jsonDecode(response.body);

        if (data["status"] == "sucesso") {
          print(response.body);
        }
        notifyListeners();
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Sucesso"),
            content: Text("Tarefa adicionada com sucesso"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(()),
                child: Text("Ok"),
              )
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Erro"),
            content: Text("Erro ao adicionar tarefa ${response.statusCode}"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Ok"),
              )
            ],
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Erro"),
          content: Text("Não foi possível conectar ao servidor. $e"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Ok"),
            )
          ],
        ),
      );
    }
  }

  Future estado(bool concluida, int idAgenda) async {
    final String url = "http://192.168.1.187/tarefaconcluida.php";

    try {
      final response = await http.post(Uri.parse(url), body: {
        'estado': (concluida) ? 'concluida' : 'pendente',
        'id_agenda': idAgenda.toString(),
      });
      notifyListeners();
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
      }
    } catch (e) {
      print("Erro de conexão: $e");
    }
  }

  Future<void> deletartarefa(id_tarefa) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.187/deletar_tarefas.php'),
      body: {'id_agenda': id_tarefa.toString()},
    );
    if (response.statusCode == 200) {
      print("Tarefa deletada com sucesso!");
    } else {
      print("Erro ao deletar tarefa: ${response.statusCode}");
    }
  }
}
