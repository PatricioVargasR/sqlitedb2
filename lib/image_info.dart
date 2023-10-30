import 'package:flutter/material.dart';
import 'package:sqlitedb2/convert_utility.dart';


class imageInfo extends StatefulWidget {
  const imageInfo({super.key,
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
              style: TextStyle(color: Colors.yellowAccent)),
          centerTitle: true,
          backgroundColor: Colors.redAccent,
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
                      color: Colors.redAccent),
                )),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                    Container(
                    width: 100,
                      height: 120,
                      child: Utility.ImageFromBase64String(widget.photo!),
                    ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text( "Nombre ${widget.name}",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent)),
                  const SizedBox(
                    height: 30,
                  ),
                  Text("Apellidos Paterno: ${widget.apepa}",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent)),
                  const SizedBox(
                    height: 30,
                  ),
                  Text("Apellido Materno: ${widget.apema} ",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent)),
                  const SizedBox(
                    height: 30,
                  ),
                  Text("Teléfono: ${widget.tel}",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent)),
                  const SizedBox(
                    height: 30,
                  ),
                  Text("Email: ${widget.email}",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent)),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Back"),
            ),
          ],
        )
    );
  }
}
