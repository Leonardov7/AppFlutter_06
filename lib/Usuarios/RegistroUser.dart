import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistroUser extends StatefulWidget {
  @override
  RegistroUserApp createState() => RegistroUserApp();
}
//
class RegistroUserApp extends State<RegistroUser> {
  @override
  TextEditingController nombreUser =TextEditingController();
  TextEditingController Correo=TextEditingController();
  TextEditingController tele=TextEditingController();
  TextEditingController pass =TextEditingController();
  TextEditingController direccion=TextEditingController();
  final firebase=FirebaseFirestore.instance;

  registrarUsuario() async{
    try{
      await firebase
          .collection("Usuarios")
          .doc()
          .set({
        "nombreUsuario":nombreUser.text,
        "Correo":Correo.text,
        "Telefono":tele.text,
        "Password":pass.text,
        "Direccion":direccion.text,
        "Estado":true
      });
    }
    catch (e){
      print(e);
    }
  }

  Widget build(BuildContext context) {

    ///++++++++++++++++++++++++++++
    return Scaffold(
        appBar: AppBar(
          title: Text("Regisgtro de Usuario"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left:15,top: 15,right: 15,bottom: 0),
                // NOMBRE USUARIO
                child: TextField(
                  controller: nombreUser,
                  decoration: InputDecoration(
                    labelText: "Nombre usuario",
                    hintText: "Digite nombre del usuario",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left:15,top: 15,right: 15,bottom: 0),
                // RUTA IMÁMGEN
                child: TextField(
                  controller: Correo,
                  decoration: InputDecoration(
                      labelText: "Correo",
                      hintText: "Digite correo",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left:15,top: 15,right: 15,bottom: 0),
                // DESCRIPCIÓN TIENDA
                child: TextField(
                  controller: tele,
                  decoration: InputDecoration(
                      labelText: "Teléfono",
                      hintText: "Digite teléfono",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
                // PÁGINA WEB
                child: TextField(
                  obscureText: true,
                  controller: direccion,
                  decoration: InputDecoration(
                      labelText: "Direccion",
                      hintText: "Digite Dirección",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left:15,top: 15,right: 15,bottom: 0),
                // PÁGINA WEB
                child: TextField(
                  obscureText:true,
                  controller: pass,
                  decoration: InputDecoration(
                      labelText: "Contraseña",
                      hintText: "Digite contraseña",

                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                ),
              ),

              Padding(
                  padding: EdgeInsets.only(left:15,top: 15,right: 15,bottom: 0),
                  child: ElevatedButton(
                    onPressed: (){
                      registrarUsuario();
                      nombreUser.clear();
                      Correo.clear();
                      tele.clear();
                      pass.clear();
                      direccion.clear();

                    },
                    child: Text("Registrar"),
                  )
              ),
            ],
          ),
        )

    );
  }
}
