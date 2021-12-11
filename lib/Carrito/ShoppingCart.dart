import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Carrito.dart';

class ShoppingCart extends StatefulWidget {
  final String idUser;
  ShoppingCart(this.idUser);
  @override
  ShoppingCartApp createState() => ShoppingCartApp();
}

class ShoppingCartApp extends State<ShoppingCart> {
  double precioTotal = 0;
  String idCart = "";
  TextEditingController precioT = TextEditingController();
  borrarCarrito(String idCart) {
    final firebase = FirebaseFirestore.instance;
    firebase.collection("Carrito").doc(idCart).delete();
  }

  borrarIdCarrito(String idUser) async {
    try {
      CollectionReference ref =
          FirebaseFirestore.instance.collection("Carrito");
      QuerySnapshot cart = await ref.get();

      if (cart.docs.length != 0) {
        for (var cursor in cart.docs) {
          if (cursor.get("UserId") == idUser) {
            ref.doc(cursor.id).delete();
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.idUser),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("Carrito").snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                precioTotal = 0;
                // TextEditingController precioT= TextEditingController();
                return ListView.builder(
                  itemCount:
                      snapshot.data!.docs.length, // define las iteraciones
                  itemBuilder: (BuildContext context, int index) {
                    TextEditingController precio = TextEditingController();
                    if (snapshot.data!.docs[index].get("UserId") ==
                        widget.idUser) {
                      precio.text =
                          snapshot.data!.docs[index].get("total").toString();
                      this.precioTotal +=
                          snapshot.data!.docs[index].get("total");
                      // print(precioTotal);
                      precioT.text =
                          "TOTAL A PAGAR ---> " + precioTotal.toString();
                      this.idCart = snapshot.data!.docs[index].id;
                      return new Card(
                        child: new Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(15),
                              child: Row(children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Text(snapshot.data!.docs[index]
                                            .get("NombreItem"))),
                                    Text(
                                      snapshot.data!.docs[index]
                                          .get("PrecioItem")
                                          .toString(),
                                      style: TextStyle(
                                        color: Colors.green[500],
                                      ),
                                    ),
                                  ],
                                )),
                                Container(
                                  width: 80,
                                  height: 80,
                                  child: TextField(
                                    controller: precio,
                                  ),
                                ),
                                FloatingActionButton(
                                  onPressed: () {
                                    mensaje(
                                        "Borrar",
                                        "¿Desea borrar el artículo del carrito?",
                                        snapshot.data!.docs[index].id);
                                  },
                                  child: const Icon(Icons.remove),
                                  heroTag: null,
                                )
                              ]),
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
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                borrarIdCarrito(widget.idUser);
                Navigator.of(context).pop();
              },
              child: Text("PAGAR"),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: precioT,
            ),
          )
        ],
      ),
    );
  }

  void mensaje(String titulo, String mess, String idCart) {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: Text(titulo),
            content: Text(mess),
            actions: <Widget>[
              RaisedButton(
                onPressed: () {
                  borrarCarrito(idCart);
                  Navigator.of(context).pop();
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
