import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:learn_logs/Interface/vizualizar_progresso.dart';
import 'package:learn_logs/Provider/Adicionarprogresso_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../Provider/dropdown_progressoprovider.dart';

class Progresso extends StatefulWidget {
  const Progresso({super.key});

  @override
  State<Progresso> createState() => _ProgressoState();
}

class _ProgressoState extends State<Progresso> {
  TextEditingController avancoController = TextEditingController();
  TextEditingController tipoAvancoController = TextEditingController();
  CalendarFormat _calendarioformato = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String? _objetivoSelecionado;
  bool usarSugestao = false;
  double _progresso = 0.0;

  @override
  void initState() {
    super.initState();
    Provider.of<ProgressoProvider>(context, listen: false).buscarObjetivos();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProgressoProvider>(context);
    final enviabd = Provider.of<AdicionarProgressoProvider>(context);
    final objetivo = provider.objetivos.firstWhere(
      (obj) => obj['titulo'] == _objetivoSelecionado,
      orElse: () => {'meta': 0, 'tipo': ''},
    );

    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(children: [
        TableCalendar(
            locale: 'pt_PT',
            focusedDay: _focusedDay,
            firstDay: DateTime(2024, 1, 1),
            lastDay: DateTime(2030, 12, 31),
            calendarFormat: _calendarioformato,
            onFormatChanged: (format) {
              setState(() {
                _calendarioformato = format;
              });
            },
            enabledDayPredicate: (day) {
              return !day.isBefore(DateTime.now().subtract(Duration(
                hours: DateTime.now().hour,
                minutes: DateTime.now().minute,
                seconds: DateTime.now().second,
                milliseconds: DateTime.now().millisecond,
                microseconds: DateTime.now().microsecond,
              )));
            },
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selected, focused) {
              setState(() {
                _selectedDay = selected;
                _focusedDay = focused;
              });
            },
            calendarStyle: CalendarStyle(
              todayTextStyle: TextStyle(color: Colors.white),
              todayDecoration: BoxDecoration(
                color: Color.fromARGB(148, 182, 103, 212),
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
              selectedDecoration: BoxDecoration(
                color: Color.fromARGB(255, 120, 5, 173),
                shape: BoxShape.circle,
              ),
            )),
        const SizedBox(height: 20),
        provider.objetivos.isEmpty
            ? const Text("Não há objetivos")
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: DropdownButtonFormField<String>(
                  value: _objetivoSelecionado,
                  hint: const Text("Selecione um objetivo 🏁"),
                  isExpanded: true,
                  items: provider.objetivos.map((obj) {
                    return DropdownMenuItem<String>(
                      value: obj['titulo'].toString(),
                      child: Text(obj['titulo']),
                    );
                  }).toList(),
                  style: TextStyle(
                      color: const Color.fromARGB(255, 95, 11, 143),
                      fontSize: 16), // Cor e tamanho do texto selecionado
                  iconEnabledColor: const Color.fromARGB(
                      255, 255, 167, 211), // Cor do ícone de dropdown
                  iconSize: 30, // Tamanho do ícone de dropdown

                  onChanged: (val) =>
                      setState(() => _objetivoSelecionado = val),
                ),
              ),
        SizedBox(
          height: 20,
        ),
        Icon(
          Icons.rocket,
          size: 40,
          color: Color.fromARGB(255, 143, 33, 134),
        ),
        Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
                width: 500,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 253, 255, 228),
                      Color.fromARGB(255, 251, 230, 255),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        enabled: !usarSugestao,
                        controller: avancoController,
                        keyboardType: TextInputType.number,
                        decoration:
                            const InputDecoration(hintText: 'Quanto concluiu:'),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: tipoAvancoController,
                        decoration:
                            const InputDecoration(hintText: 'horas/minutos'),
                      ),
                      const SizedBox(height: 20),
                      Text("Meta: ${objetivo['meta']} ${objetivo['tipo']}",
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      LinearProgressIndicator(
                        value: _progresso,
                        minHeight: 25,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(
                            const Color.fromARGB(255, 109, 17, 145)),
                      ),
                    ]))),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 13,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 167, 211),
                    foregroundColor: const Color.fromARGB(255, 82, 9, 124),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  onPressed: () {
                    print("objetivo selecionado $_objetivoSelecionado");

                    if (_objetivoSelecionado == null) {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text('Aviso'),
                          content: Text('Selecione um objetivo primeiro'),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('OK')),
                          ],
                        ),
                      );
                      return;
                    }
                    bool valido =
                        Provider.of<ProgressoProvider>(context, listen: false)
                            .checar(
                      context,
                      tipoAvancoController.text,
                      objetivo['tipo'],
                    );

                    if (valido &&
                        _selectedDay != null &&
                        avancoController.text != "" &&
                        objetivo['meta'] != 0) {
                      final progresso = provider.calcularProgresso(
                        double.tryParse(avancoController.text) ?? 0,
                        double.tryParse(objetivo['meta'].toString()) ?? 1,
                        tipoAvancoController.text,
                        objetivo['tipo'],
                        context,
                      );

                      setState(() => _progresso = progresso);
                    } else {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text('Aviso'),
                          content: Text(
                              'Verifique se preencheu todos os campos e se selecionou um dia'),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('OK')),
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text("Calcular")),
              SizedBox(
                width: 25,
              ),
              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 167, 211),
                      foregroundColor: const Color.fromARGB(255, 82, 9, 124),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    onPressed: () {
                      if (_objetivoSelecionado == null) {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text('Aviso'),
                            content: Text('Selecione um objetivo primeiro'),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('OK')),
                            ],
                          ),
                        );
                        return;
                      }
                      bool valido =
                          Provider.of<ProgressoProvider>(context, listen: false)
                              .checar(
                        context,
                        tipoAvancoController.text,
                        objetivo['tipo'],
                      );

                      if (valido &&
                          _selectedDay != null &&
                          avancoController.text != "" &&
                          objetivo['meta'] != 0) {
                        final progresso = provider.calcularProgresso(
                          double.tryParse(avancoController.text) ?? 0,
                          double.tryParse(objetivo['meta'].toString()) ?? 1,
                          tipoAvancoController.text,
                          objetivo['tipo'],
                          context,
                        );
                        enviabd.adicionarProgresso(
                            context,
                            _objetivoSelecionado!,
                            progresso.toString(),
                            avancoController.text,
                            tipoAvancoController.text,
                            objetivo['meta'].toString(),
                            objetivo['tipo'],
                            DateFormat('yyyy-MM-dd').format(_selectedDay!));

                        setState(() => _progresso = progresso);
                        avancoController.clear();
                        tipoAvancoController.clear();
                        _progresso = 0.0;
                      } else {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text('Aviso'),
                            content: Text(
                                'Verifique se preencheu todos os campos e se selecionou um dia'),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('OK')),
                            ],
                          ),
                        );
                      }
                    },
                    child: Text("Salvar")),
              ),
              SizedBox(
                width: 25,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 167, 211),
                    foregroundColor: const Color.fromARGB(255, 82, 9, 124),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const VizualizarProgresso()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Text("Progressos"))
            ],
          ),
        )
      ]),
    )));
  }
}
