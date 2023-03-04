// Import the test package and Counter class
import 'package:track_your_stop/utils/string.util.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Array is converted to string correctly', () {
    final List<String> input = ["Stop1", "Stop2"];
    const String expected = "Stop1,Stop2";
    final String result = convertArrayToString(input);

    expect(result, expected);
  });

  test('Array is converted to string correctly with custom separator', () {
    final List<String> input = ["Stop1", "Stop2"];
    const String expected = "Stop1;Stop2";
    final String result = convertArrayToString(input, separator: ";");

    expect(result, expected);
  });

  test('String is converted to array correctly', () {
    const String input = "Stop1,Stop2";
    final List<String> expected = ["Stop1", "Stop2"];
    final List<String> result = convertStringToArray(input);

    expect(result, expected);
  });

  test('String is converted to array correctly with custom separator', () {
    const String input = "Stop1;Stop2";
    final List<String> expected = ["Stop1", "Stop2"];
    final List<String> result = convertStringToArray(input, separator: ";");

    expect(result, expected);
  });
}