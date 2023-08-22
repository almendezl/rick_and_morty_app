String generateLength(int start, int end) {
  List<int> numbers = List<int>.generate(end - start + 1, (i) => start + i);
  numbers.remove(0);
  String output = numbers.join(',');

  return output;
}
