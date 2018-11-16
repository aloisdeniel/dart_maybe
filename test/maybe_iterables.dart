import 'package:maybe/maybe.dart';
import 'package:maybe/maybe_iterables.dart';
import "package:test/test.dart";

void main() {
  group("Iterables", () {
    var maybeList = [
      Maybe.some("start"),
      Maybe.nothing(),
      null,
      Maybe.some("middle"),
      Maybe.nothing(),
      Maybe.some("end"),
    ];

    group(".filter", () {
      test("filters items with values", () {
        var filtered = filter(maybeList);
        expect(filtered.length, equals(3));
        expect(filtered.elementAt(0), equals("start"));
        expect(filtered.elementAt(1), equals("middle"));
        expect(filtered.elementAt(2), equals("end"));
      });

      test("empty list with null", () {
        var filtered = filter(null);
        expect(filtered.length, equals(0));
      });
    });

    group(".forEach", () {
      test("iterates through items with values", () {
        var filtered = [];
        forEach(maybeList, (item) {
          filtered.add(item);
        });
        expect(filtered.length, equals(3));
        expect(filtered.elementAt(0), equals("start"));
        expect(filtered.elementAt(1), equals("middle"));
        expect(filtered.elementAt(2), equals("end"));
      });
      test("empty iterator with null", () {
        forEach(null, (item) {
          throw Error();
        });
      });
    });

    group(".count", () {
      test("count items with values", () {
        expect(count(maybeList), equals(3));
      });
      test("zero items with null", () {
        expect(count(null), equals(0));
      });
    });
  });
}
