import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

/** the used of that is map the realtime data base to code to be able
 * to use it through the code
 */
class MyFireBase {
  FirebaseDatabase database;
  DatabaseReference collectionref;
  MyFireBase() {
    database = FirebaseDatabase();
    collectionref = database.reference().child('Mascota');
  }
  void registrar_en_firebase() async {
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    String date_to = date.toString().split(" ")[0];
    int cont = 1;
    var aux = await obtener_cantidad_firebase(date_to);
    if (aux != null) cont += new Map<dynamic, dynamic>.from(aux)['contador'];
    collectionref
        .child("Max")
        .child(date_to)
        .set({"contador": cont}).asStream();
  }

  Future<dynamic> obtener_cantidad_firebase(date) async {
    return collectionref
        .child("Max")
        .child(date)
        .once()
        .then((value) => value.value)
        .catchError((error) => print(error));
  }

  Future<dynamic> obtene_datos_firebase() async {
    return collectionref
        .child("Max")
        .once()
        .then((value) => value.value)
        .catchError((error) => print(error));
  }
}
