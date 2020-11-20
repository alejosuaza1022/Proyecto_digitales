import 'package:flutter/material.dart';
import 'package:digitales_proyecto/resources/exampledb.dart';
import 'package:digitales_proyecto/helpers/helpers.dart';
import 'package:digitales_proyecto/resources/controllerFirebase.dart';

class PrincipalPage extends StatelessWidget {
  final callback;
  final contenedor;
  const PrincipalPage({Key key, this.callback, this.contenedor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return scaffold(context);
  }

  Widget scaffold(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    ;
    double heigh = MediaQuery.of(context).size.height;
    ;
    DateTime date;
    MyFireBase firebase = MyFireBase();
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Center(child: Text('Comedero Mascotas')),
        ),
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 290,
                  height: 290,
                  child: Image(
                    image: AssetImage('images/dogimg.png'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        height: 50,
                        width: (width - 50) / 2,
                        child: Functions.button_defined(
                            "ver datos firebase",
                            () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return CustomData(
                                          mifirebase: firebase,
                                        );
                                      },
                                    ),
                                  )
                                },
                            Icons.cloud_download)),
                    SizedBox(
                      width: 40,
                    ),
                    Container(
                      height: 50,
                      width: (width - 50) / 2,
                      child: Functions.button_defined(
                          "Servir comida",
                          () =>
                              {firebase.registrar_en_firebase(), callback("1")},
                          Icons.fastfood),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  height: 50,
                  width: (width) / 2,
                  child: Functions.button_defined(
                      "Programar Comida",
                      () => {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime(2021))
                                .then((value) => date = value)
                          },
                      Icons.calendar_today),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                            height: 50,
                            child: Functions.button_defined(
                                "CANTIDAD EN CONTENEDOR \n ${this.contenedor}%",
                                () => {},
                                Icons.storage)),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            width: 120,
                            height: 120,
                            child: Image(
                              image: AssetImage('images/jar.png'),
                            )),
                      ],
                    ),
                  ],
                )
              ]),
        ));
  }
}
