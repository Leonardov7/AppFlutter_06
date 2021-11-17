import 'package:flutter/material.dart';
import 'RegistroUser.dart';
class GestionUsuario extends StatefulWidget {
  @override
  GestionUsuarioApp createState() => GestionUsuarioApp();
}
//
class GestionUsuarioApp extends State<GestionUsuario> {
  @override
  Widget build(BuildContext context) {

    ///++++++++++++++++++++++++++++
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestion Usuario"),
      ),body: Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Padding(
            padding:
            EdgeInsets.only(top:20),
            child: ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (_) => RegistroUser()));
              }
              ,
              child:Text("Registro de usuario"),
            ),
          ),
          Padding(
            padding:
            EdgeInsets.only(top:20),
            child: ElevatedButton(
              onPressed: (){}
              ,
              child:Text("Cambio de passwprd"),
            ),
          ),
          Padding(
            padding:
            EdgeInsets.only(top:20),
            child: ElevatedButton(
              onPressed: (){}
              ,
              child:Text("Dar de baja"),
            ),
          ),
          Padding(
            padding:
            EdgeInsets.only(top:20),
            child: ElevatedButton(
              onPressed: (){}
              ,
              child:Text("modificar de usuario"),
            ),
          ),
          Padding(
            padding:
            EdgeInsets.only(top:20),
            child: ElevatedButton(
              onPressed: (){

              },
              child:Text("Login"),
            ),
          )
        ],
      ),

    ),
    );
  }
}
