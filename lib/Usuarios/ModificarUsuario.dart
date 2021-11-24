import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ModificarUsuario extends StatefulWidget {
  @override
  ModificarUsuarioApp createState() => ModificarUsuarioApp();
}

//
class ModificarUsuarioApp extends State<ModificarUsuario> {
  TextEditingController correo=TextEditingController();
  TextEditingController nombre=TextEditingController();
  TextEditingController telefono=TextEditingController();
  TextEditingController direccion=TextEditingController();
  final firebase=FirebaseFirestore.instance;
  String correo1 ="";
  String idDoc="";
  String pass="";
  bool estado=true;

  validarDatos() async {
    try {
      CollectionReference ref =
      FirebaseFirestore.instance.collection("Usuarios");
      QuerySnapshot usuario = await ref.get();

      if (usuario.docs.length != 0) {
        for (var cursor in usuario.docs) {
           if (cursor.get("Correo") == correo.text) {
              nombre.text=cursor.get("nombreUsuario");
              telefono.text=cursor.get("Telefono");
              direccion.text=cursor.get("Direccion");
              this.idDoc=cursor.id;
              this.correo1=cursor.get("Correo");
              this.pass=cursor.get("Password");

          }
        }
      } else {
        print("No hay elementos en la colección ");
      }
    } catch (e) {
      print(e);
    }
  }

  modificarDatos() async{
      try{
        await firebase
            .collection("Usuarios")
            .doc(idDoc)
            .set({
          "nombreUsuario":nombre.text,
          "Correo":this.correo1,
          "Telefono":telefono.text,
          "Password":pass,
          "Direccion":direccion.text,
          "Estado":estado
        });
      }
      catch (e){
        print(e);
      }
    }


  @override
  Widget build(BuildContext context) {
    ///++++++++++++++++++++++++++++
    return Scaffold(
      appBar: AppBar(
        title: Text("Actualizar Usuario"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
              // NOMBRE USUARIO
              child: TextField(
                controller: correo,
                decoration: InputDecoration(
                  labelText: "Correo",
                  hintText: "Digite correo",

                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            Padding(
                padding:
                EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
                child: ElevatedButton(
                  onPressed: () {
                   validarDatos();

                  },
                  child: Text("Buscar Usuario"),
                )),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
              // RUTA IMÁMGEN
              child: TextField(
                controller: nombre,
                decoration: InputDecoration(
                    labelText: "Nombre usuario",
                    hintText: "Digite nombre del usuario",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
              // DESCRIPCIÓN TIENDA
              child: TextField(
                controller: telefono,
                decoration: InputDecoration(
                    labelText: "Teléfono",
                    hintText: "Digite teléfono",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
              // PÁGINA WEB
              child: TextField(

                controller: direccion,
                decoration: InputDecoration(
                    labelText: "Direccion",
                    hintText: "Digite Dirección",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
              child: ElevatedButton(
                onPressed: () {
                  modificarDatos();
   /* nombreUser.clear();
    Correo.clear();
    tele.clear();
    pass.clear();*/
                },
                child: Text("Modificar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
