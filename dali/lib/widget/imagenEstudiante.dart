import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagenEstudiante extends StatefulWidget {
  @override
  _ImagenEstudianteState createState() => _ImagenEstudianteState();
}

class _ImagenEstudianteState extends State<ImagenEstudiante> {
  File? _image;

  // Función para seleccionar la imagen
  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      // Aquí va la lógica para subir la imagen a la API, pero está comentada por ahora
      // _uploadImage(_image!);
    }
  }

  // Función para subir la imagen al servidor (comentada por ahora)
  // Future<void> _uploadImage(File image) async {
  //   var uri = Uri.parse('http://localhost:5000/upload'); // URL de la API (Flask)
  //   var request = http.MultipartRequest('POST', uri)
  //     ..files.add(await http.MultipartFile.fromPath('file', image.path));

  //   try {
  //     var response = await request.send();
  //     if (response.statusCode == 200) {
  //       print('Imagen subida con éxito');
  //       // Aquí puedes manejar la respuesta y actualizar la URL en la base de datos.
  //     } else {
  //       print('Error al subir la imagen: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error al subir la imagen: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Subir Foto del Estudiante"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image != null
                ? Image.file(
                    _image!,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  )
                : Text("No se ha seleccionado imagen."),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectImage,
              child: Text("Seleccionar Imagen"),
            ),
          ],
        ),
      ),
    );
  }
}
