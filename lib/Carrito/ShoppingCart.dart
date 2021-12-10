import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShoppingCart extends StatefulWidget {
  @override
  ShoppingCartApp createState() => ShoppingCartApp();
}

class ShoppingCartApp extends State<ShoppingCart> {
  double precioTotal=0;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrito"),
      ),
      body:
      Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("Carrito").snapshots(),
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length, // define las iteraciones
                  itemBuilder: (BuildContext context, int index) {
                    TextEditingController precio = TextEditingController();
                    precio.text =
                        snapshot.data!.docs[index].get("total").toString();
                    this.precioTotal+=snapshot.data!.docs[index].get("total");
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
                                      padding: const EdgeInsets.only(bottom: 10),
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
                                onPressed: () {},
                                child: const Icon(Icons.remove),
                                heroTag: null,
                              )
                            ]),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
          padding: EdgeInsets.all(20),
            child: Text(this.precioTotal.toString()),
          )
        ],
      ),
    );
  }
}
