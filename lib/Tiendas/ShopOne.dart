import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShopOne extends StatefulWidget {
  final String DOC_ID;
  ShopOne(this.DOC_ID);
  @override
  ShopOneApp createState() => ShopOneApp();
}

//
class ShopOneApp extends State<ShopOne> {
  ShopOneApp(){
   validarDatos();
   //
  }
 // String titulo="default";
  String nombre="default name";
  String descrCorta="defalut short";
  String descrLarga="default long";
  String logo="logo.png";

  validarDatos() async {
    try {
      CollectionReference ref =
      FirebaseFirestore.instance.collection("Tiendas");
      QuerySnapshot usuario = await ref.get();
      if (usuario.docs.length != 0) {
        print(widget.DOC_ID.toString()+" prueba");

        for (var cursor in usuario.docs) {
          if (cursor.id==widget.DOC_ID.toString()){
            //String titulo=cursor.get("nombreTienda");
             this.nombre=cursor.get("nombreTienda");
             this.descrCorta=cursor.get("descrip");
           // String descrLarga="default long";
             logo=cursor.get("ruta");
          }
        }

      } else {
        print("No hay elementos en la colección");
      }
    } catch (e) {
      print(e);
    }
  }



  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    this.nombre,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  this.descrCorta,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          Text('41'),
        ],
      ),
    );

    Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(color, Icons.call, 'Teléfono'),
          _buildButtonColumn(color, Icons.near_me, 'Cómo llegar?'),
          _buildButtonColumn(color, Icons.web, 'Website'),
        ],
      ),
    );

    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        descrLarga,
        softWrap: true,
      ),
    );

    return MaterialApp(
      title: this.nombre,
      home: Scaffold(
        appBar: AppBar(
          title: Text(this.nombre),
        ),
        body:

        ListView(
          children: [
            Image.asset(
              'image/'+logo,
              width: 600,
              height: 240,
              fit: BoxFit.cover,
            ),
            titleSection,
            buttonSection,
            textSection,
            Container(
             child: FloatingActionButton(
                onPressed: (){},
                tooltip: 'Agregar producto',
                child: const Icon(Icons.add),
              )
            ),
          ],
        ),

      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}