class User {
  String _userName = "";
  double _weight = 0;
  double _height = 0;

  User(this._height, this._userName, this._weight);

  String get userName => _userName;
  double get weight => _weight;
  double get height => _height;

  set userName(String u) {
    if (u != "") {
      _userName = u;
    }
  }

  set weight(double w) {
    if (w > 0 && w < 200) {
      _weight = w;
    }
  }

  set height(double h) {
    if (h > 0 && h < 2.30) {
      _height = h;
    }
  }
}
