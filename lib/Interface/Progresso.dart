import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_application_1/Interface/Adicionar_progresso.dart';

class Progresso extends StatefulWidget {
  const Progresso({super.key});
  ProgressoState createState() => ProgressoState();

  //PROGRESSO ADICIONADO
  Widget comobjetivo(BuildContext context, objetivo, meta, feito) {
    return Container(
        alignment: Alignment.center,
        height: 100,
        margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
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
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Align(
              alignment: Alignment.centerLeft, // Alinha o texto à direita
              child: Text(
                "Objetivo: $objetivo\nMeta: $meta\nFeito: $feito",
                style: TextStyle(
                  fontSize: 16,
                  color: const Color.fromARGB(221, 0, 0, 0),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.left,
              ),
            )));
  }

  //WIDGET SEM OBJETIVO ADICIONADO PARA O PROGRESSO

  Widget semobjetivo(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFFD6E8), Color(0xFFFFEAF1)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        Icon(
          Icons.favorite_border,
          color: Colors.pinkAccent,
          size: 32,
        ),
        SizedBox(width: 16),
        Expanded(
          child: Text(
            "Você ainda não registrou nenhum progresso para o dia de hoje!\nAdicione seu primeiro progresso",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ]),
    );
  }
}

class ProgressoState extends State<Progresso> {
  final CalendarFormat calendarioformato = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String? formattedDate;
  final int _opcaoselecionada = 0;

  @override
  Widget build(BuildContext contex) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: IndexedStack(index: _opcaoselecionada, children: <Widget>[
        Column(children: [
          /*
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime(2024, 1, 1),
            lastDay: DateTime(2030, 12, 31),
            calendarFormat: calendarioformato,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
          ),
          */
          const SizedBox(height: 40),
          widget.semobjetivo(contex),
          const SizedBox(height: 10),
          widget.comobjetivo(
            context,
            1,
            2,
            4,
          ),
          ElevatedButton(
            onPressed: () {
              if (_selectedDay == null) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Data"),
                    content:
                        Text("Selecione uma data para adicionar seu progresso"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Ok"),
                      ),
                    ],
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdicionarProgresso(),
                  ),
                );
              }
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 20),
        ])
      ]),
    );
  }
}
