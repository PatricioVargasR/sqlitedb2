import 'package:flutter/material.dart';
import 'package:sqlitedb2/convert_utility.dart';

class imageInfo extends StatefulWidget {
  const imageInfo({
    super.key,
    required this.photo,
    required this.name,
    required this.apepa,
    required this.apema,
    required this.email,
    required this.tel,
  });

  final String? photo;
  final String? name;
  final String? apepa;
  final String? apema;
  final String? email;
  final String? tel;

  @override
  State<imageInfo> createState() => _imageInfoState();
}

class _imageInfoState extends State<imageInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Datos personales",
              style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: ListView(
          //mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Center(
                child: Text(
              "Página de datos",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            )),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 170,
                    height: 170,
                    child: Utility.ImageFromBase64String(widget.photo!),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text("Nombre", // Etiqueta "Nombre"
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue)),
                  const SizedBox(height: 7),
                  Text(
                    "${widget.name}",
                    style: const TextStyle(fontSize: 20),
                  ),
                  const Text("Apellido Paterno",
                      style:  TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue)),
                  const SizedBox(height: 7),
                  Text(
                    "${widget.apepa}",
                    style: const TextStyle(fontSize: 20),
                  ),
                  const Text("Apellido Materno",
                      style:  TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue)),
                  const SizedBox(height: 7),
                  Text(
                      "${widget.apema}",
                      style: const TextStyle(fontSize: 20),
                  ),
                  const Text("Teléfono",
                      style:  TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue)),
                  const SizedBox(height: 7),
                  Text(
                    "${widget.tel}",
                    style: const TextStyle(fontSize: 20),
                  ),
                  const Text("Email", // Etiqueta "Nombre"
                      style:  TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue)),
                  const SizedBox(height: 7),
                  Text(
                    "${widget.email}",
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: const Text(
                "Back",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
              ),
              ),
            ),
          ],
        ));
  }
}
