import 'package:flutter/material.dart';
import 'ShopRegister.dart';
import 'Shop.dart';
import '../buscar.dart';

class GestionTiendas extends StatefulWidget {
  @override
  GestionTiendasApp createState() => GestionTiendasApp();
}
//
class GestionTiendasApp extends State<GestionTiendas> {
  TextEditingController busqueda=TextEditingController();
  @override
  Widget build(BuildContext context) {

    ///++++++++++++++++++++++++++++
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestión Tiendas"),
      ),body:SingleChildScrollView(
      child: Column(
    children: [
      Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: Size(500, 50)),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => ShopRegister()));
            },
            child:Text("Registro de tienda"),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: Size(500, 50)),
            onPressed: (){
           //   Navigator.push(context, MaterialPageRoute(builder: (_) => Login()));
            },
            child:Text("Modificar tienda"),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: Size(500, 50)),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => Shop()));
            },
            child:Text("Listado de tiendas"),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(20),
        child: TextField(
          controller: busqueda,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)),
            labelText: 'Buscar tienda',
            hintText: 'Digite palabra clave de la tienda',
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(minimumSize: Size(500, 50)),
          onPressed: () {

            Navigator.push(context, MaterialPageRoute(builder: (_) => buscar(busqueda.text)));
          },
          child: Text("Buscar"),
        ),
      ),
    ],
    ),
    ),
    );
  }
}
