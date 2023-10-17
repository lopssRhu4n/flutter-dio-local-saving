import 'package:hive/hive.dart';
import 'package:imc_app/models/imc_model.dart';

class IMCRepository {
  static const boxName = 'imcModel';
  static late Box _box;

  IMCRepository._create();

  static Future<IMCRepository> carregar() async {
    if (Hive.isBoxOpen(boxName)) {
      _box = Hive.box(boxName);
    } else {
      _box = await Hive.openBox(boxName);
    }
    return IMCRepository._create();
  }

  List<IMCModel> listAll() {
    return _box.values.cast<IMCModel>().toList();
  }

  void saveNew(IMCModel imc) {
    _box.add(imc);
  }

  void delete(IMCModel imc) {
    imc.delete();
  }

  bool isEmpty() {
    return listAll().isEmpty;
  }
}
