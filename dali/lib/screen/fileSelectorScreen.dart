import 'package:dali/widget/fileSelector.dart';
import 'package:flutter/material.dart';

class FileSelectorScreen extends StatefulWidget {
  @override
  _FileSelectorScreenState createState() => _FileSelectorScreenState();
}

class _FileSelectorScreenState extends State<FileSelectorScreen> {
  String? imageFilePath;
  String? videoFilePath;
  String? audioFilePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Seleccionar Archivos')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FileSelectorWidget(
              label: 'Seleccionar Imagen',
              onFileSelected: (filePath) {
                setState(() {
                  imageFilePath = filePath;
                });
              },
            ),
            SizedBox(height: 20),
            FileSelectorWidget(
              label: 'Seleccionar Video',
              onFileSelected: (filePath) {
                setState(() {
                  videoFilePath = filePath;
                });
              },
            ),
            SizedBox(height: 20),
            FileSelectorWidget(
              label: 'Seleccionar Audio',
              onFileSelected: (filePath) {
                setState(() {
                  audioFilePath = filePath;
                });
              },
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                print('Imagen: $imageFilePath');
                print('Video: $videoFilePath');
                print('Audio: $audioFilePath');
              },
              child: Text('Confirmar Selección'),
            ),
          ],
        ),
      ),
    );
  }
}
