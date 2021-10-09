extension DoubleConvertion on double {
  int get evenSize {
    final size = round();
    return size.isOdd ? size + 1 : size;
  }
}

extension Compare on double {
  bool isEqualTo(double other, {double precision = 0.00001}) {
    return this - other <= precision;
  }
}
