import 'package:flutter/material.dart';
import 'package:digitales_proyecto/resources/exampledb.dart';
import 'package:digitales_proyecto/helpers/helpers.dart';
import 'package:digitales_proyecto/resources/controllerFirebase.dart';

class PrincipalPage extends StatelessWidget {
  const PrincipalPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return scaffold(context);
  }

  Widget scaffold(BuildContext context) {
    DateTime date;
    MyFireBase firebase = MyFireBase();
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Center(child: Text('Comedero Mascotas')),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 330,
                height: 330,
                child: Image(
                  image: AssetImage('images/dogimg.png'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      height: 50,
                      width: 180,
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
                    width: 180,
                    child: Functions.button_defined(
                        "Servir comida",
                        () => {firebase.registrar_en_firebase()},
                        Icons.fastfood),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                height: 50,
                width: 200,
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
            ]));
  }
}
