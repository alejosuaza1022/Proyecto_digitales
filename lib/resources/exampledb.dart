import 'package:flutter/material.dart';

import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:digitales_proyecto/resources/controllerFirebase.dart';

class CustomData extends StatefulWidget {
  CustomData({this.mifirebase});
  final mifirebase;

  @override
  _CustomDataState createState() => _CustomDataState();
}

class _CustomDataState extends State<CustomData> {
  final dbrefe = FirebaseDatabase.instance;
  final movieController = TextEditingController();
  String moviename = "lepepe";
  MyFireBase _collectionref;

  @override
  void initState() {
    _collectionref = widget.mifirebase;
  }

  @override
  Widget build(BuildContext context) {
    final ref = dbrefe.reference();
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "DATOS REGISTRADOS DB",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/imgpet.jpg"), fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                    width: 330,
                    height: 150,
                    child: Image(
                      fit: BoxFit.fitHeight,
                      image: AssetImage('images/stadistics.png'),
                    )),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: <Widget>[Flexible(child: get_table(context))],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

/**
 * generate the rows for the table
 */
  List<DataRow> rows(data) {
    var ressp = data;
    print(ressp);
    Map map = Map.of(ressp);
    List lista_keys = map.keys.toList();
    List lista_values = map.values.map((e) => e).toList();
    List<DataRow> list = List();
    for (var i = 0; i < lista_keys.length; i++) {
      var number = lista_values[i]['contador'];
      list.add(_data_rows(lista_keys[i], number * 30));
    }
    return list;
  }

/**
 * generate data the rows for the tables
 */
  DataRow _data_rows(a, b) {
    return DataRow(cells: <DataCell>[
      DataCell(Text(
        a.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
      )),
      DataCell(Container(
        width: 200,
        child: Text(
          b.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
        ),
      )),
    ]);
  }

/**
 * generate the table
 * through the data got from firebase
 */
  FutureBuilder get_table(BuildContext context) {
    return FutureBuilder(
        future: _collectionref.obtene_datos_firebase(),
        builder: (context, snapshot) {
          final estado = snapshot.connectionState;
          if (estado == ConnectionState.done) {
            if (snapshot.hasData) {
              Map<dynamic, dynamic> values = snapshot.data;
              values.forEach((key, values) {
                print(values);
              });
              return Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/imgpet.jpg"),
                        fit: BoxFit.cover)),
                width: MediaQuery.of(context).size.width - 20,
                child: Card(
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0)),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Color.fromRGBO(200, 20, 55, 1)),
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: [
                            DataColumn(
                                label: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Text(
                                "Día",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 23, fontStyle: FontStyle.italic),
                              ),
                            )),
                            DataColumn(
                                label: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                "Consumo diario (g)",
                                style: TextStyle(
                                    fontSize: 23, fontStyle: FontStyle.italic),
                              ),
                            ))
                          ],
                          rows: rows(values),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
            return Text("no data");
          }
          return CircularProgressIndicator();
        });
  }
}
