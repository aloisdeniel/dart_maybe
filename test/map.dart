import 'package:maybe/maybe.dart';
import "package:test/test.dart";

void main() {
  group("MaybeMap", () {
    group("fromMap", () {
      test("valid map", () {
        final map = <String, String>{
          "1": "2",
          "3": "4",
          "5": null,
        };
        final maybe = MaybeMap.fromMap(map);

        expect(maybe.isNotEmpty, equals(true));

        var actual1 = maybe["1"];
        expect(isNothing(actual1), equals(false));
        expect(actual1, Maybe.some("2"));

        var actual3 = maybe["3"];
        expect(isNothing(actual3), equals(false));
        expect(actual3, Maybe.some("4"));

        var actual5 = maybe["5"];
        expect(isNothing(actual5), equals(false));
        expect(actual5, Maybe<String>.some(null, nullable: true));

        var actual7 = maybe["7"];
        expect(isNothing(actual7), equals(true));
      });
    });

    group("[]", () {
      test("contained value", () {
        var map = MaybeMap<String, String>();
        map["1"] = Maybe.some("2");
        var actual = map["1"];
        expect(isNothing(actual), equals(false));
        expect(actual, Maybe.some("2"));
      });
      test("not containted value", () {
        var map = MaybeMap<String, String>();
        map["1"] = Maybe.some("2");
        var actual = map["2"];
        expect(isNothing(actual), equals(true));
      });
      test("empty added value", () {
        var map = MaybeMap<String, String>();
        map["1"] = Maybe<String>.nothing();
        var actual = map["1"];
        expect(isNothing(actual), equals(true));
      });
    });
    group("addAll", () {
      test("added values", () {
        var map1 = MaybeMap<String, String>();
        var map2 = MaybeMap<String, String>();
        map2["1"] = Maybe.some("2");
        map2["3"] = Maybe.some("4");
        map2["5"] = Maybe.nothing();

        map1.addAll(map2);

        expect(map2.isNotEmpty, equals(true));

        var actual1 = map1["1"];
        expect(isNothing(actual1), equals(false));
        expect(actual1, Maybe.some("2"));

        var actual3 = map1["3"];
        expect(isNothing(actual3), equals(false));
        expect(actual3, Maybe.some("4"));

        var actual5 = map1["5"];
        expect(isNothing(actual5), equals(true));
      });
    });
    group("containsKey", () {
      test("doesn't contain", () {
        var map = MaybeMap<String, String>();
        expect(map.containsKey("1"), equals(false));
      });

      test("doesn't contain added nothing", () {
        var map = MaybeMap<String, String>();
        map["1"] = Maybe.nothing();
        expect(map.containsKey("1"), equals(false));
      });

      test("contains added some", () {
        var map = MaybeMap<String, String>();
        map["1"] = Maybe.some("2");
        expect(map.containsKey("1"), equals(true));
      });

      test("nothing added removes an old some value", () {
        var map = MaybeMap<String, String>();

        map["1"] = Maybe<String>.some("2");
        var actual = map["1"];
        expect(isNothing(actual), equals(false));
        expect(actual, Maybe.some("2"));

        map["1"] = Maybe<String>.nothing();
        actual = map["1"];
        expect(isNothing(actual), equals(true));
        expect(map.containsKey("1"), equals(false));
      });
    });
  });
}
