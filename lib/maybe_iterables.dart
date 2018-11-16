import 'package:maybe/maybe.dart';

/**
* Returns a new lazy [Iterable] with all elements with a value in [maybeIterable].
*
* The matching elements have the same order in the returned iterable
* as they have in [maybeIterable].
*/
Iterable<T> filter<T>(Iterable<Maybe<T>> maybeIterable) {
  return (maybeIterable == null)
      ? Iterable.empty<T>()
      : maybeIterable.where((v) => !isNothing(v)).map((v) => some(v, null));
}

/**
 * Applies the function [f] to each element with a value of [maybeIterable] collection 
 * in iteration order.
 */
void forEach<T>(Iterable<Maybe<T>> maybeIterable, void f(T element)) {
  if (maybeIterable != null) {
    maybeIterable
        .where((v) => !isNothing(v))
        .map((v) => some(v, null))
        .forEach(f);
  }
}

/**
 * Returns the number of elements with a value in [maybeIterable].
 */
int count<T>(Iterable<Maybe<T>> maybeList) {
  return (maybeList == null) ? 0 : maybeList.where((v) => !isNothing(v)).length;
}
