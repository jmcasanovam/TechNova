import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileSelectorWidget extends StatefulWidget {
  final String label;
  final Function(String) onFileSelected;

  FileSelectorWidget({required this.label, required this.onFileSelected});

  @override
  _FileSelectorWidgetState createState() => _FileSelectorWidgetState();
}

class _FileSelectorWidgetState extends State<FileSelectorWidget> {
  String? selectedFilePath;

  Future<void> _pickFile() async {
    try {
      // Usa FilePicker para seleccionar un archivo
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any, // Cambia a FileType.image, FileType.video, etc., según el caso
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          selectedFilePath = result.files.single.path;
        });

        // Llama a la función de callback con la ruta seleccionada
        widget.onFileSelected(selectedFilePath!);
      }
    } catch (e) {
      print('Error al seleccionar archivo: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: screenHeight * 0.02),
        Row(
          children: [
            ElevatedButton(
              onPressed: _pickFile,
              child: Text('Seleccionar archivo', style: TextStyle(fontSize: screenWidth * 0.035)),
            ),
            SizedBox(width: screenWidth * 0.02),
            Expanded(
              child: Text(
                selectedFilePath ?? 'Ningún archivo seleccionado',
                style: TextStyle(fontSize: screenWidth * 0.035, color: Colors.grey),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
