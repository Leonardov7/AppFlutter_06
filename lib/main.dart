import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'buscar.dart';
import 'Tiendas/Shop.dart';
import 'Tiendas/ShopRegister.dart';
import 'Usuarios/GestionUsuario.dart';
import 'Tiendas/GestionTiendas.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

//cambio2
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Home());
  }
}

class Home extends StatefulWidget {
  @override
  HomeStart createState() => HomeStart();
}

@override
class HomeStart extends State<Home> {
  TextEditingController busqueda=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bienvenidos grupo 06',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home app grupo 06'),
            actions: [
              FloatingActionButton(
                onPressed: () {
                 // Navigator.push(context,MaterialPageRoute(builder: (_) => ItemRegister(tiendaId.toString())));
                },
                tooltip: 'Agregar producto',
                child: const Icon(Icons.shopping_cart),
                //child: Text("add"),
                backgroundColor: Colors.green,
              )
            ]
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 0),
                child: Center(
                  child: Container(
                    width: 150,
                    height: 150,
                    child: Image.asset('image/logo.png'),
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 0),
                child: TextField(
                  controller: busqueda,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'búsqueda',
                      hintText: 'Palabra clave de la búsqueda'),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(minimumSize: Size(500, 50)),
                  onPressed: () {
                    print("presionado");
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => buscar(busqueda.text)));
                  },
                  child: Text('Buscar'),
                ),
              ),

              Padding(
                padding:
                    EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(minimumSize: Size(500, 50)),
                  onPressed: () {


                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => GestionTiendas()));
                  },
                  child: Text('Gestionar tienda'),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(minimumSize: Size(500, 50)),
                  onPressed: () {
                    //print("presionado");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => GestionUsuario()));
                  },
                  child: Text('Gestión Usuario'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
