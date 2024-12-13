import 'package:flutter/material.dart';
import 'package:dali/models/tareaAsignada.dart';
import 'package:dali/controlers/controladores.dart';
import 'package:intl/intl.dart';

class Historial extends StatefulWidget {
  final String _username;
  const Historial({super.key, required String username}) : _username = username;

  @override
  _HistorialState createState() => _HistorialState();
}

class _HistorialState extends State<Historial> {
  List<TareaAsignada> tareasCompletadas = [];
  List<List<TareaAsignada>> tareasAgrupadas = [];
   final Controladores controladores = Controladores();

  @override
  void initState() {
    super.initState();
    _cargarTareas();
  }

  void _cargarTareas() async {
    // Llamar a la API
    List<TareaAsignada> tareas = await controladores.obtenerTareasMiniaturaTituloFechaCompletada(widget._username);

    // Filtrar tareas completadas
    List<TareaAsignada> completadas = tareas.where((t) => t.fechaCompletada != null).toList();

    // Ordenar tareas por fechaCompletada (más cercanas primero)
    completadas.sort((a, b) {
     return a.fechaCompletada!.compareTo(b.fechaCompletada!);
    });
  bool _esMismoDia(DateTime fecha1, DateTime fecha2) {
  return fecha1.year == fecha2.year &&
         fecha1.month == fecha2.month &&
         fecha1.day == fecha2.day;
}
   List<List<TareaAsignada>> agrupadas = [];
for (var tarea in completadas) {
  DateTime fechaTarea = tarea.fechaCompletada!;

  if (agrupadas.isEmpty || !_esMismoDia(fechaTarea, agrupadas.last.first.fechaCompletada!)) {
    agrupadas.add([tarea]);
  } else {
    agrupadas.last.add(tarea);
  }
}



    // Actualizar estado
    setState(() {
      tareasCompletadas = completadas;
      tareasAgrupadas = agrupadas;
    });
  }

  bool _esMismoDia(DateTime fecha1, String fecha2Str) {
    DateTime fecha2 = DateFormat('dd/MM/yyyy').parse(fecha2Str);
    return fecha1.year == fecha2.year && fecha1.month == fecha2.month && fecha1.day == fecha2.day;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.01),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Image(
                    image: const AssetImage('images/back-arrow.png'),
                    width: screenWidth * 0.04,
                    height: screenWidth * 0.04,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Text('Historial',
                    style: TextStyle(
                      fontSize: screenWidth * 0.08,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(width: screenWidth * 0.03),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Expanded(
              child: ListView.builder(
                itemCount: tareasAgrupadas.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        child: Text(
                          'Día: ${tareasAgrupadas[index][0].fechaCompletada}',
                          style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ...tareasAgrupadas[index].map((tarea) => ListTile(
                            leading: Image.asset(tarea.miniatura),
                            title: Text(tarea.titulo),
                          )),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
