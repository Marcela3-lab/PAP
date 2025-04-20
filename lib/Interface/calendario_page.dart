import 'package:flutter/material.dart';
import 'package:flutter_application_1/Interface/Adicionar_tarefa.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/Provider/calendario_provider.dart';

class Calendario extends StatefulWidget {
  const Calendario({Key? key}) : super(key: key);
  _CalendarioState createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();
  String? formattedDate;
  final int _opcaoselecionada = 0;
  DateTime? selectedDate;

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime(2024, 4, 20),
        firstDate: DateTime(2021),
        lastDate: DateTime(2025),
        onDatePickerModeChange: (date) {});

    if (pickedDate != null) {
      setState(() {
        _selectedDay = pickedDate;
        formattedDate = DateFormat('dd-MM-yyyy').format(_selectedDay!);
        onAdd();
      });
    }
  }

  void onAdd() {
    if (formattedDate == null || formattedDate!.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Data"),
          content: Text("Selecione uma data para adicionar eventos"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Ok"),
            ),
          ],
        ),
      );
    } else {
      print("Há um erro muito grande aqui!  $formattedDate");
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PAgenda(nome: formattedDate!),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedDay ??= DateTime.now();
    Future.microtask(() {
      final calendarioProvider =
          Provider.of<CalendarioProvider>(context, listen: false);
      calendarioProvider.carregarEventos(_selectedDay!);
    });
  }

  Widget build(BuildContext contex) {
    final calendarioProvider = Provider.of<CalendarioProvider>(context);
    final eventos = calendarioProvider.eventos;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: IndexedStack(
        index: _opcaoselecionada,
        children: <Widget>[
          Column(
            children: [
              Text(
                selectedDate != null
                    ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                    : 'No date selected',
              ),
              OutlinedButton(
                  onPressed: _selectDate, child: const Text('Select Date')),
              Text('oi'),
//               TableCalendar(
//                 focusedDay: _focusedDay,
//                 firstDay: DateTime(2024, 1, 1),
//                 lastDay: DateTime(2030, 12, 31),
//                 selectedDayPredicate: (day) {
//                   return isSameDay(_selectedDay, day);
//                 },
//                 onDaySelected: (selectedDay, focusedDay) {
//                   /*
//                   setState(() {
//                     _selectedDay = selectedDay;
//                     _focusedDay = focusedDay;
//                     formattedDate =
//                         DateFormat('dd-MM-yyyy').format(selectedDay);
//                   });
// /* */
//                   onFormatChanged:
//                   (format) {
//                     setState(() {
//                       _calendarFormat = format;
//                     });
//                   };
// */
//                   //   Provider.of<CalendarioProvider>(context, listen: false)

//                   //    .carregarEventos(selectedDay);
//                 },
//               ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  onAdd();
                },
                child: const Icon(Icons.add),
              ),
              const SizedBox(height: 20),
              eventos.isEmpty
                  ? Text("Nenhum evento encontrado para esta data")
                  : Expanded(
                      child: ListView.builder(
                        itemCount: eventos.length,
                        itemBuilder: (context, index) {
                          final evento = eventos[index];

                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(), // Adiciona uma borda
                              borderRadius: BorderRadius.circular(
                                  12), // Adiciona bordas arredondadas
                            ),
                            child: ListTile(
                              title: Text(evento["titulo"]),
                              subtitle: Text(
                                "Início: ${evento["inicio"]} - Fim: ${evento["fim"]}",
                              ),
                            ),
                          );
                        },
                      ),
                    )
            ],
          ),
        ],
      ),
    );
  }
}
