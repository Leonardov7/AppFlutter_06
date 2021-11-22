import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CambioPass extends StatefulWidget {
  @override
  CambioPassApp createState() => CambioPassApp();
}

//
class CambioPassApp extends State<CambioPass> {
  TextEditingController correo = TextEditingController();
  TextEditingController passA = TextEditingController();
  TextEditingController passN = TextEditingController();
  final firebase=FirebaseFirestore.instance;

  validarDatos() async {
    try {
      CollectionReference ref =
          FirebaseFirestore.instance.collection("Usuarios");
      QuerySnapshot usuario = await ref.get();

      if (usuario.docs.length != 0) {
        //print("flag");
        //print(usuario.docs.length);
        int flag = 0;
        for (var cursor in usuario.docs) {
          //print(cursor.get("Correo") + "||" + correo.text);
         // print(cursor.id);
          if (cursor.get("Correo") == correo.text) {
           // print(cursor.get("Password"));
            if (cursor.get("Password") == passA.text) {
              // mensaje("Correcto","Usuario correcto");
             // print(cursor.get("nombreUsuario"));
              flag = 1;
              print(cursor.id);
              try{
                await firebase
                    .collection("Usuarios")
                    .doc(cursor.id)
                    .set({
                  "nombreUsuario":cursor.get("nombreUsuario"),
                  "Correo":cursor.get("Correo"),
                  "Telefono":cursor.get("Telefono"),
                  "Password":passN.text,
                  "Estado":true
                });
              }catch(e){
                print (e);
              }

              //Navigator.push(
              //  context, MaterialPageRoute(builder: (_) => buscar()));
            }
          }
        }
        //print(flag);
        if (flag == 0) {
          //mensaje("No encotrado","No se encontró el usuario");
        }
      } else {
        print("No hay elementos en la colección ");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    ///++++++++++++++++++++++++++++
    return Scaffold(
      appBar: AppBar(
        title: Text("Cambio de contraseña"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 40, top: 50, right: 40, bottom: 0),
              child: TextField(
                controller: correo,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: 'Correo',
                  hintText: 'Digite el correo',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40, top: 20, right: 40, bottom: 0),
              child: TextField(
                obscureText: true,
                controller: passA,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: 'Contraseña actual',
                  hintText: 'Digite su contraseña actual ',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40, top: 20, right: 40, bottom: 0),
              child: TextField(
                obscureText: true,
                controller: passN,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: 'Contraseña nueva',
                  hintText: 'Digite su contraseña nueva',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40, top: 20, right: 40, bottom: 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: Size(500, 50)),
                onPressed: () {
                  validarDatos();
                  // correo.clear();
                  //pass.clear();
                },
                child: Text("Cambiar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
