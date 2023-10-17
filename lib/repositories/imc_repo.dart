import 'package:imc_app/classes/imc.dart';

class IMCRepository {
  final List<IMC> _list = [];

  List<IMC> listAll() {
    return _list;
  }

  void saveNew(IMC imc) {
    _list.add(imc);
  }

  void delete(IMC imc) {
    _list.remove(imc);
  }

  bool isEmpty() {
    return _list.isEmpty;
  }
}
