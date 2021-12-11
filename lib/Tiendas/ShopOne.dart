import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myappmovil_06/Carrito/Carrito.dart';
import 'package:myappmovil_06/Productos/ItemRegister.dart';
import 'package:myappmovil_06/Usuarios/Login.dart';
import 'package:myappmovil_06/Usuarios/Token.dart';
import 'package:myappmovil_06/Carrito/ShoppingCart.dart';

import 'Tienda.dart';

class ShopOne extends StatefulWidget {
  final Tienda objetoTienda;
  ShopOne(this.objetoTienda);
  @override
  ShopOneApp createState() => ShopOneApp();
}

class ShopOneApp extends State<ShopOne> {

  String idUser = "";/*ShopOneApp() {
    validarDatos();
    //
  }*/
  // String titulo="default";
  /* String nombre = "default name";
  String descrCorta = "defalut short";
  String descrLarga = "default long";
  String logo = "logo.png";
  String tiendaId = "";*/
  final firebase = FirebaseFirestore.instance;

  /* validarDatos() async {
    try {
      CollectionReference ref =
          FirebaseFirestore.instance.collection("Tiendas");
      QuerySnapshot usuario = await ref.get();
      if (usuario.docs.length != 0) {
        print(widget.DOC_ID.toString() + " prueba");

        for (var cursor in usuario.docs) {
          if (cursor.id == widget.DOC_ID.toString()) {
            //String titulo=cursor.get("nombreTienda");
            this.nombre = cursor.get("nombreTienda");
            this.descrCorta = cursor.get("descrip");
            this.tiendaId = cursor.id;
            // String descrLarga="default long";
            logo = cursor.get("ruta");
          }
        }
      } else {
        print("No hay elementos en la colección");
      }
    } catch (e) {
      print(e);
    }
  }
*/
  registrarCarrito(Carrito cart) async {
    try {
      await firebase.collection("Carrito").doc().set({
       "UserId":cart.idUser,
        "NombreTienda":cart.nombreTienda,
        "ProductoId":cart.idItem,
        "PrecioItem":cart.precioItem,
        "NombreItem":cart.nombreItem,
        "Descripcion":cart.descripocionItem,
        "Cantidad":cart.cantidad,
        "total":cart.total,



      });
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
                    widget.objetoTienda.nombre,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  widget.objetoTienda.descripcion,
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
        widget.objetoTienda.descripcion,
        softWrap: true,
      ),
    );

    return MaterialApp(
      title: widget.objetoTienda.nombre,
      home: Scaffold(
          appBar: AppBar(title: Text(widget.objetoTienda.nombre), actions: [
            FloatingActionButton(
              onPressed: () {

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            ItemRegister(widget.objetoTienda.idTienda)));
              },
              tooltip: 'Agregar producto',
              child: const Icon(Icons.add_box),
              //child: Text("add"),
              backgroundColor: Colors.green,
            )
          ]),
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Image.asset(
                      'image/' + widget.objetoTienda.imagen,
                      width: 600,
                      height: 240,
                      fit: BoxFit.cover,
                    ),
                    titleSection,
                    buttonSection,
                    textSection,
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Productos")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) return CircularProgressIndicator();
                    return ListView.builder(
                      itemCount:
                          snapshot.data!.docs.length, // define las iteraciones
                      itemBuilder: (BuildContext context, int index) {
                        //print(snapshot.data!.docs[index].id +
                        //   " - " +
                        //  widget.objetoTienda.idTienda);
                        if (snapshot.data!.docs[index].get("TiendaId") ==
                            widget.objetoTienda.idTienda) {
                          return new Card(
                            child: new Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: Text(snapshot
                                                  .data!.docs[index]
                                                  .get("Nombre"))),
                                          Text(
                                            snapshot.data!.docs[index]
                                                .get("Descripcion"),
                                            style: TextStyle(
                                              color: Colors.green[500],
                                            ),
                                          ),
                                        ],
                                      )),
                                      Container(
                                        width: 80,
                                        height: 80,
                                        child: Image.asset(
                                              'image/' /*+snapshot.data!.docs[index].get("ruta")*/),
                                      ),
                                      FloatingActionButton(
                                          onPressed: () async {
                                            Token tk = new Token();
                                            String idUser = await tk.validarToken("");
                                            print(idUser);
                                            if (idUser == "vacio") {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) => Login()));
                                            }else
                                              {
                                                Carrito cart=new Carrito();
                                                cart.precioItem=snapshot.data!.docs[index].get("Precio");
                                                cart.descripocionItem=snapshot.data!.docs[index].get("Descripcion");
                                                cart.idItem=snapshot.data!.docs[index].id;
                                                cart.idUser=idUser;
                                                cart.nombreItem=snapshot.data!.docs[index].get("Nombre");
                                                cart.nombreTienda=widget.objetoTienda.nombre;
                                               // cart.

                                                mensaje("Carrito", "¿Desea agregar al carrito? Digite la cantidad",cart);

                                              }
                                          },
                                          heroTag:null,
                                          child: const Icon(
                                              Icons.add_shopping_cart),
                                          backgroundColor: Colors.blueGrey,
                                          tooltip: 'Agregar al carrito'),
                                      FloatingActionButton(
                                          onPressed: () {},
                                          // child: const Icon(Icons.add_shopping_cart),
                                          child: Text("Ver"),
                                          heroTag:null,
                                          backgroundColor: Colors.blue,
                                          tooltip: 'Ver producto')
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        } else {
                          return new Card();
                        }
                      },
                    );
                  },
                ),
              )
            ],
          )),
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
  void mensaje(String titulo, String mess, Carrito cart) {
    TextEditingController cant=TextEditingController();
    cant.text="1";
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
                 controller: cant,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Cantidad',
                    hintText: 'Digite la cantidad',
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  cart.cantidad=double.parse(cant.text);
                  cart.total=cart.cantidad*cart.precioItem;
                  registrarCarrito(cart);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ShoppingCart(cart.idUser)));

                },
                child:
                Text("Aceptar", style: TextStyle(color: Colors.blueGrey)),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child:
                Text("Cancelar", style: TextStyle(color: Colors.blueGrey)),
              )
            ],
          );
        });
  }
}
