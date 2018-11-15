import 'package:maybe/maybe.dart';
import "package:test/test.dart";

void main() {
  group("Maybe", () {
    test(".when/some is called with some value", () {
      // Defining a value
      var maybe = Maybe<String>.some("hello world");
      var actual = "";
      Maybe.when<String>(maybe, some: (v) {
        actual = v;
      });
      expect(actual, equals("hello world"));
    });

    test(".when/nothing isn't called with some value", () {
      // Defining a value
      var maybe = Maybe<String>.some("hello world");
      var actual = "";
      Maybe.when<String>(maybe, nothing: () {
        actual = "nothing";
      });
      expect(actual, equals(""));
    });

    test(".when/some isn't called with nothing", () {
      // Defining a value
      var maybe = Maybe<String>.nothing();
      var actual = "";
      Maybe.when<String>(maybe, some: (v) {
        actual = "some";
      });
      expect(actual, equals(""));
    });

    test(".when/nothing is called with nothing", () {
      // Defining a value
      var maybe = Maybe<String>.nothing();
      var actual = "";
      Maybe.when<String>(maybe, nothing: () {
        actual = "nothing";
      });
      expect(actual, equals("nothing"));
    });

    test(".when/some is called with nothing and defaultValue", () {
      // Defining a value
      var maybe = Maybe<String>.nothing();
      var actual = "";
      Maybe.when<String>(maybe,
          nothing: () {
            actual = "nothing";
          },
          some: (v) {
            actual = v;
          },
          defaultValue: () => "default");
      expect(actual, equals("default"));
    });

    test(".when/nothing is called when nothingWhen is verified", () {
      // Defining a value
      var maybe =
          Maybe<String>.some("nothing", nothingWhen: (v) => v == "nothing");
      var actual = "";
      Maybe.when<String>(maybe, some: (v) {
        actual = "some";
      });
      expect(actual, equals(""));
    });
  });
}
