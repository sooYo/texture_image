extension SizeTrans on double {
  int get evenSize {
    final size = round();
    return size.isOdd ? size + 1 : size;
  }
}
