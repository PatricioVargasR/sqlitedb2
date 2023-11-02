import 'dart:typed_data';
import 'image_info.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqlitedb2/convert_utility.dart';
import 'package:sqlitedb2/dbManager.dart';
import 'package:sqlitedb2/student.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Student>>? Studentss;
  TextEditingController telController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController apepaController = TextEditingController();
  TextEditingController apemaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController controlNumController = TextEditingController();
  String? tel = '';
  String? name = '';
  String? email = '';
  String? apepa = '';
  String? apema = '';
  String? photoname = '';
  String? nameError;
  String? apepaError;
  String? apemaError;
  String? phoneError;
  String? emailError;


  //Update control
  int? currentUserId;

  // Variable para guardar la imagen
  var image;

  final formKey = GlobalKey<FormState>();
  late var dbHelper;

  // Variable para verificar si estamos actualizando
  late bool isUpdating;

  //Metodos de usuario
  refreshList() {
    setState(() {
      Studentss = dbHelper.getStudents();
    });
  }

  pickImageFromGallery() {
    ImagePicker imagePicker = ImagePicker();
    imagePicker
        .pickImage(source: ImageSource.gallery, maxHeight: 480, maxWidth: 640)
        .then((value) async {
      Uint8List? imageBytes = await value!.readAsBytes();
      setState(() {
        photoname = Utility.base64String(imageBytes!);
      });
    });
  }

  clearFields() {
    telController.text = '';
    nameController.text = '';
    apepaController.text = '';
    apemaController.text = '';
    emailController.text = '';
    controlNumController.text = '';
    // Eliminamos los datos que hayan en donde se obtiene la imagen
    photoname = '';
  }

  @override
  void initState() {
    super.initState();
    dbHelper = DBManager();
    refreshList();
    isUpdating = false;
  }

  Widget userForm() {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: [
            const SizedBox(height: 10),
            TextFormField(
              controller: nameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Name',
                errorText: nameError,
              ),
              validator: (value){
                String name = value ?? '';
                if (name.isEmpty) {
                  setState(() {
                    nameError = 'El nombre es obligatorio';
                  });
                } else if (!RegExp(r'^[A-Za-z ]+$').hasMatch(name)){
                  setState(() {
                    nameError = 'Inserte un nombre valido';
                  });
                } else {
                  setState(() {
                    nameError = null;
                  });
                }
              },
              onSaved: (val) => name = val!,
            ),
            TextFormField(
              controller: apepaController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Apellido Paterno',
                errorText: apepaError,
              ),
              validator: (value){
                String apepa = value ?? '';
                if (apepa.isEmpty) {
                  setState(() {
                    apepaError = 'Introduzca el apellido paterno por favor';
                  });
                } else if (!RegExp(r'^[A-Za-z ]+$').hasMatch(apepa)) {
                  setState(() {
                    apepaError = 'Inserte un apellido valido';
                  });
                } else {
                  setState(() {
                    nameError = null;
                  });
                }
                },
              onSaved: (val) => apepa = val!,
            ),
            TextFormField(
              controller: apemaController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Apellido Materno',
                errorText: apemaError,
              ),
              validator: (value){
                String apema = value ?? '';
                if (apema.isEmpty) {
                  setState(() {
                    apemaError = 'Inserte el apellido materno';
              });
              } else if (!RegExp(r'^[A-Za-z ]+$').hasMatch(apema)) {
                  setState((){
                    apemaError = 'Inserte un apellido valido';
              });
              } else {
                  setState(() {
                    apemaError = null;
              });}
              },
              onSaved: (val) => apema = val!,
            ),
            TextFormField(
              controller: telController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Telefono',
                errorText: phoneError,
              ),
              validator: (value) {
                String phone = value ?? '';
                if (phone.isEmpty) {
                  setState(() {
                    phoneError = 'Introduzca su numero';
                  });
                } else if (!RegExp(r'^[0-9]{10}$').hasMatch(phone)){
                  setState((){
                    phoneError = 'Telefono no valido';
                });
                } else {
                  setState(() {
                    phoneError = null;
                  });
                }
              },
              onSaved: (value) => tel = value,
            ),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: emailError,
              ),
              validator: (value){
                String email = value ?? '';
                if (email.isEmpty) {
                  setState(() {
                    emailError = 'Ingresa tu correo por favor';
                  });
                } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(email)) {
                  setState(() {
                    emailError = 'Correo electronico no valido';
                  });
                } else {
                  setState(() {
                    emailError = null;
                  });
                }
              },
              onSaved: (value) => email = value,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: validate,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.red)),
                  child: Text(isUpdating ? "Actualizar" : "Insertar"),
                ),
                MaterialButton(
                  onPressed: () {
                    pickImageFromGallery();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.green)),
                  child: const Text("Seleccionar imagen"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView userDataTable(List<Student>? Studentss) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Photo')),
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Paterno')),
          DataColumn(label: Text('Materno')),
          DataColumn(label: Text('E-mail')),
          DataColumn(label: Text('Telefono')),
          DataColumn(label: Text('Delete')),
        ],
        rows: Studentss!
            .map((student) => DataRow(cells: [
                  DataCell(
                      Container(
                        width: 80,
                        height: 120,
                        child:
                            Utility.ImageFromBase64String(student.photoName!),
                      ), onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => imageInfo(
                              photo: student.photoName,
                              name: student.name,
                              apepa: student.apepa,
                              apema: student.apema,
                              email: student.email,
                              tel: student.tel)),
                    );
                  }),
                  DataCell(Text(student.name!), onTap: () {
                    setState(() {
                      // En caso de que se actualice
                      isUpdating = true;
                      // Obtiene el ID y la Imagen del registro seleccionado
                      currentUserId = student.controlNum;
                      image = student.photoName;
                    });
                    nameController.text = student.name!;
                    apepaController.text = student.apepa!;
                    apemaController.text = student.apema!;
                    emailController.text = student.email!;
                    telController.text = student.tel!;
                  }),
                  DataCell(Text(student.apepa!)),
                  DataCell(Text(student.apema!)),
                  DataCell(Text(student.email!)),
                  DataCell(Text(student.tel!)),
                  DataCell(IconButton(
                    onPressed: () {
                      dbHelper.delete(student.controlNum);
                      refreshList();
                    },
                    icon: const Icon(Icons.delete),
                  ))
                ]))
            .toList(),
      ),
    );
  }

  Widget list() {
    return Expanded(
        child: SingleChildScrollView(
      child: FutureBuilder(
          future: Studentss,
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              return userDataTable(snapshot.data);
            }
            if (!snapshot.hasData) {
              print("Data Not Found");
            }
            return const CircularProgressIndicator();
          }),
    ));
  }

  validate() {
    // Validar los métodos
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (isUpdating) {
        // Verifica imagen
        if (photoname == null || photoname!.isEmpty) {
          // Conservar la imagen existente si photoname está vacío
          photoname = image;
        }
        // Asigna los valores que se vayan a actualizar
        Student student = Student(
          controlNum: currentUserId,
          name: name,
          apepa: apepa,
          apema: apema,
          email: email,
          tel: tel,
          photoName: photoname,
        );
        // Actualiza con el método correspondiente
        dbHelper.update(student);

        isUpdating = false;
        // Limpia las entradas de datos y refresca la tabla
        clearFields();
        refreshList();
      } else {
        // Verifica imagne
        if (photoname == null || photoname!.isEmpty) {
          // Muestra una alerta si no se ha seleccionado una imagen al crear un nuevo registro
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Selecciona una imagen.'),
            ),
          );
        } else {
          // Asigna los valores correspondientes
          Student student = Student(
            controlNum: null,
            name: name,
            apepa: apepa,
            apema: apema,
            email: email,
            tel: tel,
            photoName: photoname,
          );
          // Guarda el nuevo registro con el método correspondiente
          dbHelper.save(student);
          // Limpia las entradas y vuelve a cargas la tabla
          clearFields();
          refreshList();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Evitar botón de regreso
        automaticallyImplyLeading: false,
        title: const Text('SQLite DB'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        verticalDirection: VerticalDirection.down,
        children: [userForm(), list()],
      ),
    );
  }
}
