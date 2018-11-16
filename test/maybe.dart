import 'package:maybe/maybe.dart';
import "package:test/test.dart";

void main() {
  group("Maybe", () {
    group(".when", () {
      test("[isSome] is called with some value", () {
        // Defining a value
        var maybe = Maybe.some("hello world");
        var actual = "";
        when(maybe,
            isNothing: () => actual = "nothing",
            isSome: (String v) {
              actual = v;
            });
        expect(actual, equals("hello world"));
      });

      test("[isNothing] isn't called with some value", () {
        // Defining a value
        var maybe = Maybe.some("hello world");
        var actual = "";
        when(maybe, isNothing: () => actual = "nothing", isSome: (v) => "some");
        expect(actual, equals(""));
      });

      test("[isSome] isn't called with nothing", () {
        // Defining a value
        var maybe = Maybe<String>.nothing();
        var actual = "";
        when(maybe, isSome: (v) {
          actual = "some";
        });
        expect(actual, equals(""));
      });

      test("[isNothing] is called with nothing", () {
        // Defining a value
        var maybe = Maybe<String>.nothing();
        var actual = "";
        when(maybe, isNothing: () {
          actual = "nothing";
        });
        expect(actual, equals("nothing"));
      });

      test("[isNothing] is called with null", () {
        // Defining a value
        var actual = "";
        when(null, isNothing: () {
          actual = "nothing";
        });
        expect(actual, equals("nothing"));
      });

      test("[some] isn't called with null", () {
        // Defining a value
        var actual = "";
        when(null, isSome: (v) {
          actual = "some";
        });
        expect(actual, equals(""));
      });

      test("[some] is called with nothing and defaultValue", () {
        // Defining a value
        var maybe = Maybe<String>.nothing();
        var actual = "";
        when(maybe,
            isNothing: () {
              actual = "nothing";
            },
            isSome: (v) {
              actual = v;
            },
            defaultValue: () => "default");
        expect(actual, equals("default"));
      });

      test("[nothing] is called when nothingWhen is verified", () {
        // Defining a value
        var maybe = Maybe.some("nothing", nothingWhen: (v) => v == "nothing");
        var actual = "";
        when(maybe, isSome: (v) {
          actual = "some";
        });
        expect(actual, equals(""));
      });
    });

    group(".some", () {
      test("(nothing) returns defaultValue", () {
        // Defining a value
        var maybe = Maybe<String>.nothing();
        expect(some(maybe, "default"), equals("default"));
      });

      test("(null) returns defaultValue", () {
        // Defining a value
        expect(some(null, "default"), equals("default"));
      });

      test("(some) returns its value", () {
        // Defining a value
        var maybe = Maybe.some("value");
        expect(some(maybe, "default"), equals("value"));
      });
    });

    group(".nothing", () {
      test("(nothing) is true", () {
        var maybe = Maybe<String>.nothing();
        expect(nothing(maybe), equals(true));
      });

      test("(null) is true", () {
        expect(nothing(null), equals(true));
      });

      test("(some) is false", () {
        var maybe = Maybe.some("some");
        expect(nothing(maybe), equals(false));
      });
    });

    group(".flatten", () {
      test("(nothing) creates merged 'nothing'", () {
        // Defining a value
        var maybe = Maybe<Maybe<String>>.nothing();
        var flatten = Maybe.flatten(maybe);
        var actual = "";
        when(flatten, isNothing: () => actual = "nothing");
        expect(actual, equals("nothing"));
      });

      test("(some/nothing) creates merged 'nothing'", () {
        // Defining a value
        var maybe = Maybe.some(Maybe<String>.nothing());
        var flatten = Maybe.flatten(maybe);
        var actual = "";
        when(flatten, isNothing: () => actual = "nothing");
        expect(actual, equals("nothing"));
      });

      test("(some/some) creates merged 'some'", () {
        // Defining a value
        var maybe = Maybe.some(Maybe<String>.some("some"));
        var flatten = Maybe.flatten(maybe);
        var actual = "";
        when(flatten, isSome: (v) => actual = v);
        expect(actual, equals("some"));
      });
    });
  });
}
