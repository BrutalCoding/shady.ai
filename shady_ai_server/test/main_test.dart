import 'package:test/test.dart';

// This is a simple test that just checks that the test framework is working.
void main() {
  group('math', () {
    test('addition', () {
      expect(1 + 1, equals(2));
    });

    test('subtraction', () {
      expect(1 - 1, equals(0));
    });
  });

  group('string', () {
    test('concatenation', () {
      expect('hello' 'world', equals('helloworld'));
    });

    test('substring', () {
      expect('hello world'.substring(0, 5), equals('hello'));
    });
  });
}
