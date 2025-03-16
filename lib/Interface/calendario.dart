import 'package:flutter/material.dart';
import 'package:flutter_application_1/Perguntas/p_Agenda.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendario extends StatefulWidget {
  const Calendario({super.key});

  @override
  _calendarioState createState() => _calendarioState();
}

class _calendarioState extends State<Calendario> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Lista de eventos
  final Map<DateTime, List<String>> events = {
    DateTime(2025, 3, 14): ["Evento A", "Evento B"],
    DateTime(2025, 3, 15): ["Evento C"],
  };

  // Função que retorna os eventos do dia selecionado
  List<String> _getEventsForDay(DateTime day) {
    return events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime(2024, 1, 1),
            lastDay: DateTime(2030, 12, 31),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            eventLoader: (day) {
              return _getEventsForDay(day);
            },
          ),
          const SizedBox(height: 20),
          // Lista de eventos abaixo do calendário
          Expanded(
            child: _selectedDay == null
                ? const Center(child: Text("Selecione um dia"))
                : ListView(
                    children: _getEventsForDay(_selectedDay!).map((event) {
                      return ListTile(
                        title: Text(event),
                      );
                    }).toList(),
                  ),
          ),

          FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const PAgenda()),
                );
              },
              child: Icon(Icons.add))
        ],
      ),
    );
  }
}
