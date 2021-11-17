import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'buscar.dart';
import 'Shop.dart';
import 'ShopRegister.dart';
import 'GestionUsuario.dart';
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bienvenidos grupo 06',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home app grupo 06'),
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
                  onPressed: () {
                    print("presionado");
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => buscar()));
                  },
                  child: Text('Buscar'),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 0),
                child: ElevatedButton(
                  onPressed: () {
                    //print("presionado");
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => Shop()));
                  },
                  child: Text('Listado de tiendas'),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 0),
                child: ElevatedButton(
                  onPressed: () {
                    //print("presionado");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ShopRegister()));
                  },
                  child: Text('Registrar tienda'),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 0),
                child: ElevatedButton(
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
