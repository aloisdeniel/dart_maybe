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
            nothing: () => actual = "nothing",
            some: (String v) {
              actual = v;
            });
        expect(actual, equals("hello world"));
      });

      test("[isNothing] isn't called with some value", () {
        // Defining a value
        var maybe = Maybe.some("hello world");
        var actual = "";
        when(maybe, nothing: () => actual = "nothing", some: (v) => "some");
        expect(actual, equals(""));
      });

      test("[isSome] isn't called with nothing", () {
        // Defining a value
        var maybe = Maybe<String>.nothing();
        var actual = "";
        when(maybe, some: (v) {
          actual = "some";
        });
        expect(actual, equals(""));
      });

      test("[isNothing] is called with nothing", () {
        // Defining a value
        var maybe = Maybe<String>.nothing();
        var actual = "";
        when(maybe, nothing: () {
          actual = "nothing";
        });
        expect(actual, equals("nothing"));
      });

      test("[isNothing] is called with null", () {
        // Defining a value
        var actual = "";
        when(null, nothing: () {
          actual = "nothing";
        });
        expect(actual, equals("nothing"));
      });

      test("[some] isn't called with null", () {
        // Defining a value
        var actual = "";
        when(null, some: (v) {
          actual = "some";
        });
        expect(actual, equals(""));
      });

      test("[some] is called with nothing and defaultValue", () {
        // Defining a value
        var maybe = Maybe<String>.nothing();
        var actual = "";
        when(maybe,
            nothing: () {
              actual = "nothing";
            },
            some: (v) {
              actual = v;
            },
            defaultValue: () => "default");
        expect(actual, equals("default"));
      });

      test("[nothing] is called when nothingWhen is verified", () {
        // Defining a value
        var maybe = Maybe.some("nothing", nothingWhen: (v) => v == "nothing");
        var actual = "";
        when(maybe, some: (v) {
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

    group(".isNothing", () {
      test("(nothing) is true", () {
        var maybe = Maybe<String>.nothing();
        expect(isNothing(maybe), equals(true));
      });

      test("(null) is true", () {
        expect(isNothing(null), equals(true));
      });

      test("(some) is false", () {
        var maybe = Maybe.some("some");
        expect(isNothing(maybe), equals(false));
      });
    });

    group(".flatten", () {
      test("(nothing) creates merged 'nothing'", () {
        // Defining a value
        var maybe = Maybe<Maybe<String>>.nothing();
        var flatten = Maybe.flatten(maybe);
        var actual = "";
        when(flatten, nothing: () => actual = "nothing");
        expect(actual, equals("nothing"));
      });

      test("(some/nothing) creates merged 'nothing'", () {
        // Defining a value
        var maybe = Maybe.some(Maybe<String>.nothing());
        var flatten = Maybe.flatten(maybe);
        var actual = "";
        when(flatten, nothing: () => actual = "nothing");
        expect(actual, equals("nothing"));
      });

      test("(some/some) creates merged 'some'", () {
        // Defining a value
        var maybe = Maybe.some(Maybe<String>.some("some"));
        var flatten = Maybe.flatten(maybe);
        var actual = "";
        when(flatten, some: (v) => actual = v);
        expect(actual, equals("some"));
      });
    });
    group(".mapSome", () {
      test("(nothing) returns nothing'", () {
        var maybe = Maybe.nothing<String>();
        var converter = mapSome<String, int>(maybe, (v) => v.length);
        expect(isNothing(converter), equals(true));
      });

      test("(null) returns nothing'", () {
        var converter = mapSome<String, int>(null, (v) => v.length);
        expect(isNothing(converter), equals(true));
      });

      test("(some) returns a converted value'", () {
        var maybe = Maybe.some("hello world");
        var converter = mapSome<String, int>(maybe, (v) => v.length);
        expect(some(converter, 0), equals(11));
      });
    });

    group("==", () {
      test("(some-x/some-x) is true", () {
        var m1 = Maybe.some("hello world");
        var m2 = Maybe.some("hello world");
        expect(m1 == m2, equals(true));
      });

      test("(some-x/some-y) is false", () {
        var m1 = Maybe.some("hello world");
        var m2 = Maybe.some("world hello");
        expect(m1 == m2, equals(false));
      });

      test("(some-x/nothing) is false", () {
        var m1 = Maybe.some("hello world");
        var m2 = Maybe<String>.nothing();
        expect(m1 == m2, equals(false));
      });

      test("(nothing/some-x) is false", () {
        var m1 = Maybe<String>.nothing();
        var m2 = Maybe.some("hello world");
        expect(m1 == m2, equals(false));
      });

      test("(nothing/nothing) is true", () {
        var m1 = Maybe<String>.nothing();
        var m2 = Maybe<String>.nothing();
        expect(m1 == m2, equals(true));
      });

      test("(nothing/null) is true", () {
        var m1 = Maybe<String>.nothing();
        String m2 = null;
        expect(m1 == m2, equals(true));
      });

      test("(null/nothing) is true", () {
        var m1 = Maybe<String>.nothing();
        String m2 = null;
        expect(m1 == m2, equals(true));
      });
    });
  });
}
