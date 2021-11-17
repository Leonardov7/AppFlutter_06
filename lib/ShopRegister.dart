import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShopRegister extends StatefulWidget {
  @override
  ShopRegisterApp createState() => ShopRegisterApp();
}
//
class ShopRegisterApp extends State<ShopRegister> {
  @override
  TextEditingController nombreTienda =TextEditingController();
  TextEditingController rutaImagen=TextEditingController();
  TextEditingController descr_tienda=TextEditingController();
  TextEditingController webSite =TextEditingController();
  final firebase=FirebaseFirestore.instance;
  
  registrar() async{
    try{
      await firebase
          .collection("Tiendas")
          .doc()
          .set({
        "nombreTienda":nombreTienda.text,
        "ruta":rutaImagen.text,
        "descrip":descr_tienda.text,
        "webSite":webSite.text
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
        title: Text("Regisgtro de tiendas"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left:15,top: 15,right: 15,bottom: 0),
              // NOMBRE TIENDA
              child: TextField(
                  controller: nombreTienda,
                decoration: InputDecoration(
                    labelText: "Nombre tienda",
                    hintText: "Digite nombre de la tienda",
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
                controller: rutaImagen,
                decoration: InputDecoration(
                    labelText: "ruta de imagen",
                    hintText: "Digite ruta de la imagen",
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
                controller: descr_tienda,
                decoration: InputDecoration(
                    labelText: "descripcion tienda",
                    hintText: "Digite descripción de la tienda",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                    )
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left:15,top: 15,right: 15,bottom: 0),
              // PÁGINA WEB
              child: TextField(
                controller: webSite,
                decoration: InputDecoration(
                    labelText: "pagina web",
                    hintText: "Digite pagina web de la tienda",
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
                  registrar();
                  nombreTienda.clear();
                  rutaImagen.clear();
                  descr_tienda.clear();
                  webSite.clear();

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
