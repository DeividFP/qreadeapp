import 'dart:async';
import 'package:qreaderapp/src/models/scan_model.dart';
import 'package:qreaderapp/src/providers/db_provider.dart';
export 'package:qreaderapp/src/providers/db_provider.dart';

class ScansBloc{
  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc(){
    return _singleton;
  }

  ScansBloc._internal(){
    //Obtener Scans de la base de datos
    obtenerScans();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scanStreams => _scansController.stream;

  dispose(){
    _scansController?.close();
  }

  obtenerScans() async{
    _scansController.sink.add(await DBProvider.db.getTodoScans());
  }

  agregarScan(ScanModel scan) async{
    await DBProvider.db.nuevoScan(scan);
    obtenerScans();
  }

  borrarScan(int id) async {
    await DBProvider.db.deleteScan(id);
    obtenerScans();
  } 

  borrarScanTODO() async{
    await DBProvider.db.deleteAll();
    obtenerScans();
  }

}