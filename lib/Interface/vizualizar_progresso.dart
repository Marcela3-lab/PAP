import 'package:flutter/material.dart';
import 'package:learn_logs/Provider/buscarprogresso_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../Provider/dropdown_progressoprovider.dart';

class VizualizarProgresso extends StatefulWidget {
  const VizualizarProgresso({super.key});

  @override
  State<VizualizarProgresso> createState() => _VizualizarProgressoState();
}

Widget comobjetivo(BuildContext context, objetivo, meta, tipometa, feito,
    tipofeito, $progresso) {
  double percentagem = double.parse($progresso);
  return Container(
      alignment: Alignment.center,
      height: 140,
      margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      padding: const EdgeInsets.symmetric(vertical: 11),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromARGB(255, 250, 244, 191), Color(0xFFFFEAF1)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 140, 98, 189).withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Objetivo: $objetivo \nMeta: $meta $tipometa\nTotal: $feito $tipofeito",
                style: TextStyle(
                  fontSize: 16,
                  color: const Color.fromARGB(221, 0, 0, 0),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.left,
              ),
            )),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: percentagem,
              backgroundColor: Colors.grey[300],
              color: Colors.purple[300],
              minHeight: 10,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 4),
          child: Text("${(percentagem * 100).toStringAsFixed(1)}% concluído",
              style: TextStyle(fontSize: 12)),
        ),
      ]));
}

class _VizualizarProgressoState extends State<VizualizarProgresso> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarioformato = CalendarFormat.week;

  @override
  void initState() {
    super.initState();
    _selectedDay ??= DateTime.now();
    Future.microtask(() {
      final progressoProvider =
          Provider.of<BuscarprogressoProvider>(context, listen: false);
      progressoProvider.carregarprogresso(_selectedDay!);
    });
  }

  Widget build(BuildContext context) {
    final progressoProvider = Provider.of<BuscarprogressoProvider>(context);
    final progresso = progressoProvider.progressos;

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            backgroundColor: Color.fromARGB(255, 245, 213, 247),
          ),
        ),
        body: Column(children: [
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
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focused) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focused;
                });
                Provider.of<BuscarprogressoProvider>(context, listen: false)
                    .carregarprogresso(selectedDay);
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
          progresso.isEmpty
              ? Text("Voce ainda não registrou nenhum progresso")
              : Expanded(
                  child: Consumer<BuscarprogressoProvider>(
                      builder: (context, progressoProvider, _) {
                    final progresso = progressoProvider.progressos;

                    return ListView.builder(
                        itemCount: progresso.length,
                        itemBuilder: (context, index) {
                          final progressos = progresso[index];
                          return comobjetivo(
                              context,
                              progressos["objetivo"],
                              progressos["meta"],
                              progressos["tipometa"],
                              progressos["avanco"],
                              progressos["tipoavanco"],
                              progressos["progresso"]);
                        });
                  }),
                ),
        ]));
  }
}
