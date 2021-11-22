import 'package:flutter/material.dart';
import 'RegistroUser.dart';
import 'Login.dart';
import 'CambioPass.dart';
import 'BajaUsuario.dart';
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
      ),body: SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Padding(
            padding:
            EdgeInsets.only(top:20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: Size(500, 50)),
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
              style: ElevatedButton.styleFrom(minimumSize: Size(500, 50)),
              onPressed: (){
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => CambioPass()));
              }
              ,
              child:Text("Cambio de contraseña"),
            ),
          ),
          Padding(
            padding:
            EdgeInsets.only(top:20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: Size(500, 50)),
              onPressed: (){
               // Navigator.push(
                 //   context, MaterialPageRoute(builder: (_) => BajaUsuario()));
                mensaje("Inactivar Usuario","¿Desea inactivar al usuario?");
              }
              ,
              child:Text("Dar de baja"),
            ),
          ),
          Padding(
            padding:
            EdgeInsets.only(top:20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: Size(500, 50)),
              onPressed: (){}
              ,
              child:Text("modificar de usuario"),
            ),
          ),
          Padding(
            padding:
            EdgeInsets.only(top:20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: Size(500, 50)),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (_) => Login()));
              },
              child:Text("Login"),
            ),
          )
        ],
      ),

    ),
    );
  }
  void mensaje(String titulo, String mess) {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: Text(titulo),
            content: Text(mess),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 40, top: 30, right: 5, bottom: 5),
                child: TextField(
                  // controller: correo,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Correo',
                    hintText: 'Digite el correo',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 40, top: 30, right: 5, bottom: 5),
                child: TextField(
                  // controller: correo,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Contraseña',
                    hintText: 'Digite Contraseña',
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child:
                Text("Cancelar", style: TextStyle(color: Colors.blueGrey)),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child:
                Text("Aceptar", style: TextStyle(color: Colors.blueGrey)),
              ),

            ],
          );
        });
  }
}
